import 'package:flutter/material.dart';
import 'systems_api.dart';

class GeneralSymptomsScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const GeneralSymptomsScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<GeneralSymptomsScreen> createState() => _GeneralSymptomsScreenState();
}

class _GeneralSymptomsScreenState extends State<GeneralSymptomsScreen> {
  // Malaise (24-24.6)
  String? q24Answer;
  String? q241Weeks;
  String? q242Severity;
  String? q243Answer;
  String? q244Answer;
  String? q245Answer;
  String? q246Answer;

  // Fever (25-25.6)
  String? q25Answer;
  String? q251Duration;
  String? q252Severity;
  String? q253Answer;
  String? q254Answer;
  String? q255Answer;
  String? q256Answer;

  // Fatigue (26-26.8)
  String? q26Answer;
  String? q261Weeks;
  String? q262Severity;
  String? q263Answer;
  String? q264Answer;
  String? q265Answer;
  String? q266Answer;
  String? q267Lifestyle;
  String? q268OtherIssues;

  // Orange Discoloration (27)
  String? q27Answer;

  // Other Symptoms (28)
  String? q28OtherSymptoms;

  bool get showMalaise => q24Answer == 'Yes';
  bool get showFever => q25Answer == 'Yes';
  bool get showFatigue => q26Answer == 'Yes';
  bool get showDiscoloration => q27Answer == 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 24. MALAISE
              _buildRadioQuestion(
                number: "24",
                question: "Have you felt unusually unwell, weak, or generally uncomfortable (malaise) since starting the medication?",
                options: ['Yes', 'No'],
                value: q24Answer,
                onChanged: (val) => setState(() => q24Answer = val),
              ),
              if (showMalaise) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "24.1", question: "How long have you experienced this feeling", value: q241Weeks, onChanged: (val) => setState(() => q241Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "24.2",
                  question: "How severe was the malaise?",
                  options: [
                    'Mild – Feeling slightly unwell or uneasy; does not limit daily activities.',
                    'Moderate – Feeling unwell or uneasy that limits instrumental activities of daily living, e.g., housework, work tasks.',
                    'Severe – Feeling unwell or uneasy that limits self-care activities, e.g., bathing, dressing, eating.'
                  ],
                  value: q242Severity,
                  onChanged: (val) => setState(() => q242Severity = val),
                ),
                _buildRadioQuestion(number: "24.3", question: "Did this symptom begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q243Answer, onChanged: (val) => setState(() => q243Answer = val)),
                _buildRadioQuestion(number: "24.4", question: "Did you experience similar symptoms before starting treatment?", options: ['Yes', 'No'], value: q244Answer, onChanged: (val) => setState(() => q244Answer = val)),
                _buildRadioQuestion(number: "24.5", question: "Did the symptom improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q245Answer, onChanged: (val) => setState(() => q245Answer = val)),
                _buildRadioQuestion(number: "24.6", question: "Did the symptom reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q246Answer, onChanged: (val) => setState(() => q246Answer = val)),
              ],

              // 25. FEVER
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "25",
                question: "Have you experienced a fever since starting the medication?",
                options: ['Yes', 'No'],
                value: q25Answer,
                onChanged: (val) => setState(() => q25Answer = val),
              ),
              if (showFever) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "25.1", question: "How long have you had the fever", value: q251Duration, onChanged: (val) => setState(() => q251Duration = val), hint: "days/weeks"),
                _buildRadioQuestion(
                  number: "25.2",
                  question: "How severe was the fever?",
                  options: [
                    'Mild – Temperature 38.0 – 39.0 °C (100.4 – 102.2 °F).',
                    'Moderate – Temperature >39.0 – 40.0 °C (102.3 – 104.0 °F).',
                    'High grade – Temperature >40.0 °C (>104.0 °F) lasting ≤24 hours.',
                    'Very high / Prolonged – Temperature >40.0 °C (>104.0 °F) lasting >24 hours.'
                  ],
                  value: q252Severity,
                  onChanged: (val) => setState(() => q252Severity = val),
                ),
                _buildRadioQuestion(number: "25.3", question: "Did this fever begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q253Answer, onChanged: (val) => setState(() => q253Answer = val)),
                _buildRadioQuestion(number: "25.4", question: "Did you have similar fevers before starting treatment?", options: ['Yes', 'No'], value: q254Answer, onChanged: (val) => setState(() => q254Answer = val)),
                _buildRadioQuestion(number: "25.5", question: "Did the fever improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q255Answer, onChanged: (val) => setState(() => q255Answer = val)),
                _buildRadioQuestion(number: "25.6", question: "Did the fever reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q256Answer, onChanged: (val) => setState(() => q256Answer = val)),
              ],

              // 26. FATIGUE
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "26",
                question: "Have you experienced unusual fatigue or weakness since starting the medication?",
                options: ['Yes', 'No'],
                value: q26Answer,
                onChanged: (val) => setState(() => q26Answer = val),
              ),
              if (showFatigue) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "26.1", question: "How long have you been experiencing fatigue or weakness", value: q261Weeks, onChanged: (val) => setState(() => q261Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "26.2",
                  question: "How severe was the fatigue?",
                  options: [
                    'Mild – Fatigue relieved by rest; does not limit daily activities.',
                    'Moderate – Fatigue not relieved by rest; limits instrumental activities of daily living (IADL) such as work, housework, or errands.',
                    'Severe – Fatigue not relieved by rest; limits self-care activities (ADL) such as bathing, dressing, or eating.'
                  ],
                  value: q262Severity,
                  onChanged: (val) => setState(() => q262Severity = val),
                ),
                _buildRadioQuestion(number: "26.3", question: "Did this symptom begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q263Answer, onChanged: (val) => setState(() => q263Answer = val)),
                _buildRadioQuestion(number: "26.4", question: "Did you experience similar fatigue or weakness before starting treatment?", options: ['Yes', 'No'], value: q264Answer, onChanged: (val) => setState(() => q264Answer = val)),
                _buildRadioQuestion(number: "26.5", question: "Did the fatigue improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q265Answer, onChanged: (val) => setState(() => q265Answer = val)),
                _buildRadioQuestion(number: "26.6", question: "Did the fatigue reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q266Answer, onChanged: (val) => setState(() => q266Answer = val)),
                _buildRadioQuestion(number: "26.7", question: "Have you been experiencing any significant lifestyle changes? (e.g., change in work hours, physical activity)", options: ['Yes', 'No', 'Not applicable'], value: q267Lifestyle, onChanged: (val) => setState(() => q267Lifestyle = val)),
                _buildTextField(number: "26.8", question: "Are you currently dealing with any other health issues or taking other medications?", value: q268OtherIssues, onChanged: (val) => setState(() => q268OtherIssues = val)),
              ],

              // 27. ORANGE DISCOLORATION
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "27",
                question: "Have you noticed any orange discoloration of your bodily secretions (urine, sweat, saliva, or tears) since starting the medication?",
                options: ['Yes', 'No'],
                value: q27Answer,
                onChanged: (val) => setState(() => q27Answer = val),
              ),

              // 28. OTHER SYMPTOMS
              const SizedBox(height: 20),
              _buildTextField(number: "28", question: "Do you have any other Symptoms? Please mention (if any)", value: q28OtherSymptoms, onChanged: (val) => setState(() => q28OtherSymptoms = val)),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        label: const Text('Save & next', style: TextStyle(fontWeight: FontWeight.bold)),
        heroTag: "save_general_next",
        onPressed: _isComplete() 
            ? () {
                _saveGeneral();
                widget.onSaveAndComplete();
              } 
            : null,
      ),
    );
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
    if (q24Answer == null || q25Answer == null || q26Answer == null || q27Answer == null) return false;
    
    if (showMalaise && (
      q241Weeks == null || q242Severity == null || q243Answer == null ||
      q244Answer == null || q245Answer == null || q246Answer == null
    )) return false;
    
    if (showFever && (
      q251Duration == null || q252Severity == null || q253Answer == null ||
      q254Answer == null || q255Answer == null || q256Answer == null
    )) return false;
    
    if (showFatigue && (
      q261Weeks == null || q262Severity == null || q263Answer == null ||
      q264Answer == null || q265Answer == null || q266Answer == null ||
      q267Lifestyle == null || q268OtherIssues == null
    )) return false;
    
    return true;
  }

  void _saveGeneral() async {
  print('🔥 GENERAL SAVE - reportId: ${widget.reportId}');

  final data = {
    "report_id": widget.reportId,

    // 24. MALAISE
    "malaise_present": q24Answer,
    "malaise_duration_weeks": int.tryParse(q241Weeks ?? ""),
    "malaise_severity": q242Severity,
    "malaise_onset": q243Answer,
    "malaise_pre_existing": q244Answer,
    "malaise_improved": q245Answer,
    "malaise_recurred": q246Answer,

    // 25. FEVER
    "fever_present": q25Answer,
    "fever_duration": q251Duration,
    "fever_severity": q252Severity,
    "fever_onset": q253Answer,
    "fever_pre_existing": q254Answer,
    "fever_improved": q255Answer,
    "fever_recurred": q256Answer,

    // 26. FATIGUE
    "fatigue_present": q26Answer,
    "fatigue_duration_weeks": int.tryParse(q261Weeks ?? ""),
    "fatigue_severity": q262Severity,
    "fatigue_onset": q263Answer,
    "fatigue_pre_existing": q264Answer,
    "fatigue_improved": q265Answer,
    "fatigue_recurred": q266Answer,
    "fatigue_lifestyle": q267Lifestyle,
    "fatigue_other_issues": q268OtherIssues,

    // 27 & 28
    "discoloration_present": q27Answer,
    "other_symptoms": q28OtherSymptoms,
  };

  print('📦 GENERAL DATA: $data');

  bool success = await SystemsApi.saveGeneralSymptoms(data);

  print('✅ Saved: $success');

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '✅ General symptoms saved successfully'
              : '❌ Failed to save general symptoms',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
  }
}
