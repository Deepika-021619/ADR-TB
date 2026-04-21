import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'reporter.dart';


class StartPatientScreen extends StatefulWidget {
  final String portal;
  final String reportId;

  const StartPatientScreen({
    super.key,
    required this.portal,
    required this.reportId,
  });

  @override
  State<StartPatientScreen> createState() => _StartPatientScreenState();
}

class _StartPatientScreenState extends State<StartPatientScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController treatmentStartDateController = TextEditingController();

  int? treatmentTypeId = null;
  bool isLoading = false;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> createPatientDetails() async {
    final age = ageController.text.trim();
    final height = heightController.text.trim();
    final weight = weightController.text.trim();
    final treatmentDate = treatmentStartDateController.text.trim();

    // this is for validation
    if (age.isEmpty) {
      _showError("❌ Age is required!");
      return;
    }
    if (height.isEmpty) {
      _showError("❌ Height is required!");
      return;
    }
    if (weight.isEmpty) {
      _showError("❌ Weight is required!");
      return;
    }
    if (treatmentDate.isEmpty) {
      _showError("❌ Treatment start date is required!");
      return;
    }
    if (treatmentTypeId == null) {
      _showError("❌ Please select TB treatment type!");
      return;
    }

    setState(() => isLoading = true);

    try {
      final patientResponse = await http.post(
        Uri.parse("http://127.0.0.1:8000/reports/${widget.reportId}/event"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "report_id": widget.reportId,
          "age_years": int.parse(age),
          "height_cm": double.parse(height),
          "weight_kg": double.parse(weight),
          "tb_treatment_sd": treatmentDate,
          "treatment_type_id": treatmentTypeId!,
        }),
      ).timeout(const Duration(seconds: 10));

      print("Patient Status: ${patientResponse.statusCode}");
      print("Patient Response: ${patientResponse.body}");

      if (patientResponse.statusCode == 200 || patientResponse.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("✅ Patient details saved successfully!"),
            backgroundColor: Colors.green,
            duration: const Duration (seconds: 4),
            action: SnackBarAction( 
              label: "Next",
            textColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context) => StartReporterScreen(
                    portal: widget.portal, 
                    reportId: widget.reportId,
                ),
              ),
            );
            },
            ),
          ),
        );
        // to clear form after successfull submission
        ageController.clear();
        heightController.clear(); 
        weightController.clear();
        treatmentStartDateController.clear();
        setState(() {
          treatmentTypeId = null;
        });
      
      } else {
        _showError("❌ Failed: ${patientResponse.statusCode}");
      }
    } catch (e) {
      print("❌ ERROR: $e");
      _showError("❌ Network Error: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Details - Report ${widget.reportId}"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // the Report ID will be displayed on top
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    "Report ID: ${widget.reportId}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text("Enter patient details below", 
                    style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // for age
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age (years) *",
                
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            //  for height
            TextField(
              controller: heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Height (cm) *",
                
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // for weight
            TextField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Weight (kg) *",
                
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Treatment Start Date
            TextField(
            controller: treatmentStartDateController,
            readOnly: true,  // ✅ Prevents manual typing
  decoration: InputDecoration(
    labelText: "Treatment Start Date (DD-MM-YYYY) *",
    border: OutlineInputBorder(),
    suffixIcon: const Icon(Icons.calendar_today), 
  ),
  onTap: () async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // Format: DD-MM-YYYY
       final displayFormat = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      treatmentStartDateController.text = displayFormat;
    }
  },
),
const SizedBox(height: 15),

            // the dropdown menu for TB-treatment type
            DropdownButtonFormField<int>(
              value: treatmentTypeId,
              hint: const Text("Select TB Treatment Type *"),
              decoration: InputDecoration(
                labelText: "TB Treatment Type",
                
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 1, child: Text("HRZE TB regimen")),
                DropdownMenuItem(value: 2, child: Text("H-mono DR TB regimen")),
                DropdownMenuItem(value: 3, child: Text("Shorter oral BDQ MDR TB regimen")),
                DropdownMenuItem(value: 4, child: Text("Shorter injectable MDR TB regimen")),
                DropdownMenuItem(value: 5, child: Text("Oral longer XDR TB regimen")),
                DropdownMenuItem(value: 6, child: Text("TB preventive therapy")),
                DropdownMenuItem(value: 7, child: Text("Tailored therapy")),
              ],
              onChanged: (value) {
                setState(() => treatmentTypeId = value);
              },
            ),
            const SizedBox(height: 25),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: createPatientDetails,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Save Patient Details"),
                  ),
          ],
        ),
      ),
    );
  }
}
