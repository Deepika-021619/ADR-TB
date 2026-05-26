import 'package:flutter/material.dart';
import 'systems_api.dart';

class OcularInvolvementScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const OcularInvolvementScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<OcularInvolvementScreen> createState() => _OcularInvolvementScreenState();
}

class _OcularInvolvementScreenState extends State<OcularInvolvementScreen> {
  // Blurring/Decrease Vision (11-11.9)
  String? q11Answer;        // Yes/No
  String? q111RightEye;
  String? q111LeftEye;
  String? q112Baseline;
  String? q113Severity;
  String? q114Answer;
  String? q115Answer;
  String? q116Answer;
  String? q117Answer;
  String? q118Answer;
  String? q119Strain;

  // Color Vision (12-12.7)
  String? q12Answer;        // Yes/No
  String? q121Tested;
  String? q122Plates;
  String? q123Severity;
  String? q124Answer;
  String? q125Answer;
  String? q126Answer;
  String? q127Answer;

  // Patchy Vision Loss (13-13.6)
  String? q13Answer;        // Yes/No
  String? q131Area;
  String? q132Severity;
  String? q133Answer;
  String? q134Answer;
  String? q135Answer;
  String? q136Answer;

  bool get showBlurring => q11Answer == 'Yes';
  bool get showColorVision => q12Answer == 'Yes';
  bool get showPatchyVision => q13Answer == 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 11. BLURRING/DECREASE VISION
              _buildRadioQuestion(
                number: "11",
                question: "Have you experienced any blurring or decrease in vision since starting the treatment?",
                options: ['Yes', 'No'],
                value: q11Answer,
                onChanged: (val) => setState(() => q11Answer = val),
              ),
              if (showBlurring) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                
                // 11.1 Visual Acuity (Two numeric fields)
                _buildTwoNumericFields(
                  number: "11.1",
                  label1: "Right Eye (OD)",
                  label2: "Left Eye (OS)",
                  value1: q111RightEye,
                  value2: q111LeftEye,
                  onChanged1: (val) => setState(() => q111RightEye = val),
                  onChanged2: (val) => setState(() => q111LeftEye = val),
                ),
                
                _buildRadioQuestion(number: "11.2", question: "Baseline visual acuity available?", options: ['Yes', 'No'], value: q112Baseline, onChanged: (val) => setState(() => q112Baseline = val)),
                _buildRadioQuestion(
                  number: "11.3",
                  question: "How severe was your vision affected when measured using Snellen's chart?",
                  options: [
                    'Mild – Symptomatic with moderate decrease in visual acuity (20/40 or better OR ≤3-line decrease from baseline); limits instrumental activities',
                    'Moderate – Marked decrease in visual acuity (worse than 20/40 but better than 20/200 OR >3-line decrease from baseline); limits self-care activities',
                    'Severe – Visual acuity 20/200 or worse in the affected eye'
                  ],
                  value: q113Severity,
                  onChanged: (val) => setState(() => q113Severity = val),
                ),
                _buildRadioQuestion(number: "11.4", question: "Did the visual symptoms begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q114Answer, onChanged: (val) => setState(() => q114Answer = val)),
                _buildRadioQuestion(number: "11.5", question: "Did you have similar visual problems before starting treatment?", options: ['Yes', 'No'], value: q115Answer, onChanged: (val) => setState(() => q115Answer = val)),
                _buildRadioQuestion(number: "11.6", question: "Did vision improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q116Answer, onChanged: (val) => setState(() => q116Answer = val)),
                _buildRadioQuestion(number: "11.7", question: "Did symptoms return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q117Answer, onChanged: (val) => setState(() => q117Answer = val)),
                _buildRadioQuestion(number: "11.8", question: "Do you have any pre-existing eye conditions (e.g., glaucoma, cataract)?", options: ['Yes', 'No'], value: q118Answer, onChanged: (val) => setState(() => q118Answer = val)),
                _buildRadioQuestion(number: "11.9", question: "Have you recently experienced visual strain or bright light exposure?", options: ['Yes', 'No'], value: q119Strain, onChanged: (val) => setState(() => q119Strain = val)),
              ],

              // 12. COLOR VISION
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "12",
                question: "Have you noticed any change in your color vision or difficulty distinguishing colors (especially red and green) or reduced contrast in vision?",
                options: ['Yes', 'No'],
                value: q12Answer,
                onChanged: (val) => setState(() => q12Answer = val),
              ),
              if (showColorVision) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "12.1",
                  question: "Was color vision tested (e.g., Ishihara chart or equivalent)?",
                  options: ['Normal', 'Abnormal', 'Not tested'],
                  value: q121Tested,
                  onChanged: (val) => setState(() => q121Tested = val),
                ),
                _buildNumericQuestion(number: "12.2", question: "Ishihara Test Result: Correct plates", value: q122Plates, onChanged: (val) => setState(() => q122Plates = val), hint: "/ 38"),
                _buildRadioQuestion(
                  number: "12.3",
                  question: "How serious is the event?",
                  options: [
                    'Grade 0 – Asymptomatic: No visual complaints; no functional limitation; Ishihara 35–38/38; no intervention required.',
                    'Grade 1 – Mild: Dullness or haziness in vision; subtle difficulty distinguishing colors; no interference with daily activities; Ishihara 25–34/38.',
                    'Grade 2 – Moderate: Noticeable difficulty differentiating colors (e.g., red–green confusion); challenges in reading, driving, recognizing faces, or work-related tasks; Ishihara 15–24/38.',
                    'Grade 3 – Severe: Marked color vision loss significantly interfering with daily functioning; Ishihara 1–14/38.',
                    'Grade 4 – Profound: Near total color vision loss; Ishihara 0/38; possible optic neuropathy requiring urgent evaluation.'
                  ],
                  value: q123Severity,
                  onChanged: (val) => setState(() => q123Severity = val),
                ),
                _buildRadioQuestion(number: "12.4", question: "Did this symptom begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q124Answer, onChanged: (val) => setState(() => q124Answer = val)),
                _buildRadioQuestion(number: "12.5", question: "Did you experience similar visual problems before starting treatment?", options: ['Yes', 'No'], value: q125Answer, onChanged: (val) => setState(() => q125Answer = val)),
                _buildRadioQuestion(number: "12.6", question: "Did the symptom improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q126Answer, onChanged: (val) => setState(() => q126Answer = val)),
                _buildRadioQuestion(number: "12.7", question: "Did the symptom reappear after the medication was restarted?", options: ['Yes', 'No', 'Not applicable'], value: q127Answer, onChanged: (val) => setState(() => q127Answer = val)),
              ],

              // 13. PATCHY VISION LOSS
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "13",
                question: "Have you experienced any patchy or partial loss of vision (missing area in your field of vision) since starting the medication?",
                options: ['Yes', 'No'],
                value: q13Answer,
                onChanged: (val) => setState(() => q13Answer = val),
              ),
              if (showPatchyVision) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "13.1",
                  question: "Specify the affected area:",
                  options: [
                    'Right Upper Quadrant',
                    'Right Lower Quadrant', 
                    'Left Upper Quadrant',
                    'Left Lower Quadrant',
                    'Central vision',
                    'Peripheral vision',
                    'Not sure'
                  ],
                  value: q131Area,
                  onChanged: (val) => setState(() => q131Area = val),
                ),
                _buildRadioQuestion(
                  number: "13.2",
                  question: "How severe is the vision loss?",
                  options: [
                    'Mild: Patchy visual field defect with best corrected visual acuity 20/40 or better (or ≤3-line decrease from baseline); limits instrumental activities only.',
                    'Moderate: Marked field defect with visual acuity worse than 20/40 up to 20/200 (or >3-line decrease from baseline); limits self-care activities.',
                    'Severe: Best corrected visual acuity 20/200 or worse in the affected eye.'
                  ],
                  value: q132Severity,
                  onChanged: (val) => setState(() => q132Severity = val),
                ),
                _buildRadioQuestion(number: "13.3", question: "Did this visual problem begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q133Answer, onChanged: (val) => setState(() => q133Answer = val)),
                _buildRadioQuestion(number: "13.4", question: "Did you have similar visual problems before starting treatment?", options: ['Yes', 'No'], value: q134Answer, onChanged: (val) => setState(() => q134Answer = val)),
                _buildRadioQuestion(number: "13.5", question: "Did the symptom improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q135Answer, onChanged: (val) => setState(() => q135Answer = val)),
                _buildRadioQuestion(number: "13.6", question: "Did the symptom reappear after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q136Answer, onChanged: (val) => setState(() => q136Answer = val)),
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
        label: const Text('Save & Next System', style: TextStyle(fontWeight: FontWeight.bold)),
        heroTag: "save_ocular_next",
        onPressed: _isComplete()
    ? () async {
        await _saveOcular();

        Future.delayed(const Duration(seconds: 1), () {
          widget.onSaveAndComplete();
        });
      }
    : null,
      ),
    );
  }

  // Custom widget for two numeric fields (11.1)
  Widget _buildTwoNumericFields({
    required String number,
    required String label1, required String label2,
    required String? value1, required String? value2,
    required Function(String) onChanged1, required Function(String) onChanged2,
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
            Text("$number. Visual Acuity Assessment (Snellen Chart)", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label1, style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: onChanged1,
                        initialValue: value1,
                        decoration: InputDecoration(
                          hintText: "e.g., 20/20",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label2, style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: onChanged2,
                        initialValue: value2,
                        decoration: InputDecoration(
                          hintText: "e.g., 20/20",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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

  bool _isComplete() {
    if (q11Answer == null || q12Answer == null || q13Answer == null) return false;
    
    if (showBlurring && (
      q111RightEye == null || q111LeftEye == null || q112Baseline == null ||
      q113Severity == null || q114Answer == null || q115Answer == null ||
      q116Answer == null || q117Answer == null || q118Answer == null || q119Strain == null
    )) return false;
    
    if (showColorVision && (
      q121Tested == null || q122Plates == null || q123Severity == null ||
      q124Answer == null || q125Answer == null || q126Answer == null || q127Answer == null
    )) return false;
    
    if (showPatchyVision && (
      q131Area == null || q132Severity == null || q133Answer == null ||
      q134Answer == null || q135Answer == null || q136Answer == null
    )) return false;
    
    return true;
  }

 Future<void> _saveOcular() async {
  print('🔥 OCULAR SAVE - reportId: ${widget.reportId}');
  
  List<Map<String, String>> yesSymptoms = [];
  int savedCount = 0;

  // 11. BLURRING/DECREASE VISION
  if (q11Answer == 'Yes') {
    // Map long UI text to backend severity
    String severity = _mapSeverityToBackend(q113Severity);
    yesSymptoms.add({
      'name': 'Blurring/Decrease Vision',
      'severity': severity,
      'extra': 'Right: ${q111RightEye ?? ''}, Left: ${q111LeftEye ?? ''}',
    });

    // ✅ Backend-compatible follow-ups ONLY
    if (q114Answer == 'Yes') yesSymptoms.add({
      'name': 'Vision symptoms began after medication', 
      'severity': 'mild',  // ✅ Valid
      'extra': '',
    });
    if (q115Answer == 'Yes') yesSymptoms.add({
      'name': 'Pre-existing vision problems', 
      'severity': 'mild',  // ✅ Valid
      'extra': '',
    });
    if (q116Answer == 'Yes') yesSymptoms.add({
      'name': 'Vision improved after stopping medication', 
      'severity': 'mild',  // ✅ Valid
      'extra': '',
    });
    if (q117Answer == 'Yes') yesSymptoms.add({
      'name': 'Vision symptoms returned after restart', 
      'severity': 'mild',  // ✅ Valid
      'extra': '',
    });
    if (q118Answer == 'Yes') yesSymptoms.add({
      'name': 'Pre-existing eye conditions', 
      'severity': 'mild',  // ✅ Valid
      'extra': '',
    });
    if (q119Strain == 'Yes') yesSymptoms.add({
      'name': 'Recent visual strain/light exposure', 
      'severity': 'mild',  // ✅ Valid
      'extra': '',
    });
  }

  // 12. COLOR VISION (same pattern)
   // 12. COLOR VISION
if (q12Answer == 'Yes') {

  bool isGrade0 =
      q123Severity?.contains('Grade 0') == true;

  yesSymptoms.add({
    'name': isGrade0
        ? 'Color Vision Change (grade0)'
        : 'Color Vision Change',
    'severity': _mapSeverityToBackend(q123Severity),
    'extra': 'Ishihara: ${q122Plates ?? 'Not tested'}',
  });

  if (q124Answer == 'Yes') {
    yesSymptoms.add({
      'name': 'Color vision after medication',
      'severity': 'mild',
    });
  }

  if (q125Answer == 'Yes') {
    yesSymptoms.add({
      'name': 'Pre-existing color vision issues',
      'severity': 'mild',
    });
  }

  if (q126Answer == 'Yes') {
    yesSymptoms.add({
      'name': 'Color vision improved after stopping',
      'severity': 'mild',
    });
  }

  if (q127Answer == 'Yes') {
    yesSymptoms.add({
      'name': 'Color vision returned after restart',
      'severity': 'mild',
    });
  }
}

  // 13. PATCHY VISION LOSS
  if (q13Answer == 'Yes') {
    String severity = _mapSeverityToBackend(q132Severity);
    yesSymptoms.add({
      'name': 'Patchy Vision Loss',
      'severity': severity,
      'extra': 'Area: ${q131Area ?? 'Not specified'}',
    });

    if (q133Answer == 'Yes') yesSymptoms.add({'name': 'Patchy vision after medication', 'severity': 'mild', 'extra': ''});
    if (q134Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing patchy vision', 'severity': 'mild', 'extra': ''});
    if (q135Answer == 'Yes') yesSymptoms.add({'name': 'Patchy vision improved after stopping', 'severity': 'mild', 'extra': ''});
    if (q136Answer == 'Yes') yesSymptoms.add({'name': 'Patchy vision returned after restart', 'severity': 'mild', 'extra': ''});
  }

  print('📦 Saving ${yesSymptoms.length} "Yes" symptoms');

  // ✅ Save with CORRECT system_name = "Ocular"
  for (var symptom in yesSymptoms) {
    try {
      bool success = await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "OCULAR INVOLVEMENT",  // ✅ Matches backend exactly
        symptomName: symptom['name']!,
        symptomPresent: "Yes",
        severity: symptom['severity']!,  // ✅ Backend enum values only
      );
      print('✅ ${symptom['name']}: $success');
      if (success) savedCount++;
    } catch (e) {
      print('❌ ${symptom["name"]}: $e');
    }
  }

  _showSaveMessage(savedCount);
}

// ✅ Helper to map long UI severity to backend values
String _mapSeverityToBackend(String? uiSeverity) {
  if (uiSeverity == null) return 'moderate';
  
  if (uiSeverity.contains('Mild') || uiSeverity.contains('Grade 0') || uiSeverity.contains('Grade 1')) return 'mild';
  if (uiSeverity.contains('Moderate') || uiSeverity.contains('Grade 2')) return 'moderate';
  if (uiSeverity.contains('Severe') || uiSeverity.contains('Grade 3') || uiSeverity.contains('Grade 4')) return 'severe';
  
  return 'moderate';  // default
}

  void _showSaveMessage(int savedCount) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(savedCount > 0 
            ? '✅ Saved $savedCount ocular symptoms' 
            : 'ℹ️ No symptoms to save'
          ),
          backgroundColor: savedCount > 0 ? Colors.green : Colors.blue,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}
