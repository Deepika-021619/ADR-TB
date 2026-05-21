import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fld_questionnaire_screen.dart';
import 'sld_questionnaire_screen.dart';
import 'timer_widget.dart';


class DrugDetailsScreen extends StatefulWidget {
  final String portal;
  final String reportId;

  const DrugDetailsScreen({
    super.key,
    required this.portal,
    required this.reportId,
  });

  @override
  State<DrugDetailsScreen> createState() => _DrugDetailsScreenState();
}

class _DrugDetailsScreenState extends State<DrugDetailsScreen> {
  List<Map<String, dynamic>> regimens = [];
  int? selectedRegimenId;
  bool isLoading = false;
  
  bool isLoadingRegimens = true;

  final _formKey = GlobalKey<FormState>();
  
  // Form Controllers - CLEAN
  final _timeValueController = TextEditingController();
  String? selectedTimeUnit;
  String? _oralOnlyValue;
  String? _prevRegimenValue;
  bool isFdc = false;
  final _brandNameController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _doseController = TextEditingController();
  final _frequencyController = TextEditingController();
 
  final _injectableController = TextEditingController();
 
  final _prevDetailsController = TextEditingController();
  final _prevDurationController = TextEditingController();
 

  final List<String> timeUnits = ['Days', 'Weeks', 'Months', 'Years'];


@override
void initState() {

  super.initState();

  loadRegimens();
}

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> loadRegimens() async {
    try {
      final response = await http.get(
       Uri.parse("http://127.0.0.1:8000/tb_regimen/regimens"),
        headers: {"Accept": "application/json"},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        setState(() {
          regimens = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          isLoadingRegimens = false;
        });
      } else {
        _showError("Failed to load regimens");
        setState(() => isLoadingRegimens = false);
      }
    } catch (e) {
      _showError("Network error: $e");
      setState(() => isLoadingRegimens = false);
    }
  }

  void _onRegimenSelected(int? id) {
    setState(() {
      selectedRegimenId = id;
    });
  }

  Future<void> saveDrugDetails() async {
    if (!_formKey.currentState!.validate() || selectedRegimenId == null) {
      _showError("Please fill all required fields and select regimen");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/tb_regimen/drug_details"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
        "report_id": widget.reportId,
        "regimen_id": selectedRegimenId,
        "time_since_value": int.tryParse(_timeValueController.text ?? '') ?? 0,
        "time_since_unit": selectedTimeUnit ?? "Months",
        "is_fdc": (isFdc ?? false).toString(),
        "brand_name": _brandNameController.text ?? "",
        "batch_number": _batchNumberController.text ?? "",
        "dose_description": _doseController.text ?? "",
        "tablet_frequency": _frequencyController.text ?? "",
        "oral_only": _oralOnlyValue ?? "Yes",           
        "injectable_details": _injectableController.text ?? "",
        "previous_regimen_taken": _prevRegimenValue ?? "No",  
        "previous_regimen_details": _prevDetailsController.text ?? "",
        "duration_previous_regimen": int.tryParse(_prevDurationController.text ?? '') ?? 0,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
  final data = jsonDecode(response.body);

  final selectedRegimen = regimens.firstWhere(
  (r) => r['regimen_id'] == selectedRegimenId,
);

final String regimenType = selectedRegimen['regimen_type'];

print("Selected regimen type: $regimenType"); // DEBUG
  
  // 💙 NEW NAVIGATION - direct to FLD/SLD based on selection
     if (regimenType == "FLD") {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => FLDQuestionnaireScreen(
  reportId: widget.reportId,
),
    ),
  );
} else if (regimenType == "SLD") {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => SLDQuestionnaireScreen(
        reportId: widget.reportId,
        portal: widget.portal,
      ),
    ),
  );
}

      } else {
        _showError("Failed to save: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Network error: $e");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TB Regimen - ${widget.reportId}"),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: TimerWidget(),
          ),
        ],
      ),
      body: isLoadingRegimens
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // REPORT ID HEADER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_pharmacy, color: Colors.blue.shade600),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Report ID: ${widget.reportId}",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade800,
                                      ),
                                ),
                                Text(
                                  "Complete Drug Details Questionnaire",
                                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 1. TB REGIMEN DROPDOWN * 
Text("• Select TB Regimen *", style: Theme.of(context).textTheme.titleMedium),
const SizedBox(height: 8),
DropdownButtonFormField<int>(
  value: selectedRegimenId,
  hint: Text("Choose regimen", style: TextStyle(color: Colors.grey[600])),
  validator: (value) => value == null ? 'Required' : null,
  isExpanded: true,
  
  // ✅ NO DROPDOWN ARROW ICON
  icon: SizedBox.shrink(),
  
  items: regimens.map<DropdownMenuItem<int>>((regimen) {
    final type = regimen['regimen_type'] == 'FLD' ? 'FLD' : 'SLD';
    
    return DropdownMenuItem<int>(
      value: regimen['regimen_id'],
      child: Row(
        children: [
          // ✅ COMPACT SINGLE LINE
          Expanded(
            child: Text(
              "${regimen['regimen_name']} (${type})",
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }).toList(),
  
  onChanged: _onRegimenSelected,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16, 
      vertical: 12  
    ),
    filled: true,
    fillColor: Colors.blue.shade50,
  ),
),
const SizedBox(height: 20),

                    // 2. TIME SINCE FIELDS *
                    Text("• Time since the above combination/drug taken *", style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _timeValueController,
                            keyboardType: TextInputType.number,
                            validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            decoration: InputDecoration(
                              hintText: "Value (e.g., 6)",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedTimeUnit,
                            hint: const Text("Unit"),
                            validator: (value) => value == null ? 'Required' : null,
                            items: timeUnits.map((u) => 
                                DropdownMenuItem(value: u, child: Text(u))).toList(),
                            onChanged: (value) => setState(() => selectedTimeUnit = value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 3. FDC SWITCH
                    SwitchListTile(
                      title: const Text("• Are you taking FDC?"),
                      subtitle: const Text("(Fixed Dose Combination)"),
                      value: isFdc ?? false,
                      onChanged: (v) {
  setState(() {
    isFdc = v;

    // Auto-clear fields when FDC selected
    if (v) {
      _brandNameController.clear();
      _batchNumberController.clear();
      _doseController.clear();
      _frequencyController.clear();
    }
  });
},
                      activeColor: Colors.blue.shade600,
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 20),

                    // 4. BRAND NAME *
                    TextFormField(
  controller: _brandNameController,

  enabled: !isFdc,
  readOnly: isFdc,

  style: TextStyle(
    color: isFdc ? Colors.grey : null,
  ),

  decoration: InputDecoration(
    hintText: isFdc
        ? "Unavailable for FDC"
        : "• Brand name of the drug taken (if available)",

    border: const OutlineInputBorder(),

    filled: isFdc,
    fillColor: isFdc ? Colors.grey[100] : null,
  ),

  validator: (v) => null,
),
                    const SizedBox(height: 16),

                    // 5. BATCH NUMBER *
                    TextFormField(
  controller: _batchNumberController,

  enabled: !isFdc,
  readOnly: isFdc,

  style: TextStyle(
    color: isFdc ? Colors.grey : null,
  ),

  decoration: InputDecoration(
    hintText: isFdc
        ? "Unavailable for FDC"
        : "• Batch number (if available)",

    border: const OutlineInputBorder(),

    filled: isFdc,
    fillColor: isFdc ? Colors.grey[100] : null,
  ),

  validator: (v) => null,
),
                    const SizedBox(height: 16),

                    // 6. DOSE *
                    TextFormField(
  controller: _doseController,

  enabled: !isFdc,
  readOnly: isFdc,

  style: TextStyle(
    color: isFdc ? Colors.grey : null,
  ),

  decoration: InputDecoration(
    hintText: isFdc
        ? "Unavailable for FDC"
        : "• Dose (in mg) *",

    border: const OutlineInputBorder(),

    filled: isFdc,
    fillColor: isFdc ? Colors.grey[100] : null,
  ),

  validator: (v) {
    if (isFdc) return null;
    return v?.isEmpty ?? true ? 'Required' : null;
  },
),
                    const SizedBox(height: 16),

                    // 7. FREQUENCY
                   TextFormField(
  controller: _frequencyController,

  enabled: !isFdc,
  readOnly: isFdc,

  style: TextStyle(
    color: isFdc ? Colors.grey : null,
  ),

  decoration: InputDecoration(
    hintText: isFdc
        ? "Unavailable for FDC"
        : "• Number of tablets taken per day *",

    border: const OutlineInputBorder(),

    filled: isFdc,
    fillColor: isFdc ? Colors.grey[100] : null,
  ),

  validator: (v) {
    if (isFdc) return null;
    return v?.isEmpty ?? true ? 'Required' : null;
  },
),
                    const SizedBox(height: 40),
                    Text("• Are all drugs taken in oral formulation? *", style: Theme.of(context).textTheme.titleMedium),
DropdownButtonFormField<String>(
  value: _oralOnlyValue,
  hint: const Text("Select Yes/No"),
  validator: (v) => v == null ? 'Required' : null,
  isExpanded: true,
  items: ['Yes', 'No'].map((v) => 
    DropdownMenuItem(value: v, child: Text(v))
  ).toList(),
  onChanged: (v) {
     setState(() {
      _oralOnlyValue = v;
      // ✅ AUTO-CLEAR injectable when switching to Yes
      if (v == 'Yes') {
        _injectableController.clear();
      }
    });
  },
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
),
const SizedBox(height: 16),

// 9. INJECTABLE DETAILS (keep as-is, but remove * if oral_only=Yes)
Text("• What are the drugs taken as injectable? (route in parenthesis)", 
     style: Theme.of(context).textTheme.titleMedium?.copyWith(
       color: _oralOnlyValue == 'Yes' ? Colors.grey : null,  
     )),
TextFormField(
  controller: _injectableController,
  enabled: _oralOnlyValue != 'Yes',  
  readOnly: _oralOnlyValue == 'Yes', 
  style: TextStyle(
    color: _oralOnlyValue == 'Yes' ? Colors.grey : null,
  ),
  decoration: InputDecoration(
    hintText: _oralOnlyValue == 'Yes' 
        ? " Oral only selected"  
        : "e.g., Amikacin (IM)",
    hintStyle: TextStyle(
      color: _oralOnlyValue == 'Yes' ? Colors.grey : Colors.grey[600],
    ),
    border: OutlineInputBorder(),
    filled: _oralOnlyValue == 'Yes',
    fillColor: _oralOnlyValue == 'Yes' ? Colors.grey[100] : null,
  ),
),
const SizedBox(height: 16),

// ✅ 10. PREVIOUS REGIMEN * (REPLACE TEXT FIELD)
Text("• Did the patient take any other combination before current medication? *", 
     style: Theme.of(context).textTheme.titleMedium),
DropdownButtonFormField<String>(
  value: _prevRegimenValue,
  hint: const Text("Select Yes/No"),
  validator: (v) => v == null ? 'Required' : null,
  isExpanded: true,
  items: ['Yes', 'No'].map((v) => 
    DropdownMenuItem(value: v, child: Text(v))
  ).toList(),
  onChanged: (v) {
    setState(() {
      _prevRegimenValue = v;
      // ✅ AUTO-CLEAR when switching to "No"
      if (v == 'No') {
        _prevDetailsController.clear();
        _prevDurationController.clear();
      }
    });
  },
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
),
const SizedBox(height: 16),

// 11. PREVIOUS DRUG DETAILS 
Text("• Name of previous drug and brand (in parenthesis)", 
     style: Theme.of(context).textTheme.titleMedium?.copyWith(
       color: _prevRegimenValue == 'No' ? Colors.grey : null,  // ✅ Grey when No
     )),
TextFormField(
  controller: _prevDetailsController,
  enabled: _prevRegimenValue == 'Yes',       
  readOnly: _prevRegimenValue == 'No',       
  style: TextStyle(
    color: _prevRegimenValue == 'No' ? Colors.grey : null,
  ),
  decoration: InputDecoration(
    hintText: _prevRegimenValue == 'No' 
        ? "No previous regimen" 
        : "e.g., Rifampicin (Rifater)",
    hintStyle: TextStyle(
      color: _prevRegimenValue == 'No' ? Colors.grey : Colors.grey[600],
    ),
    border: OutlineInputBorder(),
    filled: _prevRegimenValue == 'No',
    fillColor: _prevRegimenValue == 'No' ? Colors.grey[100] : null,
  ),
),
const SizedBox(height: 16),

// 12. PREVIOUS DURATION *
Text("• How long was previous drug taken for? (days)", 
     style: Theme.of(context).textTheme.titleMedium?.copyWith(
       color: _prevRegimenValue == 'No' ? Colors.grey : null,  // ✅ Grey when No
     )),
TextFormField(
  controller: _prevDurationController,
  keyboardType: TextInputType.number,
  enabled: _prevRegimenValue == 'Yes',        
  readOnly: _prevRegimenValue == 'No',        
  style: TextStyle(
    color: _prevRegimenValue == 'No' ? Colors.grey : null,
  ),
  decoration: InputDecoration(
    hintText: _prevRegimenValue == 'No' 
        ? "No previous regimen" 
        : "Duration in days",
    hintStyle: TextStyle(
      color: _prevRegimenValue == 'No' ? Colors.grey : Colors.grey[600],
    ),
    border: OutlineInputBorder(),
    filled: _prevRegimenValue == 'No',
    fillColor: _prevRegimenValue == 'No' ? Colors.grey[100] : null,
  ),
),
const SizedBox(height: 16),

                    // SAVE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading || selectedRegimenId == null 
                            ? null 
                            : saveDrugDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade400,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2, 
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : const Text(
                                "Save & Continue", 
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
void dispose() {
  _timeValueController.dispose();
  _brandNameController.dispose();
  _batchNumberController.dispose();
  _doseController.dispose();
  _frequencyController.dispose();
  _injectableController.dispose();
  _prevDetailsController.dispose();
  _prevDurationController.dispose();
  super.dispose();
}
}