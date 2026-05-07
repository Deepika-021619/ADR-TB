import 'package:flutter/material.dart';
import 'systems_api.dart';

class CardiovascularScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;

  const CardiovascularScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<CardiovascularScreen> createState() =>
      _CardiovascularScreenState();
}

class _CardiovascularScreenState
    extends State<CardiovascularScreen> {

  /// ===================== Q1 =====================

  String? q1Answer;
  String? q11Answer;

  List<String> q12Symptoms = [];

  String? q13Answer;
  String? q14Answer;
  String? q15Answer;
  String? q16Answer;
  String? q17History;

  /// ===================== Q2 =====================

  String? q2Answer;
  String? q21Severity;

  List<String> q22Symptoms = [];

  String? q23Onset;
  String? q24PreExisting;
  String? q25Improved;
  String? q26Reappeared;

  /// ===================== Q3 QT =====================

  String? q3Answer;
  String? q31Grade;
  String? q32Increase;

  List<String> q33Symptoms = [];

  String? q34AfterTherapy;
  String? q35BeforeTherapy;
  String? q36Improved;
  String? q37Restarted;

  bool showErrors = false;

  bool get showFollowup => q1Answer == 'Yes';

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

              /// ===================== Q1 =====================

              _buildRadioQuestion(
                number: "1",
                question:
                    "Are you experiencing palpitations?",
                options: ['Yes', 'No'],
                value: q1Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q1Answer = val),
              ),

              if (showFollowup) ...[

                const SizedBox(height: 20),

                Text(
                  "If yes, please continue:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),

                const SizedBox(height: 20),

                /// 1.1
                _buildRadioQuestion(
                  number: "1.1",
                  question:
                      "How severe are the symptoms?",
                  options: [
                    'Mild',
                    'Moderate',
                  ],
                  value: q11Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q11Answer = val),
                ),

                /// 1.2
                _buildCheckboxQuestion(
                  number: "1.2",
                  question: "Associated symptoms",
                  options: [
                    'Dizziness',
                    'Chest pain',
                    'Shortness of breath',
                    'Syncope',
                  ],
                  selected: q12Symptoms,
                  onChanged: (val, checked) {

                    setState(() {

                      if (checked) {
                        q12Symptoms.add(val);
                      } else {
                        q12Symptoms.remove(val);
                      }
                    });
                  },
                ),

                /// 1.3
                _buildRadioQuestion(
                  number: "1.3",
                  question:
                      "Did it start after therapy?",
                  options: ['Yes', 'No'],
                  value: q13Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q13Answer = val),
                ),

                /// 1.4
                _buildRadioQuestion(
                  number: "1.4",
                  question:
                      "Did you have this before treatment?",
                  options: ['Yes', 'No'],
                  value: q14Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q14Answer = val),
                ),

                /// 1.5
                _buildRadioQuestion(
                  number: "1.5",
                  question:
                      "Did it improve after stopping drug?",
                  options: ['Yes', 'No'],
                  value: q15Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q15Answer = val),
                ),

                /// 1.6
                _buildRadioQuestion(
                  number: "1.6",
                  question:
                      "Did it reappear after restarting?",
                  options: ['Yes', 'No'],
                  value: q16Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q16Answer = val),
                ),

                /// 1.7
                _buildRadioQuestion(
                  number: "1.7",
                  question:
                      "History of heart disease?",
                  options: [
                    'No',
                    'Hypertension',
                    'Ischemic heart disease',
                    'Known arrhythmia',
                    'Heart failure',
                    'Other',
                  ],
                  value: q17History,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q17History = val),
                ),
              ],

              /// ===================== Q2 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "2",
                question:
                    "Have you experienced fainting (syncope)?",
                options: ['Yes', 'No'],
                value: q2Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q2Answer = val),
              ),

              if (q2Answer == 'Yes') ...[

                /// 2.1
                _buildRadioQuestion(
                  number: "2.1",
                  question:
                      "Severity of episode",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                  ],
                  value: q21Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q21Severity = val),
                ),

                /// 2.2
                _buildCheckboxQuestion(
                  number: "2.2",
                  question: "Associated symptoms",
                  options: [
                    'Palpitations',
                    'Chest pain',
                    'Seizure-like activity',
                    'Head injury',
                  ],
                  selected: q22Symptoms,
                  onChanged: (val, checked) {

                    setState(() {

                      if (checked) {
                        q22Symptoms.add(val);
                      } else {
                        q22Symptoms.remove(val);
                      }
                    });
                  },
                ),

                /// 2.3
                _buildRadioQuestion(
                  number: "2.3",
                  question:
                      "Did it start after therapy?",
                  options: ['Yes', 'No'],
                  value: q23Onset,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q23Onset = val),
                ),

                /// 2.4
                _buildRadioQuestion(
                  number: "2.4",
                  question:
                      "Did it exist before treatment?",
                  options: ['Yes', 'No'],
                  value: q24PreExisting,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q24PreExisting = val),
                ),

                /// 2.5
                _buildRadioQuestion(
                  number: "2.5",
                  question:
                      "Did it improve after stopping drug?",
                  options: ['Yes', 'No'],
                  value: q25Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q25Improved = val),
                ),

                /// 2.6
                _buildRadioQuestion(
                  number: "2.6",
                  question:
                      "Did it reappear after restarting?",
                  options: ['Yes', 'No'],
                  value: q26Reappeared,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q26Reappeared = val),
                ),
              ],

              /// ===================== Q3 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "3",
                question:
                    "Was QTc prolongation detected on ECG?",
                options: ['Yes', 'No'],
                value: q3Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q3Answer = val),
              ),

              if (q3Answer == 'Yes') ...[

                /// 3.1
                _buildRadioQuestion(
                  number: "3.1",
                  question:
                      "Recorded QTc interval",
                  options: [
                    'Grade 1 (450–480 ms)',
                    'Grade 2 (481–500 ms)',
                    'Grade 3 (>500 ms)',
                    'Grade 4 (Torsades/serious arrhythmia)',
                  ],
                  value: q31Grade,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q31Grade = val),
                ),

                /// 3.2
                _buildRadioQuestion(
                  number: "3.2",
                  question:
                      "Was there >60 ms increase from baseline?",
                  options: [
                    'Yes',
                    'No',
                    'Baseline not available',
                  ],
                  value: q32Increase,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q32Increase = val),
                ),

                /// 3.3
                _buildCheckboxQuestion(
                  number: "3.3",
                  question:
                      "Associated symptoms",
                  options: [
                    'Syncope',
                    'Palpitations',
                    'Dizziness',
                    'Ventricular arrhythmia',
                  ],
                  selected: q33Symptoms,
                  onChanged: (val, checked) {

                    setState(() {

                      if (checked) {
                        q33Symptoms.add(val);
                      } else {
                        q33Symptoms.remove(val);
                      }
                    });
                  },
                ),

                /// 3.4
                _buildRadioQuestion(
                  number: "3.4",
                  question:
                      "Did it develop after therapy?",
                  options: ['Yes', 'No'],
                  value: q34AfterTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q34AfterTherapy = val),
                ),

                /// 3.5
                _buildRadioQuestion(
                  number: "3.5",
                  question:
                      "Was QT prolongation present before therapy?",
                  options: [
                    'Yes',
                    'No',
                    'Baseline ECG unavailable',
                  ],
                  value: q35BeforeTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q35BeforeTherapy = val),
                ),

                /// 3.6
                _buildRadioQuestion(
                  number: "3.6",
                  question:
                      "Did QT improve after stopping drug?",
                  options: ['Yes', 'No'],
                  value: q36Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q36Improved = val),
                ),

                /// 3.7
                _buildRadioQuestion(
                  number: "3.7",
                  question:
                      "Did QT prolongation reappear after restart?",
                  options: ['Yes', 'No'],
                  value: q37Restarted,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q37Restarted = val),
                ),
              ],

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,

      floatingActionButton:
          FloatingActionButton.extended(

        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,

        label: const Text(
          "Save & Next System",
        ),

        onPressed: () async {

          if (!_validateForm()) {

            setState(() => showErrors = true);

            ScaffoldMessenger.of(context).showSnackBar(

              const SnackBar(
                content: Text(
                  "Please answer all required questions",
                ),
                backgroundColor: Colors.red,
              ),
            );

            return;
          }

          await _saveCardio();

          if (!mounted) return;

          widget.onSaveAndComplete();
        },
      ),
    );
  }

  /// ===================== VALIDATION =====================

  bool _validateForm() {

    if (q1Answer == null) return false;

    if (q1Answer == 'Yes') {

      if (q11Answer == null) return false;
      if (q13Answer == null) return false;
      if (q14Answer == null) return false;
      if (q15Answer == null) return false;
      if (q16Answer == null) return false;
      if (q17History == null) return false;
    }

    if (q2Answer == null) return false;

    if (q2Answer == 'Yes') {

      if (q21Severity == null) return false;
      if (q23Onset == null) return false;
      if (q24PreExisting == null) return false;
      if (q25Improved == null) return false;
      if (q26Reappeared == null) return false;
    }

    if (q3Answer == null) return false;

    if (q3Answer == 'Yes') {

      if (q31Grade == null) return false;
      if (q32Increase == null) return false;
      if (q34AfterTherapy == null) return false;
      if (q35BeforeTherapy == null) return false;
      if (q36Improved == null) return false;
      if (q37Restarted == null) return false;
    }

    return true;
  }

  /// ===================== UI HELPERS =====================

  Widget _buildRadioQuestion({

    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String) onChanged,

    bool isRequired = false,
    bool showError = false,
  }) {

    return Card(

      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            RichText(

              text: TextSpan(

                text: "$number. $question",

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),

                children: [

                  if (isRequired)

                    const TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            ...options.map(

              (opt) => RadioListTile<String>(

                title: Text(opt),
                value: opt,
                groupValue: value,

                onChanged: (val) =>
                    onChanged(val!),
              ),
            ),

            if (showError && value == null)

              const Padding(

                padding:
                    EdgeInsets.only(top: 6),

                child: Text(
                  "This question is required",

                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxQuestion({

    required String number,
    required String question,
    required List<String> options,
    required List<String> selected,
    required Function(String, bool)
        onChanged,
  }) {

    return Card(

      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              "$number. $question",

              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            ...options.map(

              (opt) => CheckboxListTile(

                title: Text(opt),
                value: selected.contains(opt),

                onChanged: (val) =>
                    onChanged(opt, val ?? false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===================== SAVE =====================

  Future<void> _saveCardio() async {

    List<Map<String, String>> symptoms = [];

    /// ---------- Q1 ----------

    if (q1Answer == 'Yes') {

      symptoms.add({
        'name': 'Palpitations',
        'severity':
            (q11Answer ?? 'moderate')
                .toLowerCase(),
      });

      if (q13Answer == 'Yes') {

        symptoms.add({
          'name':
              'Palpitations after medication',
          'severity': 'mild',
        });
      }

      if (q15Answer == 'Yes') {

        symptoms.add({
          'name':
              'Palpitations improved after stopping',
          'severity': 'mild',
        });
      }

      if (q16Answer == 'Yes') {

        symptoms.add({
          'name':
              'Palpitations returned after restart',
          'severity': 'mild',
        });
      }

      if (q12Symptoms.contains('Dizziness')) {

        symptoms.add({
          'name': 'Dizziness',
          'severity': 'mild',
        });
      }

      if (q12Symptoms.contains('Chest pain')) {

        symptoms.add({
          'name': 'Chest pain',
          'severity': 'moderate',
        });
      }

      if (q12Symptoms.contains(
          'Shortness of breath')) {

        symptoms.add({
          'name':
              'Shortness of breath',
          'severity': 'moderate',
        });
      }

      if (q12Symptoms.contains('Syncope')) {

        symptoms.add({
          'name': 'Syncope',
          'severity': 'severe',
        });
      }
    }

    /// ---------- Q2 ----------

    if (q2Answer == 'Yes') {

      symptoms.add({
        'name': 'Syncope',
        'severity':
            _mapSyncopeSeverity(
                q21Severity),
      });

      if (q23Onset == 'Yes') {

        symptoms.add({
          'name':
              'Syncope after medication',
          'severity': 'mild',
        });
      }

      if (q25Improved == 'Yes') {

        symptoms.add({
          'name':
              'Syncope improved after stopping',
          'severity': 'mild',
        });
      }

      if (q26Reappeared == 'Yes') {

        symptoms.add({
          'name':
              'Syncope returned after restart',
          'severity': 'mild',
        });
      }

      if (q22Symptoms.contains(
          'Palpitations')) {

        symptoms.add({
          'name':
              'Palpitations during syncope',
          'severity': 'moderate',
        });
      }

      if (q22Symptoms.contains(
          'Chest pain')) {

        symptoms.add({
          'name':
              'Chest pain during syncope',
          'severity': 'moderate',
        });
      }

      if (q22Symptoms.contains(
          'Seizure-like activity')) {

        symptoms.add({
          'name':
              'Seizure-like activity',
          'severity': 'severe',
        });
      }

      if (q22Symptoms.contains(
          'Head injury')) {

        symptoms.add({
          'name':
              'Head injury due to syncope',
          'severity': 'severe',
        });
      }
    }

    /// ---------- Q3 QT ----------

    if (q3Answer == 'Yes') {

      symptoms.add({
        'name': 'QT prolongation',
        'severity':
            _mapQTSeverity(q31Grade),
      });

      if (q34AfterTherapy == 'Yes') {

        symptoms.add({
          'name':
              'QT prolongation after medication',
          'severity': 'mild',
        });
      }

      if (q36Improved == 'Yes') {

        symptoms.add({
          'name':
              'QT improved after stopping',
          'severity': 'mild',
        });
      }

      if (q37Restarted == 'Yes') {

        symptoms.add({
          'name':
              'QT prolongation returned after restart',
          'severity': 'moderate',
        });
      }

      if (q33Symptoms.contains(
          'Syncope')) {

        symptoms.add({
          'name':
              'Syncope during QT prolongation',
          'severity': 'severe',
        });
      }

      if (q33Symptoms.contains(
          'Palpitations')) {

        symptoms.add({
          'name':
              'Palpitations during QT prolongation',
          'severity': 'moderate',
        });
      }

      if (q33Symptoms.contains(
          'Dizziness')) {

        symptoms.add({
          'name':
              'Dizziness during QT prolongation',
          'severity': 'mild',
        });
      }

      if (q33Symptoms.contains(
          'Ventricular arrhythmia')) {

        symptoms.add({
          'name':
              'Ventricular arrhythmia',
          'severity': 'severe',
        });
      }
    }

    /// ---------- SAVE ----------

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId: widget.reportId,

        questionnaireSystem:
            "CARDIOVASCULAR SYSTEM",

        symptomName: s['name']!,

        symptomPresent: "Yes",

        severity: s['severity']!,

        regimenType: "SLD",
      );
    }
  }

  /// ===================== MAPPERS =====================

  String _mapSyncopeSeverity(
      String? value) {

    switch (value) {

      case 'Mild':
        return 'mild';

      case 'Moderate':
        return 'moderate';

      case 'Severe':
        return 'severe';

      default:
        return 'moderate';
    }
  }

  String _mapQTSeverity(
      String? value) {

    switch (value) {

      case 'Grade 1 (450–480 ms)':
        return 'mild';

      case 'Grade 2 (481–500 ms)':
        return 'moderate';

      case 'Grade 3 (>500 ms)':
        return 'severe';

      case 'Grade 4 (Torsades/serious arrhythmia)':
        return 'life threatening';

      default:
        return 'moderate';
    }
  }
}