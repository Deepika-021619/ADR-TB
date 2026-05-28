import 'package:flutter/material.dart';
import 'systems_api.dart';

class AuditorySLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const AuditorySLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<AuditorySLDScreen> createState() =>
      _AuditorySLDScreenState();
}

class _AuditorySLDScreenState
    extends State<AuditorySLDScreen> {

  /// ===================== Q12 Hearing loss =====================

  String? q12Answer;
  String? q121Severity;
  String? q122AfterTherapy;
  String? q123BeforeTherapy;
  String? q124Improved;
  String? q125Restarted;
  String? q126Audiometry;

  /// ===================== Q13 Tinnitus =====================

  String? q13Answer;
  String? q131Frequency;
  String? q132AfterTherapy;
  String? q133BeforeTherapy;
  String? q134Improved;
  String? q135Restarted;

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

              /// ===================== Q12 =====================

              _buildRadioQuestion(

                number: "12",

                question:
                    "Have you noticed any change in your hearing during TB treatment?",

                options: ['Yes', 'No','Unknown'],

                value: q12Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q12Answer = val),
              ),

              if (q12Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "12.1",

                  question:
                      "How would you describe your hearing problem?",

                  options: [

                    'Mild – I notice slight difficulty hearing, but I can manage conversations normally',

                    'Moderate – I have noticeable hearing difficulty that affects daily activities',

                    'Severe – I need medical evaluation or was advised a hearing aid',

                    'Very severe – I have almost complete hearing loss in both ears',
                  ],

                  value: q121Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() => q121Severity = val),
                ),

                _buildYesNoQuestion(

                  "12.2",

                  "Did this problem start after beginning anti-TB therapy?",

                  q122AfterTherapy,

                  (v) => setState(() =>
                      q122AfterTherapy = v),
                ),

                _buildYesNoQuestion(

                  "12.3",

                  "Did you have hearing problems before starting therapy?",

                  q123BeforeTherapy,

                  (v) => setState(() =>
                      q123BeforeTherapy = v),
                ),

                _buildYesNoQuestion(

                  "12.4",

                  "Did the hearing problem improve when the drug was stopped or adjusted?",

                  q124Improved,

                  (v) => setState(() =>
                      q124Improved = v),
                ),

                _buildYesNoQuestion(

                  "12.5",

                  "Did the hearing problem return when the drug was restarted?",

                  q125Restarted,

                  (v) => setState(() =>
                      q125Restarted = v),
                ),

                _buildYesNoQuestion(

                  "12.6",

                  "Was a hearing test (audiometry) done before/during treatment?",

                  q126Audiometry,

                  (v) => setState(() =>
                      q126Audiometry = v),
                ),
              ],

              /// ===================== Q13 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "13",

                question:
                    "Have you experienced ringing, buzzing, or unusual sounds in your ears during TB treatment?",

                options: ['Yes', 'No','Unknown'],

                value: q13Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q13Answer = val),
              ),

              if (q13Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "13.1",

                  question:
                      "How often did you experience this sound?",

                  options: [

                    'Intermittent – It comes and goes',

                    'Persistent – It is present most of the time',

                    'Severe – It is constant and interferes with my sleep or daily activities',
                  ],

                  value: q131Frequency,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() => q131Frequency = val),
                ),

                _buildYesNoQuestion(

                  "13.2",

                  "Did this problem start after beginning anti-TB therapy?",

                  q132AfterTherapy,

                  (v) => setState(() =>
                      q132AfterTherapy = v),
                ),

                _buildYesNoQuestion(

                  "13.3",

                  "Did you have similar symptoms before starting therapy?",

                  q133BeforeTherapy,

                  (v) => setState(() =>
                      q133BeforeTherapy = v),
                ),

                _buildYesNoQuestion(

                  "13.4",

                  "Did the symptom improve when the drug was stopped or adjusted?",

                  q134Improved,

                  (v) => setState(() =>
                      q134Improved = v),
                ),

                _buildYesNoQuestion(

                  "13.5",

                  "Did the symptom return when the drug was restarted?",

                  q135Restarted,

                  (v) => setState(() =>
                      q135Restarted = v),
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

          final saved =
              await _saveAuditory();

          if (!mounted) return;

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(

              content: Text(

                saved
                    ? "Symptoms saved successfully"
                    : "No symptoms selected",
              ),

              backgroundColor:
                  saved
                      ? Colors.green
                      : Colors.orange,
            ),
          );

          widget.onSaveAndComplete();
        },
      ),
    );
  }

  /// ================= VALIDATION =================

  bool _validateForm() {

    if (q12Answer == null) return false;

    if (q13Answer == null) return false;

    return true;
  }

  /// ================= SAVE =================

  Future<bool> _saveAuditory() async {

    List<Map<String, String>> symptoms = [];

    /// ================= HEARING LOSS =================

    if (q12Answer == 'Yes') {

      symptoms.add({

        'name': 'Hearing loss',

        'severity':
            _mapHearingSeverity(q121Severity),
      });

      if (q122AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Hearing loss after medication',

          'severity': 'mild',
        });
      }

      if (q123BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Hearing loss before treatment',

          'severity': 'mild',
        });
      }

      if (q124Improved == 'Yes') {

        symptoms.add({

          'name':
              'Hearing loss improved after stopping',

          'severity': 'mild',
        });
      }

      if (q125Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Hearing loss returned after restart',

          'severity': 'moderate',
        });
      }

      if (q126Audiometry == 'Yes') {

        symptoms.add({

          'name': 'Audiometry done',

          'severity': 'mild',
        });
      }
    }

    /// ================= TINNITUS =================

    if (q13Answer == 'Yes') {

      symptoms.add({

        'name': 'Tinnitus',

        'severity':
            _mapTinnitusSeverity(q131Frequency),
      });

      if (q132AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Tinnitus after medication',

          'severity': 'mild',
        });
      }

      if (q133BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Tinnitus before treatment',

          'severity': 'mild',
        });
      }

      if (q134Improved == 'Yes') {

        symptoms.add({

          'name':
              'Tinnitus improved after stopping',

          'severity': 'mild',
        });
      }

      if (q135Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Tinnitus returned after restart',

          'severity': 'moderate',
        });
      }
    }

    if (symptoms.isEmpty) {

      return false;
    }

    /// ================= SAVE =================

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId: widget.reportId,

        questionnaireSystem: "Auditory",

        symptomName: s['name']!,

        symptomPresent: "Yes",

        severity: s['severity']!,

        regimenType: "SLD",
      );
    }

    return true;
  }

  /// ================= SEVERITY =================

  String _mapHearingSeverity(
      String? value) {

    if (value == null) {
      return 'moderate';
    }

    if (value.startsWith('Mild')) {
      return 'mild';
    }

    if (value.startsWith('Moderate')) {
      return 'moderate';
    }

    if (value.startsWith('Severe')) {
      return 'severe';
    }

    if (value.startsWith('Very severe')) {
      return 'life threatening';
    }

    return 'moderate';
  }

  String _mapTinnitusSeverity(
      String? value) {

    if (value == null) {
      return 'moderate';
    }

    if (value.startsWith('Intermittent')) {
      return 'mild';
    }

    if (value.startsWith('Persistent')) {
      return 'moderate';
    }

    if (value.startsWith('Severe')) {
      return 'severe';
    }

    return 'moderate';
  }

  /// ================= HELPERS =================

  Widget _buildYesNoQuestion(

    String number,

    String question,

    String? value,

    Function(String) onChanged,
  ) {

    return _buildRadioQuestion(

      number: number,

      question: question,

      options: ['Yes', 'No','Unknown'],

      value: value,

      onChanged: onChanged,

      isRequired: true,

      showError: showErrors,
    );
  }

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
}