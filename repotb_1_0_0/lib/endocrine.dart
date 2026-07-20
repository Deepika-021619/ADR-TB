import 'package:flutter/material.dart';
import 'systems_api.dart';

class EndocrineSLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const EndocrineSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<EndocrineSLDScreen> createState() =>
      _EndocrineSLDScreenState();
}

class _EndocrineSLDScreenState
    extends State<EndocrineSLDScreen> {

  /// ===================== Q23 =====================

  String? q23Answer;

  String? q231Severity;

  String? q232Menstrual;

  String? q233WeightGain;

  String? q234Duration;

  String? q235Cold;

  String? q236AfterTherapy;

  String? q237BeforeTherapy;

  String? q238TSHDone;

  String? q239TSHResult;

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

              /// ===================== Q23 =====================

              _buildRadioQuestion(

                number: "23",

                question:
                    "Have you experienced symptoms of thyroid problems during TB treatment?",

                options: ['Yes','No','Unknown'],

                value: q23Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q23Answer = val),
              ),

              if (q23Answer == 'Yes') ...[

                /// 23.1

                _buildRadioQuestion(

                  number: "23.1",

                  question:
                      "How severe were your symptoms?",

                  options: [

                    'Mild – I had symptoms, but they did not affect my daily activities',

                    'Moderate – I had symptoms and was started on thyroid medication; my daily routine was affected',

                    'Severe – My symptoms made it difficult to take care of myself and I required hospital care',

                    'Very severe – I had a life-threatening thyroid problem requiring urgent emergency treatment',
                  ],

                  value: q231Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q231Severity = val),
                ),

                /// 23.2

                _buildRadioQuestion(

                  number: "23.2",

                  question:
                      "Have you had menstrual irregularity, what type?",

                  options: [

                    'Delayed cycles (more than 7 days late)',

                    'Missed periods / infrequent periods',

                    'Heavy bleeding',

                    'Not applicable',
                  ],

                  value: q232Menstrual,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q232Menstrual = val),
                ),

                /// 23.3

                _buildRadioQuestion(

                  number: "23.3",

                  question:
                      "How much weight have you gained?",

                  options: [

                    'Less than 2 kg',

                    '2–5 kg',

                    'More than 5 kg',

                    'Not sure',
                  ],

                  value: q233WeightGain,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q233WeightGain = val),
                ),

                /// 23.4

                _buildRadioQuestion(

                  number: "23.4",

                  question:
                      "Over what duration?",

                  options: [

                    'Less than 1 month',

                    '1–3 months',

                    'More than 3 months',
                  ],

                  value: q234Duration,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q234Duration = val),
                ),

                /// 23.5

                _buildRadioQuestion(

                  number: "23.5",

                  question:
                      "Do you feel cold even when others feel comfortable?",

                  options: [

                    'Occasionally',

                    'Frequently',

                    'Almost always',
                  ],

                  value: q235Cold,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q235Cold = val),
                ),

                /// 23.6

                _buildRadioQuestion(

                  number: "23.6",

                  question:
                      "Did these symptoms start after anti-TB therapy?",

                  options: [

                    'Yes',

                   'No','Unknown',
                  ],

                  value: q236AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q236AfterTherapy = val),
                ),

                /// 23.7

                _buildRadioQuestion(

                  number: "23.7",

                  question:
                      "Did you have thyroid problems before therapy?",

                  options: [

                    'Yes',

                   'No','Unknown',
                  ],

                  value: q237BeforeTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q237BeforeTherapy = val),
                ),

                /// 23.8

                _buildRadioQuestion(

                  number: "23.8",

                  question:
                      "Was a thyroid test (TSH) done?",

                  options: [

                    'Yes',

                   'No','Unknown',
                  ],

                  value: q238TSHDone,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q238TSHDone = val),
                ),

                /// 23.9

                if (q238TSHDone == 'Yes')

                  _buildRadioQuestion(

                    number: "23.9",

                    question:
                        "What was the TSH result?",

                    options: [

                      'TSH mildly elevated (less than 10 mIU/L)',

                      'TSH elevated more than 10 mIU/L',

                      'I was diagnosed with hypothyroidism and started on thyroid medication',

                      'I do not know the value',
                    ],

                    value: q239TSHResult,

                    isRequired: true,

                    showError: showErrors,

                    onChanged: (val) =>
                        setState(() =>
                            q239TSHResult = val),
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

          await _saveEndocrine();

          if (!mounted) return;

          Navigator.pop(context, true);
        },
      ),
    );
  }

  /// ===================== VALIDATION =====================

  bool _validateForm() {

    if (q23Answer == null) {
      return false;
    }

    if (q23Answer == 'Yes') {

      if (q231Severity == null) return false;

      if (q232Menstrual == null) return false;

      if (q233WeightGain == null) return false;

      if (q234Duration == null) return false;

      if (q235Cold == null) return false;

      if (q236AfterTherapy == null) return false;

      if (q237BeforeTherapy == null) return false;

      if (q238TSHDone == null) return false;

      if (q238TSHDone == 'Yes' &&
          q239TSHResult == null) {
        return false;
      }
    }

    return true;
  }

  /// ===================== SAVE =====================

  Future<void> _saveEndocrine() async {

    List<Map<String, dynamic>> symptoms = [];

    if (q23Answer == 'Yes') {

      /// Main symptom

      symptoms.add({

        'name':
            'Thyroid disorder symptoms',

        'severity':
            _mapSeverity(q231Severity),

        'duration': null,
      });

      /// Menstrual irregularity

      if (q232Menstrual != null &&
          q232Menstrual != 'Not applicable') {

        symptoms.add({

          'name':
              'Menstrual irregularity - $q232Menstrual',

          'severity': 'N/A',
        });
      }

      /// Weight gain

      if (q233WeightGain != null) {

        symptoms.add({

          'name':
              'Weight gain - $q233WeightGain',

          'severity': 'N/A',
        });
      }

      /// Duration

      if (q234Duration != null) {

        symptoms.add({

          'name':
              'Weight gain duration - $q234Duration',

          'severity': 'N/A',

        });
      }

      /// Cold intolerance

      if (q235Cold != null) {

        symptoms.add({

          'name':
              'Cold intolerance - $q235Cold',

          'severity': 'N/A',
        });
      }

      /// After therapy

      if (q236AfterTherapy =='Yes') {

        symptoms.add({

          'name':
              'Symptoms after anti-TB therapy',

          'severity': 'N/A',
        });
      }

      /// Before therapy

      if (q237BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Previous thyroid disease before therapy',

          'severity': 'N/A',
        });
      }

      /// TSH done

      if (q238TSHDone == 'Yes') {

        symptoms.add({

          'name':
              'TSH test performed',

          'severity': 'N/A',
        });
      }

      /// TSH result

      if (q238TSHDone == 'Yes' &&
    q239TSHResult != null) {

        symptoms.add({

          'name':
              'TSH result - $q239TSHResult',

          'severity': 'N/A',
        });
      }
    }

    /// SAVE

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId:
            widget.reportId,

        questionnaireSystem:
            "ENDOCRINE",

        symptomName:
            s['name'],

        symptomPresent:
            "Yes",

        severity:
            s['severity'],

        durationWeeks:
            s['duration'] != null
                ? int.tryParse(
                    s['duration']
                        .toString(),
                  )
                : null,

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

    if (lower.contains('severe') &&
        !lower.contains('very')) {
      return 'severe';
    }

    if (lower.contains('very severe') ||
        lower.contains('life-threatening')) {
      return 'life threatening';
    }

    return 'moderate';
  }

  int? _mapDuration(String? value) {

    switch (value) {

      case 'Less than 1 month':
        return 4;

      case '1–3 months':
        return 12;

      case 'More than 3 months':
        return 16;

      default:
        return null;
    }
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