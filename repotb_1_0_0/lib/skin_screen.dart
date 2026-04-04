import 'package:flutter/material.dart';
import 'systems_api.dart';

class SkinSubcutaneousScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;

  const SkinSubcutaneousScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<SkinSubcutaneousScreen> createState() => _SkinSubcutaneousScreenState();
}

class _SkinSubcutaneousScreenState extends State<SkinSubcutaneousScreen> {

  // ================= STATE =================

  String? q14Answer, q141BSA, q142Severity, q143Answer, q144Answer,
      q145Answer, q146Answer, q147Products, q148Allergies;

  String? q15Answer, q151Severity, q152Answer, q153Answer,
      q154Answer, q155Answer;

  String? q16Answer, q161Severity, q162Symptoms, q163Answer,
      q164Answer, q165Answer, q166Answer;

  bool get showRash => q14Answer == 'Yes';
  bool get showItching => q15Answer == 'Yes';
  bool get showJaundice => q16Answer == 'Yes';

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== 14 =====
              _buildRadioQuestion(
                number: "14",
                question: "Have you developed any red, raised, or flat skin rash (maculopapular rash) since starting the medication?",
                options: ['Yes', 'No'],
                value: q14Answer,
                onChanged: (val) => setState(() => q14Answer = val),
              ),

              if (showRash) ...[
                _sectionTitle(),

                _buildNumericQuestion(
                  number: "14.1",
                  question: "Estimated percentage of body surface area involved",
                  value: q141BSA,
                  onChanged: (val) => setState(() => q141BSA = val),
                  hint: "%",
                ),

                _buildRadioQuestion(
                  number: "14.2",
                  question: "How severe is the rash?",
                  options: [
                    'Mild: <10% BSA',
                    'Moderate: 10–30% BSA',
                    'Severe: >30% BSA',
                    'Life-threatening (SJS/TEN)'
                  ],
                  value: q142Severity,
                  onChanged: (v) => setState(() => q142Severity = v),
                ),

                _buildRadioQuestion(number: "14.3", question: "Did the rash begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q143Answer, onChanged: (v) => setState(() => q143Answer = v)),
                _buildRadioQuestion(number: "14.4", question: "Did you have a similar rash before starting treatment?", options: ['Yes', 'No'], value: q144Answer, onChanged: (v) => setState(() => q144Answer = v)),
                _buildRadioQuestion(number: "14.5", question: "Did the rash improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q145Answer, onChanged: (v) => setState(() => q145Answer = v)),
                _buildRadioQuestion(number: "14.6", question: "Did the rash reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q146Answer, onChanged: (v) => setState(() => q146Answer = v)),
                _buildRadioQuestion(number: "14.7", question: "Used new skincare products?", options: ['Yes', 'No'], value: q147Products, onChanged: (v) => setState(() => q147Products = v)),
                _buildRadioQuestion(number: "14.8", question: "Known allergies?", options: ['Yes', 'No'], value: q148Allergies, onChanged: (v) => setState(() => q148Allergies = v)),
              ],

              // ===== 15 =====
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "15",
                question: "Have you experienced itching, hives, petechiae, or dermatitis?",
                options: ['Yes', 'No'],
                value: q15Answer,
                onChanged: (val) => setState(() => q15Answer = val),
              ),

              if (showItching) ...[
                _sectionTitle(),

                _buildRadioQuestion(
                  number: "15.1",
                  question: "Severity",
                  options: ['Mild','Moderate','Severe','Life-threatening'],
                  value: q151Severity,
                  onChanged: (v)=>setState(()=>q151Severity=v),
                ),

                _buildRadioQuestion(number: "15.2", question: "After medication?", options: ['Yes', 'No', 'Not sure'], value: q152Answer, onChanged: (v) => setState(() => q152Answer = v)),
                _buildRadioQuestion(number: "15.3", question: "Pre-existing?", options: ['Yes', 'No'], value: q153Answer, onChanged: (v) => setState(() => q153Answer = v)),
                _buildRadioQuestion(number: "15.4", question: "Improved after stopping?", options: ['Yes', 'No', 'Not applicable'], value: q154Answer, onChanged: (v) => setState(() => q154Answer = v)),
                _buildRadioQuestion(number: "15.5", question: "Recurred after restart?", options: ['Yes', 'No', 'Not applicable'], value: q155Answer, onChanged: (v) => setState(() => q155Answer = v)),
              ],

              // ===== 16 =====
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "16",
                question: "Have you noticed yellowing of your skin or eyes, or dark urine?",
                options: ['Yes', 'No'],
                value: q16Answer,
                onChanged: (val) => setState(() => q16Answer = val),
              ),

              if (showJaundice) ...[
                _sectionTitle(),

                _buildRadioQuestion(
                  number: "16.1",
                  question: "Severity",
                  options: ['Mild','Moderate','Severe','Life-threatening'],
                  value: q161Severity,
                  onChanged: (v)=>setState(()=>q161Severity=v),
                ),

                _buildRadioQuestion(
                  number: "16.2",
                  question: "Associated symptoms",
                  options: ['Abdominal pain','Nausea','Fatigue','Loss of appetite','Pale stools','None'],
                  value: q162Symptoms,
                  onChanged: (v)=>setState(()=>q162Symptoms=v),
                ),

                _buildRadioQuestion(number: "16.3", question: "After medication?", options: ['Yes', 'No', 'Not sure'], value: q163Answer, onChanged: (v) => setState(() => q163Answer = v)),
                _buildRadioQuestion(number: "16.4", question: "Pre-existing?", options: ['Yes', 'No'], value: q164Answer, onChanged: (v) => setState(() => q164Answer = v)),
                _buildRadioQuestion(number: "16.5", question: "Improved after stopping?", options: ['Yes', 'No', 'Not applicable'], value: q165Answer, onChanged: (v) => setState(() => q165Answer = v)),
                _buildRadioQuestion(number: "16.6", question: "Recurred after restart?", options: ['Yes', 'No', 'Not applicable'], value: q166Answer, onChanged: (v) => setState(() => q166Answer = v)),
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
        label: const Text('Save & Next System'),
        onPressed: _isComplete()
            ? () {
                _saveSkin();
                widget.onSaveAndComplete();
              }
            : null,
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _sectionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text("If Yes, Please continue:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number. $question",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...options.map((o) => RadioListTile(
                  title: Text(o),
                  value: o,
                  groupValue: value,
                  onChanged: (v) => onChanged(v!),
                ))
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
    String hint = "",
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number. $question",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              initialValue: value,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isComplete() {
    return q14Answer != null && q15Answer != null && q16Answer != null;
  }

  void _saveSkin() async {
     print('SKIN SAVE - reportId: ${widget.reportId}');
    List<Map<String, String>> symptoms = [];

    if (q14Answer == 'Yes') {
      symptoms.add({'name': 'Rash', 'severity': _mapSeverity(q142Severity)});
    }
    if (q15Answer == 'Yes') {
      symptoms.add({'name': 'Itching', 'severity': _mapSeverity(q151Severity)});
    }
    if (q16Answer == 'Yes') {
      symptoms.add({'name': 'Jaundice', 'severity': _mapSeverity(q161Severity)});
    }

     print('📦 Saving ${symptoms.length} symptoms');
    for (var s in symptoms) {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "SKIN AND SUBCUTANEOUS TISSUE RELATED SYMPTOMS",
        symptomName: s['name']!,
        symptomPresent: "Yes",
        severity: s['severity']!,
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