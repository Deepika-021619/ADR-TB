import 'package:flutter/material.dart';
import 'systems_api.dart';

class GenitourinaryScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const GenitourinaryScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<GenitourinaryScreen> createState() => _GenitourinaryScreenState();
}

class _GenitourinaryScreenState extends State<GenitourinaryScreen> {
  // Add missing state variables
  bool _isSaving = false;

  // Hematuria (21-21.7)
  String? q21Answer;
  String? q211Weeks;
  String? q212Severity;
  String? q213Answer;
  String? q214Answer;
  String? q215Answer;
  String? q216Answer;
  String? q217Notes;

  // Flank Pain (22-22.6)
  String? q22Answer;
  String? q221Weeks;
  String? q222Severity;
  String? q223Answer;
  String? q224Answer;
  String? q225Answer;
  String? q226Answer;

  // Urinary Frequency (23-23.6)
  String? q23Answer;
  String? q231Weeks;
  String? q232Severity;
  String? q233Answer;
  String? q234Answer;
  String? q235Answer;
  String? q236Answer;

  bool get showHematuria => q21Answer == 'Yes';
  bool get showFlankPain => q22Answer == 'Yes';
  bool get showFrequency => q23Answer == 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 21. HEMATURIA
              _buildRadioQuestion(
                number: "21",
                question: "Have you noticed blood in your urine (hematuria) since starting the medication?",
                options: ['Yes', 'No'],
                value: q21Answer,
                onChanged: (val) => setState(() => q21Answer = val),
              ),
              if (showHematuria) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "21.1", question: "How long have you noticed blood in your urine", value: q211Weeks, onChanged: (val) => setState(() => q211Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "21.2",
                  question: "How severe was the hematuria?",
                  options: [
                    'Mild / Asymptomatic – Blood detected only on lab tests or microscopy; no treatment was required.',
                    'Moderate – Symptomatic blood in urine; may require urinary catheter or bladder irrigation; limits instrumental activities of daily living.',
                    'Severe – Gross visible blood in urine; may require transfusion, IV medications, or hospitalization; elective invasive procedures may be needed; limits self-care activities.',
                    'Life threatening – Massive hematuria causing hemodynamic compromise; urgent invasive intervention required.'
                  ],
                  value: q212Severity,
                  onChanged: (val) => setState(() => q212Severity = val),
                ),
                _buildRadioQuestion(number: "21.3", question: "Did this symptom begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q213Answer, onChanged: (val) => setState(() => q213Answer = val)),
                _buildRadioQuestion(number: "21.4", question: "Did you have similar symptoms before starting treatment?", options: ['Yes', 'No'], value: q214Answer, onChanged: (val) => setState(() => q214Answer = val)),
                _buildRadioQuestion(number: "21.5", question: "Did the hematuria improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q215Answer, onChanged: (val) => setState(() => q215Answer = val)),
                _buildRadioQuestion(number: "21.6", question: "Did the hematuria reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q216Answer, onChanged: (val) => setState(() => q216Answer = val)),
                _buildTextField(number: "21.7", question: "Additional notes (e.g., associated pain, frequency, color change, history of injury)", value: q217Notes, onChanged: (val) => setState(() => q217Notes = val)),
              ],

              // 22. FLANK PAIN
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "22",
                question: "Have you experienced pain in your lower back/flank that radiates to your groin since starting the medication?",
                options: ['Yes', 'No'],
                value: q22Answer,
                onChanged: (val) => setState(() => q22Answer = val),
              ),
              if (showFlankPain) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "22.1", question: "How long have you had this pain", value: q221Weeks, onChanged: (val) => setState(() => q221Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "22.2",
                  question: "How severe was the pain?",
                  options: [
                    'Mild – Pain present but does not interfere with daily activities; may require nonprescription medication.',
                    'Moderate – Pain limits instrumental activities of daily living (e.g., housework, work tasks); may require prescription medication.',
                    'Severe – Pain requiring hospitalization; limits self-care activities (e.g., bathing, dressing).'
                  ],
                  value: q222Severity,
                  onChanged: (val) => setState(() => q222Severity = val),
                ),
                _buildRadioQuestion(number: "22.3", question: "Did this pain begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q223Answer, onChanged: (val) => setState(() => q223Answer = val)),
                _buildRadioQuestion(number: "22.4", question: "Did you have similar pain before starting treatment?", options: ['Yes', 'No'], value: q224Answer, onChanged: (val) => setState(() => q224Answer = val)),
                _buildRadioQuestion(number: "22.5", question: "Did the pain improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q225Answer, onChanged: (val) => setState(() => q225Answer = val)),
                _buildRadioQuestion(number: "22.6", question: "Did the pain reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q226Answer, onChanged: (val) => setState(() => q226Answer = val)),
              ],

              // 23. URINARY FREQUENCY
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "23",
                question: "Have you noticed an increase in how often you urinate since starting the medication?",
                options: ['Yes', 'No'],
                value: q23Answer,
                onChanged: (val) => setState(() => q23Answer = val),
              ),
              if (showFrequency) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "23.1", question: "How long have you noticed increased urinary frequency", value: q231Weeks, onChanged: (val) => setState(() => q231Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "23.2",
                  question: "How severe was the symptom?",
                  options: [
                    'Mild / Present – Increase in urination, but it does not interfere with daily activities.',
                    'Moderate – Increase in urination that limits instrumental activities of daily living (e.g., work, housework); medical management indicated.'
                  ],
                  value: q232Severity,
                  onChanged: (val) => setState(() => q232Severity = val),
                ),
                _buildRadioQuestion(number: "23.3", question: "Did this symptom begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q233Answer, onChanged: (val) => setState(() => q233Answer = val)),
                _buildRadioQuestion(number: "23.4", question: "Did you have similar urinary issues before starting treatment?", options: ['Yes', 'No'], value: q234Answer, onChanged: (val) => setState(() => q234Answer = val)),
                _buildRadioQuestion(number: "23.5", question: "Did the symptom improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q235Answer, onChanged: (val) => setState(() => q235Answer = val)),
                _buildRadioQuestion(number: "23.6", question: "Did the symptom reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q236Answer, onChanged: (val) => setState(() => q236Answer = val)),
              ],
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        label: Text(_isSaving ? 'Saving...' : 'Save & Next System', style: const TextStyle(fontWeight: FontWeight.bold)),
        heroTag: "save_genitourinary_next",
        onPressed: _isSaving || !_isComplete() ? null : _handleSaveAndNext,         
      ),
    );
  }

  Future<void> _handleSaveAndNext() async {
    if (!mounted) return;
    setState(() => _isSaving = true);
    
    try {
      await _saveGenitourinary();
      if (mounted) {
        widget.onSaveAndComplete();
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildRadioQuestion({
    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number. $question", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...options.map((option) => RadioListTile<String>(
              title: Text(option, style: const TextStyle(fontSize: 14)),
              value: option,
              groupValue: value,
              onChanged: (val) => onChanged(val ?? ''),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericQuestion({
    required String number,
    required String question,
    required String? value,
    required Function(String) onChanged,
    String hint = "Enter number",
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number. $question", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              initialValue: value,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String number,
    required String question,
    required String? value,
    required Function(String) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number. $question", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: 3,
              onChanged: onChanged,
              initialValue: value,
              decoration: InputDecoration(
                hintText: "Enter details...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isComplete() {
    if (q21Answer == null || q22Answer == null || q23Answer == null) return false;
    
    if (showHematuria && (
      q211Weeks == null || q212Severity == null || q213Answer == null ||
      q214Answer == null || q215Answer == null || q216Answer == null || q217Notes == null
    )) return false;
    
    if (showFlankPain && (
      q221Weeks == null || q222Severity == null || q223Answer == null ||
      q224Answer == null || q225Answer == null || q226Answer == null
    )) return false;
    
    if (showFrequency && (
      q231Weeks == null || q232Severity == null || q233Answer == null ||
      q234Answer == null || q235Answer == null || q236Answer == null
    )) return false;
    
    return true;
  }

   Future<void> _saveGenitourinary() async {
  print('Genitourinary SAVE - reportId: ${widget.reportId}');

  // ================= HEMATURIA =================
  if (q21Answer == 'Yes') {

    await SystemsApi.saveSymptom(
      reportId: widget.reportId,
      questionnaireSystem: "Genitourinary",
      symptomName: "Hematuria",
      symptomPresent: "Yes",
      severity: _mapSeverity(q212Severity),
      durationWeeks: int.tryParse(q211Weeks ?? ""),
    );

    if (q213Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Hematuria after medication",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q214Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Hematuria pre-existing",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q215Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Hematuria improved",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q216Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Hematuria returned",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }
  }

  // ================= FLANK PAIN =================
  if (q22Answer == 'Yes') {

    await SystemsApi.saveSymptom(
      reportId: widget.reportId,
      questionnaireSystem: "Genitourinary",
      symptomName: "Flank Pain",
      symptomPresent: "Yes",
      severity: _mapSeverity(q222Severity),
      durationWeeks: int.tryParse(q221Weeks ?? ""),
    );

    if (q223Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Flank pain after medication",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q224Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Flank pain pre-existing",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q225Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Flank pain improved",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q226Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Flank pain returned",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }
  }

  // ================= FREQUENCY =================
  if (q23Answer == 'Yes') {

    await SystemsApi.saveSymptom(
      reportId: widget.reportId,
      questionnaireSystem: "Genitourinary",
      symptomName: "Urinary Frequency",
      symptomPresent: "Yes",
      severity: _mapSeverity(q232Severity),
      durationWeeks: int.tryParse(q231Weeks ?? ""),
    );

    if (q233Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Frequency after medication",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q234Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Frequency pre-existing",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q235Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Frequency improved",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }

    if (q236Answer == "Yes") {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Genitourinary",
        symptomName: "Frequency returned",
        symptomPresent: "Yes",
        severity: "mild",
      );
    }
  }
}

  String _mapSeverity(String? s) {
    if (s == null) return 'moderate';
    s = s.toLowerCase();
    if (s.contains('mild')) return 'mild';
    if (s.contains('severe')) return 'severe';
    return 'moderate';
  }
}