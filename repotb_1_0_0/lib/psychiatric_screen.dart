import 'package:flutter/material.dart';
import 'systems_api.dart';

class PsychiatricScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const PsychiatricScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<PsychiatricScreen> createState() => _PsychiatricScreenState();
}

class _PsychiatricScreenState extends State<PsychiatricScreen> {
  // Depression/Low Mood (17-17.7)
  String? q17Answer;
  String? q171Frequency;
  String? q172Severity;
  String? q173Interference;
  String? q174Answer;
  String? q175Answer;
  String? q176Answer;
  String? q177Answer;

  // Psychosis (18-18.5)
  String? q18Answer;
  String? q181Severity;
  String? q182Answer;
  String? q183Answer;
  String? q184Answer;
  String? q185Answer;

  bool get showDepression => q17Answer == 'Yes';
  bool get showPsychosis => q18Answer == 'Yes';

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 17. DEPRESSION/LOW MOOD
              _buildRadioQuestion(
                number: "17",
                question: "Have you been feeling low, depressed, or down since starting the medication?",
                options: ['Yes', 'No','Unknown'],
                value: q17Answer,
                onChanged: (val) => setState(() => q17Answer = val),
              ),
              if (showDepression) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "17.1",
                  question: "In the past 7 days, how often did you feel sad or depressed?",
                  options: ['Rarely', 'Occasionally', 'Frequently', 'Almost constantly'],
                  value: q171Frequency,
                  onChanged: (val) => setState(() => q171Frequency = val),
                ),
                _buildRadioQuestion(
                  number: "17.2",
                  question: "In the past 7 days, what was the severity of your feeling sad or depressed at its worst?",
                  options: [
                    'Mild - I felt slightly sad or low, but it did not affect my daily activities or functioning.',
                    'Moderate - I felt noticeably sad or depressed and it affected my mood and concentration, but I was still able to carry out most daily activities.',
                    'Severe - I felt very sad or depressed and had difficulty performing daily activities, work, or social interactions.',
                    'Very severe - I felt extremely sad or depressed, was unable to carry out normal daily activities, or felt overwhelmed most of the time.'
                  ],
                  value: q172Severity,
                  onChanged: (val) => setState(() => q172Severity = val),
                ),
                _buildRadioQuestion(
                  number: "17.3",
                  question: "In the past 7 days, how much did feeling sad or depressed interfere with your usual or daily activities?",
                  options: ['Not at all', 'A little bit', 'Somewhat', 'Quite a bit', 'Very much'],
                  value: q173Interference,
                  onChanged: (val) => setState(() => q173Interference = val),
                ),
                _buildRadioQuestion(number: "17.4", question: "Did this feeling begin after starting the therapy?", options: ['Yes', 'No','Unknown', 'Not sure'], value: q174Answer, onChanged: (val) => setState(() => q174Answer = val)),
                _buildRadioQuestion(number: "17.5", question: "Did you experience low mood before starting the therapy?", options: ['Yes', 'No','Unknown'], value: q175Answer, onChanged: (val) => setState(() => q175Answer = val)),
                _buildRadioQuestion(number: "17.6", question: "Did your mood improve after stopping or adjusting the medication?", options: ['Yes', 'No','Unknown', 'Not applicable'], value: q176Answer, onChanged: (val) => setState(() => q176Answer = val)),
                _buildRadioQuestion(number: "17.7", question: "Did the low mood return after restarting the medication?", options: ['Yes', 'No','Unknown', 'Not applicable'], value: q177Answer, onChanged: (val) => setState(() => q177Answer = val)),
              ],

              // 18. PSYCHOSIS
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "18",
                question: "Have you experienced any unusual thoughts, hallucinations (seeing or hearing things that others do not), severe confusion, or loss of touch with reality since starting the medication? (PSYCHOSIS)",
                options: ['Yes', 'No','Unknown'],
                value: q18Answer,
                onChanged: (val) => setState(() => q18Answer = val),
              ),
              if (showPsychosis) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "18.1",
                  question: "How severe were the symptoms?",
                  options: [
                    'Mild -  Mild unusual thoughts, mild suspiciousness, or brief perceptual disturbances; no significant impairment in daily functioning.',
                    'Moderate - Clear psychotic symptoms such as disorganized speech, impaired reality testing, hallucinations, or delusions; noticeable impact on functioning but no hospitalization required.',
                    'Severe - Marked psychotic symptoms such as paranoia, extreme disorganization, or severe behavioral disturbance; significant impairment in functioning; hospitalization not yet required.',
                    'Life threatening - Psychotic symptoms associated with risk of harm to self or others; hospitalization or urgent psychiatric intervention required.'
                  ],
                  value: q181Severity,
                  onChanged: (val) => setState(() => q181Severity = val),
                ),
                _buildRadioQuestion(number: "18.2", question: "Did these symptoms begin after starting the therapy?", options: ['Yes', 'No','Unknown', 'Not sure'], value: q182Answer, onChanged: (val) => setState(() => q182Answer = val)),
                _buildRadioQuestion(number: "18.3", question: "Did you have similar symptoms before starting treatment?", options: ['Yes', 'No','Unknown'], value: q183Answer, onChanged: (val) => setState(() => q183Answer = val)),
                _buildRadioQuestion(number: "18.4", question: "Did the symptoms improve after stopping or adjusting the medication?", options: ['Yes', 'No','Unknown', 'Not applicable'], value: q184Answer, onChanged: (val) => setState(() => q184Answer = val)),
                _buildRadioQuestion(number: "18.5", question: "Did the symptoms reappear after restarting the medication?", options: ['Yes', 'No','Unknown', 'Not applicable'], value: q185Answer, onChanged: (val) => setState(() => q185Answer = val)),
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
        heroTag: "save_psychiatric_next",
        onPressed: _isSaving || !_isComplete() ? null : _handleSaveAndNext,
      ),
    );
  }

  // ✅ FIXED: Safe async save with mounted check
  Future<void> _handleSaveAndNext() async {
  if (!mounted) return;

  setState(() => _isSaving = true);

  try {
    await _savePsychiatric();

    if (mounted) {
      Navigator.pop(context, true);
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

  bool _isComplete() {
    if (q17Answer == null || q18Answer == null) return false;
    
    if (showDepression && (
      q171Frequency == null || q172Severity == null || q173Interference == null ||
      q174Answer == null || q175Answer == null || q176Answer == null || q177Answer == null
    )) return false;
    
    if (showPsychosis && (
      q181Severity == null || q182Answer == null || q183Answer == null ||
      q184Answer == null || q185Answer == null
    )) return false;
    
    return true;
  }
  
  // ✅ FIXED: Safe snackbar + proper backend keys
  Future<void> _savePsychiatric() async {
    print('PSYCHIATRIC SAVE - reportId: ${widget.reportId}');
    List<Map<String, String>> symptoms = [];

    // Depression - only if Q17 = Yes
    if (q17Answer == 'Yes') {

  // MAIN symptom
  symptoms.add({
    'name': 'Depression',
    'severity': _mapSeverity(q172Severity),
  });

  // causality flags
  if (q174Answer == 'Yes') {
    symptoms.add({'name': 'Depression after medication', 'severity': 'mild'});
  }

  if (q175Answer == 'Yes') {
    symptoms.add({'name': 'Pre-existing depression', 'severity': 'mild'});
  }

  if (q176Answer == 'Yes') {
    symptoms.add({'name': 'Depression improved', 'severity': 'mild'});
  }

  if (q177Answer == 'Yes') {
    symptoms.add({'name': 'Depression returned', 'severity': 'mild'});
  }
}

    // Psychosis - only if Q18 = Yes  
    if (q18Answer == 'Yes') {

  symptoms.add({
    'name': 'Psychosis',
    'severity': _mapSeverity(q181Severity),
  });

  if (q182Answer == 'Yes') {
    symptoms.add({'name': 'Psychosis after medication', 'severity': 'mild'});
  }

  if (q183Answer == 'Yes') {
    symptoms.add({'name': 'Pre-existing psychosis', 'severity': 'mild'});
  }

  if (q184Answer == 'Yes') {
    symptoms.add({'name': 'Psychosis improved', 'severity': 'mild'});
  }

  if (q185Answer == 'Yes') {
    symptoms.add({'name': 'Psychosis returned', 'severity': 'mild'});
  }
}
    
    print('📦 Saving ${symptoms.length} symptoms');
    
    for (var s in symptoms) {
      // ✅ Backend keys PERFECTLY MATCH your SystemsApi.saveSymptom()
      final success = await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "PSYCHIATRIC",  // ← Maps to your SystemMapper enum
        symptomName: s['name']!,
        symptomPresent: "Yes",
        severity: s['severity']!,
      );
      print('✅ Symptom saved: ${s['name']} -> $success');
    }

    // ✅ MOUNTED CHECK - No more errors!
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Psychiatric Disorders data saved!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String _mapSeverity(String? s) {
  if (s == null) return 'moderate';

  s = s.toLowerCase();

  if (s.contains('life')) return 'life threatening'; // ✅ FIX
  if (s.contains('severe')) return 'severe';
  if (s.contains('moderate')) return 'moderate';
  if (s.contains('mild')) return 'mild';

  return 'moderate';
  }
}