import 'package:flutter/material.dart';
import 'systems_api.dart';

class MusculoskeletalSLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const MusculoskeletalSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<MusculoskeletalSLDScreen> createState() =>
      _MusculoskeletalSLDScreenState();
}

class _MusculoskeletalSLDScreenState
    extends State<MusculoskeletalSLDScreen> {

  /// ===================== Q24 =====================

  String? q24Answer;

  String? q241Severity;

  String? q242AfterTherapy;

  String? q243BeforeTherapy;

  String? q244Improved;

  String? q245Restarted;

  /// ===================== Q25 =====================

  String? q25Answer;

  String? q251Severity;

  String? q252AfterTherapy;

  String? q253BeforeTherapy;

  String? q254Improved;

  String? q255Restarted;

  bool showErrors = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue[50],

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// ===================== Q24 =====================

              _buildRadioQuestion(

                number: "24",

                question:
                    "Have you experienced tendon pain during TB treatment?",

                options: ['Yes','No','Unknown'],

                value: q24Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q24Answer = val),
              ),

              if (q24Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "24.1",

                  question:
                      "How severe was the pain?",

                  options: [

                    'Mild – I had pain, but it did not affect my daily activities',

                    'Moderate – The pain limited walking, climbing stairs, or routine activities',

                    'Severe – I was unable to walk normally or required medical evaluation',

                    'Tendon rupture – Sudden severe pain with swelling and inability to move the foot/ankle',
                  ],

                  value: q241Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q241Severity = val),
                ),

                _buildRadioQuestion(

                  number: "24.2",

                  question:
                      "Did this problem start after anti-TB therapy?",

                  options: ['Yes','No','Unknown'],

                  value: q242AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q242AfterTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "24.3",

                  question:
                      "Did you have similar tendon pain before therapy?",

                  options: ['Yes','No','Unknown'],

                  value: q243BeforeTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q243BeforeTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "24.4",

                  question:
                      "Did the pain improve after stopping or adjusting the drug?",

                  options: ['Yes','No','Unknown'],

                  value: q244Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q244Improved = val),
                ),

                _buildRadioQuestion(

                  number: "24.5",

                  question:
                      "Did the pain return after restarting the drug?",

                  options: ['Yes','No','Unknown'],

                  value: q245Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q245Restarted = val),
                ),
              ],

              /// ===================== Q25 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "25",

                question:
                    "Have you experienced generalized muscle pain during TB treatment?",

                options: ['Yes','No','Unknown'],

                value: q25Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q25Answer = val),
              ),

              if (q25Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "25.1",

                  question:
                      "How severe was the muscle pain?",

                  options: [

                    'Mild – Muscle pain causing no or minimal interference with usual activities',

                    'Moderate – Muscle pain causing greater than minimal interference with usual activities',

                    'Severe – Muscle pain causing inability to perform usual activities',

                    'Disabling – Muscle pain causing inability to perform basic self-care functions',
                  ],

                  value: q251Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q251Severity = val),
                ),

                _buildRadioQuestion(

                  number: "25.2",

                  question:
                      "Did this symptom start after anti-TB therapy?",

                  options: ['Yes','No','Unknown'],

                  value: q252AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q252AfterTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "25.3",

                  question:
                      "Did you have similar muscle pain before therapy?",

                  options: ['Yes','No','Unknown'],

                  value: q253BeforeTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q253BeforeTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "25.4",

                  question:
                      "Did the symptom improve after stopping or adjusting the drug?",

                  options: ['Yes','No','Unknown'],

                  value: q254Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q254Improved = val),
                ),

                _buildRadioQuestion(

                  number: "25.5",

                  question:
                      "Did the symptom reappear after restarting the drug?",

                  options: ['Yes','No','Unknown'],

                  value: q255Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q255Restarted = val),
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

        label:
            const Text(
              "Save & Next System",
            ),

        onPressed: () async {

          if (!_validateForm()) {

            setState(() => showErrors = true);

            ScaffoldMessenger.of(context)
                .showSnackBar(

              const SnackBar(

                content: Text(
                  "Please answer all required questions",
                ),

                backgroundColor: Colors.red,
              ),
            );

            return;
          }

          await _saveMusculoskeletal();

          if (!mounted) return;

          Navigator.pop(context, true);
        },
      ),
    );
  }

  /// ===================== VALIDATION =====================

  bool _validateForm() {

    if (q24Answer == null) {
      return false;
    }

    if (q25Answer == null) {
      return false;
    }

    if (q24Answer == 'Yes') {

      if (q241Severity == null) return false;

      if (q242AfterTherapy == null) return false;

      if (q243BeforeTherapy == null) return false;

      if (q244Improved == null) return false;

      if (q245Restarted == null) return false;
    }

    if (q25Answer == 'Yes') {

      if (q251Severity == null) return false;

      if (q252AfterTherapy == null) return false;

      if (q253BeforeTherapy == null) return false;

      if (q254Improved == null) return false;

      if (q255Restarted == null) return false;
    }

    return true;
  }

  /// ===================== SAVE =====================

  Future<void> _saveMusculoskeletal() async {

    List<Map<String, dynamic>> symptoms = [];

    /// ---------- Q24 ----------

    if (q24Answer == 'Yes') {

      symptoms.add({

        'name': 'Tendon pain',

        'severity':
            _mapSeverity(q241Severity),
      });

      if (q242AfterTherapy =='Yes') {

        symptoms.add({

          'name':
              'Tendon pain after anti-TB therapy',

          'severity': 'N/A',
        });
      }

      if (q243BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Tendon pain before therapy',

          'severity': 'N/A',
        });
      }

      if (q244Improved == 'Yes') {

        symptoms.add({

          'name':
              'Tendon pain improved after stopping drug',

          'severity': 'N/A',
        });
      }

      if (q245Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Tendon pain restarted after rechallenge',

          'severity': 'N/A',
        });
      }
    }

    /// ---------- Q25 ----------

    if (q25Answer == 'Yes') {

      symptoms.add({

        'name':
            'Generalized muscle pain',

        'severity':
            _mapMuscleSeverity(q251Severity),
      });

      if (q252AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Muscle pain after anti-TB therapy',

          'severity': 'N/A',
        });
      }

      if (q253BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Muscle pain before therapy',

          'severity': 'N/A',
        });
      }

      if (q254Improved == 'Yes') {

        symptoms.add({

          'name':
              'Muscle pain improved after stopping drug',

          'severity': 'N/A',
        });
      }

      if (q255Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Muscle pain restarted after rechallenge',

          'severity': 'N/A',
        });
      }
    }

    /// ---------- SAVE ----------

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId:
            widget.reportId,

        questionnaireSystem:
            "Musculoskeletal",

        symptomName:
            s['name'],

        symptomPresent:
            "Yes",

        severity:
            s['severity'],

        durationWeeks: null,

        regimenType:
            "SLD",
      );
    }
  }

  /// ===================== HELPERS =====================

  String _mapSeverity(String? value) {

    if (value == null) {
      return 'moderate';
    }

    final lower =
        value.toLowerCase();

    if (lower.contains('mild')) {
      return 'mild';
    }

    if (lower.contains('moderate')) {
      return 'moderate';
    }

    if (lower.contains('severe')) {
      return 'severe';
    }

    if (lower.contains('rupture')) {
      return 'life threatening';
    }

    return 'moderate';
  }

  String _mapMuscleSeverity(String? value) {

    if (value == null) {
      return 'moderate';
    }

    final lower =
        value.toLowerCase();

    if (lower.contains('mild')) {
      return 'mild';
    }

    if (lower.contains('moderate')) {
      return 'moderate';
    }

    if (lower.contains('severe')) {
      return 'severe';
    }

    if (lower.contains('disabling')) {
      return 'life threatening';
    }

    return 'moderate';
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

      margin:
          const EdgeInsets.only(bottom: 16),

      elevation: 2,

      child: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            RichText(

              text: TextSpan(

                text:
                    "$number. $question",

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.black,

                  fontSize: 16,
                ),

                children: [

                  if (isRequired)

                    const TextSpan(

                      text: " *",

                      style:
                          TextStyle(
                        color:
                            Colors.red,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            ...options.map(

              (opt) => RadioListTile<String>(

                title:
                    Text(opt),

                value: opt,

                groupValue:
                    value,

                onChanged:
                    (val) =>
                        onChanged(val!),
              ),
            ),

            if (showError &&
                value == null)

              const Padding(

                padding:
                    EdgeInsets.only(
                        top: 6),

                child: Text(

                  "This question is required",

                  style: TextStyle(

                    color:
                        Colors.red,

                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}