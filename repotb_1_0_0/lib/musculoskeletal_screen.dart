import 'package:flutter/material.dart';
import 'systems_api.dart';

class MusculoskeletalScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const MusculoskeletalScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<MusculoskeletalScreen> createState() => _MusculoskeletalScreenState();
}

class _MusculoskeletalScreenState extends State<MusculoskeletalScreen> {
  // Joint Pain (19-19.7)
  String? q19Answer;
  String? q191Weeks;
  String? q192Severity;
  String? q193Joints;
  String? q194Answer;
  String? q195Answer;
  String? q196Answer;
  String? q197Answer;

  // Arthritis (20-20.7)
  String? q20Answer;
  String? q201Weeks;
  String? q202Severity;
  String? q203Joints;
  String? q204Answer;
  String? q205Answer;
  String? q206Answer;
  String? q207Answer;

  bool get showJointPain => q19Answer == 'Yes';
  bool get showArthritis => q20Answer == 'Yes';

  bool _isSaving = false;  // ✅ ADDED

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 19. JOINT PAIN
              _buildRadioQuestion(
                number: "19",
                question: "Have you experienced any joint pain since starting the medication?",
                options: ['Yes', 'No'],
                value: q19Answer,
                onChanged: (val) => setState(() => q19Answer = val),
              ),
              if (showJointPain) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "19.1", question: "How long have you had joint pain", value: q191Weeks, onChanged: (val) => setState(() => q191Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "19.2",
                  question: "How severe was the joint pain?",
                  options: [
                    'Mild - Mild joint pain without limitation of daily activities.',
                    'Moderate - Joint pain that interferes with instrumental activities of daily living (e.g., housework, shopping, work tasks).',
                    'Severe - Joint pain that limits self-care activities (e.g., bathing, dressing, eating) or significantly restricts movement.'
                  ],
                  value: q192Severity,
                  onChanged: (val) => setState(() => q192Severity = val),
                ),
                _buildRadioQuestion(
                  number: "19.3",
                  question: "Which joints are affected?",
                  options: [
                    'Knees', 'Ankles', 'Shoulders', 'Elbows', 
                    'Wrists', 'Fingers', 'Multiple joints', 'Other'
                  ],
                  value: q193Joints,
                  onChanged: (val) => setState(() => q193Joints = val),
                ),
                _buildRadioQuestion(number: "19.4", question: "Did the joint pain begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q194Answer, onChanged: (val) => setState(() => q194Answer = val)),
                _buildRadioQuestion(number: "19.5", question: "Did you experience similar joint pain before starting treatment?", options: ['Yes', 'No'], value: q195Answer, onChanged: (val) => setState(() => q195Answer = val)),
                _buildRadioQuestion(number: "19.6", question: "Did the joint pain improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q196Answer, onChanged: (val) => setState(() => q196Answer = val)),
                _buildRadioQuestion(number: "19.7", question: "Did the joint pain reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q197Answer, onChanged: (val) => setState(() => q197Answer = val)),
              ],

              // 20. ARTHRITIS
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "20",
                question: "Have you experienced joint pain with swelling, redness, warmth, or stiffness since starting the medication?",
                options: ['Yes', 'No'],
                value: q20Answer,
                onChanged: (val) => setState(() => q20Answer = val),
              ),
              if (showArthritis) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(number: "20.1", question: "How long have you had joint pain", value: q201Weeks, onChanged: (val) => setState(() => q201Weeks = val), hint: "weeks"),
                _buildRadioQuestion(
                  number: "20.2",
                  question: "How severe was the arthritis?",
                  options: [
                    'Mild - Mild joint pain with inflammation, redness (erythema), or swelling; no limitation of daily activities.',
                    'Moderate - Joint pain with clear signs of inflammation (swelling, redness, warmth); limiting instrumental activities of daily living (e.g., housework, work tasks).',
                    'Severe - Severe joint pain with significant inflammation or suspected joint damage; limiting self-care activities (e.g., bathing, dressing).'
                  ],
                  value: q202Severity,
                  onChanged: (val) => setState(() => q202Severity = val),
                ),
                _buildRadioQuestion(
                  number: "20.3",
                  question: "Which joints are affected?",
                  options: [
                    'Knees', 'Ankles', 'Shoulders', 'Elbows', 
                    'Wrists', 'Fingers', 'Multiple joints', 'Other'
                  ],
                  value: q203Joints,
                  onChanged: (val) => setState(() => q203Joints = val),
                ),
                _buildRadioQuestion(number: "20.4", question: "Did the arthritis begin after starting the therapy?", options: ['Yes', 'No', 'Not sure'], value: q204Answer, onChanged: (val) => setState(() => q204Answer = val)),
                _buildRadioQuestion(number: "20.5", question: "Did you have similar joint problems before starting treatment?", options: ['Yes', 'No'], value: q205Answer, onChanged: (val) => setState(() => q205Answer = val)),
                _buildRadioQuestion(number: "20.6", question: "Did the symptoms improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q206Answer, onChanged: (val) => setState(() => q206Answer = val)),
                _buildRadioQuestion(number: "20.7", question: "Did the symptoms reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q207Answer, onChanged: (val) => setState(() => q207Answer = val)),
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
        heroTag: "save_musculoskeletal_next",
        onPressed: _isSaving || !_isComplete() ? null : _handleSaveAndNext,  // ✅ FIXED
      ),
    );
  }

  // ✅ NEW: Safe async handler (same as Psychiatric)
  Future<void> _handleSaveAndNext() async {
    if (!mounted) return;
    setState(() => _isSaving = true);
    
    try {
      await _saveMusculoskeletal();
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

  bool _isComplete() {
    if (q19Answer == null || q20Answer == null) return false;
    
    if (showJointPain && (
      q191Weeks == null || q192Severity == null || q193Joints == null ||
      q194Answer == null || q195Answer == null || q196Answer == null || q197Answer == null
    )) return false;
    
    if (showArthritis && (
      q201Weeks == null || q202Severity == null || q203Joints == null ||
      q204Answer == null || q205Answer == null || q206Answer == null || q207Answer == null
    )) return false;
    
    return true;
  }
  
  // ✅ FIXED: Mounted-safe save + backend keys match
  Future<void> _saveMusculoskeletal() async {
    print('MUSCULOSKELETAL SAVE - reportId: ${widget.reportId}');
    List<Map<String, String>> symptoms = [];

    // Joint Pain - only if Q19 = Yes
    if (q19Answer == 'Yes') {
      symptoms.add({
        'name': 'Joint Pain',
        'severity': _mapSeverity(q192Severity)
      });
    }

    // Arthritis - only if Q20 = Yes
    if (q20Answer == 'Yes') {
      symptoms.add({
        'name': 'Arthritis', 
        'severity': _mapSeverity(q202Severity)
      });
    }
    
    print('📦 Saving ${symptoms.length} symptoms');
    
    for (var s in symptoms) {
      final success = await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "MUSCULOSKELETAL",  // ✅ Fixed: Matches your SystemMapper
        symptomName: s['name']!,
        symptomPresent: "Yes",
        severity: s['severity']!,
      );
      print('✅ Symptom saved: ${s['name']} -> $success');
    }

    // ✅ MOUNTED CHECK - No crashes!
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Musculoskeletal data saved!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
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