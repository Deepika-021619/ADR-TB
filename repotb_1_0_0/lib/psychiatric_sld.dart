import 'package:flutter/material.dart';
import 'systems_api.dart';

class PsychiatricSLDScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;

  const PsychiatricSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<PsychiatricSLDScreen> createState() =>
      _PsychiatricSLDScreenState();
}

class _PsychiatricSLDScreenState
    extends State<PsychiatricSLDScreen> {

  /// ===================== Q7 Anxiety =====================

  String? q7Answer;
  String? q71Severity;
  String? q72AfterTherapy;
  String? q73BeforeTherapy;
  String? q74Improved;
  String? q75Restarted;

  /// ===================== Q8 Depression =====================

  String? q8Answer;
  String? q81Frequency;
  String? q82Severity;
  String? q83Interference;
  String? q84AfterTherapy;
  String? q85BeforeTherapy;
  String? q86Improved;
  String? q87Restarted;

  /// ===================== Q9 Suicidal ideation =====================

  String? q9Answer;
  String? q91Severity;
  String? q92AfterTherapy;
  String? q93BeforeTherapy;
  String? q94Improved;
  String? q95Restarted;

  /// ===================== Q10 Psychosis =====================

  String? q10Answer;
  String? q101Severity;
  String? q102AfterTherapy;
  String? q103BeforeTherapy;
  String? q104Improved;
  String? q105Restarted;

  /// ===================== Q11 Insomnia =====================

  String? q11Answer;
  String? q111Severity;
  String? q112AfterTherapy;
  String? q113BeforeTherapy;
  String? q114Improved;
  String? q115Restarted;

  bool showErrors = false;
  bool emergencyShown = false;

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

              /// ===================== Q7 =====================

              _buildRadioQuestion(
                number: "7",
                question:
                    "Have you felt unusually anxious, nervous, or worried during TB treatment?",
                options: ['Yes', 'No'],
                value: q7Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q7Answer = val),
              ),

              if (q7Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "7.1",
                  question: "Severity of anxiety",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                    'Very severe',
                  ],
                  value: q71Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q71Severity = val),
                ),

                _buildYesNoQuestion(
                  "7.2",
                  "Did it begin after therapy?",
                  q72AfterTherapy,
                  (v) =>
                      setState(() => q72AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "7.3",
                  "Did you have this before treatment?",
                  q73BeforeTherapy,
                  (v) =>
                      setState(() => q73BeforeTherapy = v),
                ),

                _buildYesNoQuestion(
                  "7.4",
                  "Did symptoms improve after stopping drug?",
                  q74Improved,
                  (v) =>
                      setState(() => q74Improved = v),
                ),

                _buildYesNoQuestion(
                  "7.5",
                  "Did symptoms return after restart?",
                  q75Restarted,
                  (v) =>
                      setState(() => q75Restarted = v),
                ),
              ],

              /// ===================== Q8 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "8",
                question:
                    "Have you been feeling low, depressed, or down?",
                options: ['Yes', 'No'],
                value: q8Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q8Answer = val),
              ),

              if (q8Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "8.1",
                  question: "Frequency of low mood",
                  options: [
                    'Rarely',
                    'Occasionally',
                    'Frequently',
                    'Almost constantly',
                  ],
                  value: q81Frequency,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q81Frequency = val),
                ),

                _buildRadioQuestion(
                  number: "8.2",
                  question: "Severity of depression",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                    'Very severe',
                  ],
                  value: q82Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q82Severity = val),
                ),

                _buildRadioQuestion(
                  number: "8.3",
                  question:
                      "Interference with daily activities",
                  options: [
                    'Not at all',
                    'A little bit',
                    'Somewhat',
                    'Quite a bit',
                    'Very much',
                  ],
                  value: q83Interference,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q83Interference = val),
                ),

                _buildRadioQuestion(
                  number: "8.4",
                  question: "Did it begin after therapy?",
                  options: [
                    'Yes',
                    'No',
                    'Not sure',
                  ],
                  value: q84AfterTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q84AfterTherapy = val),
                ),

                _buildYesNoQuestion(
                  "8.5",
                  "Did you have low mood before treatment?",
                  q85BeforeTherapy,
                  (v) =>
                      setState(() => q85BeforeTherapy = v),
                ),

                _buildRadioQuestion(
                  number: "8.6",
                  question:
                      "Did mood improve after stopping medication?",
                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],
                  value: q86Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q86Improved = val),
                ),

                _buildRadioQuestion(
                  number: "8.7",
                  question:
                      "Did low mood return after restart?",
                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],
                  value: q87Restarted,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q87Restarted = val),
                ),
              ],

              /// ===================== Q9 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "9",
                question:
                    "Have you had thoughts about harming yourself or ending your life?",
                options: ['Yes', 'No'],
                value: q9Answer,
                isRequired: true,
                showError: showErrors,

                onChanged: (val) {
                  setState(() => q9Answer = val);
                },
              ),

              if (q9Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "9.1",
                  question:
                      "Which statement best describes your thoughts?",
                  options: [
                    'Passive thoughts',
                    'Active thoughts',
                    'Active plan / emergency',
                  ],
                  value: q91Severity,
                  isRequired: true,
                  showError: showErrors,

                  onChanged: (val) async {

                    setState(() => q91Severity = val);

                    if (val ==
                            'Active plan / emergency' &&
                        !emergencyShown) {

                      emergencyShown = true;

                      await showDialog(
                        context: context,
                        builder: (context) {

                          return AlertDialog(

                            title: const Text(
                              "Emergency Alert",
                            ),

                            content: const Text(
                              "Immediate psychiatric evaluation is recommended.\n\nPlease contact clinician or emergency services immediately.",
                            ),

                            actions: [

                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),

                _buildYesNoQuestion(
                  "9.2",
                  "Did thoughts begin after therapy?",
                  q92AfterTherapy,
                  (v) =>
                      setState(() => q92AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "9.3",
                  "Did you have similar thoughts before treatment?",
                  q93BeforeTherapy,
                  (v) =>
                      setState(() => q93BeforeTherapy = v),
                ),

                _buildYesNoQuestion(
                  "9.4",
                  "Did thoughts improve after stopping medication?",
                  q94Improved,
                  (v) =>
                      setState(() => q94Improved = v),
                ),

                _buildYesNoQuestion(
                  "9.5",
                  "Did thoughts return after restart?",
                  q95Restarted,
                  (v) =>
                      setState(() => q95Restarted = v),
                ),
              ],

              /// ===================== Q10 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "10",
                question:
                    "Have you experienced hallucinations, psychosis, or severe confusion?",
                options: ['Yes', 'No'],
                value: q10Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q10Answer = val),
              ),

              if (q10Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "10.1",
                  question: "Severity of psychosis",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                    'Life-threatening',
                  ],
                  value: q101Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q101Severity = val),
                ),

                _buildRadioQuestion(
                  number: "10.2",
                  question: "Did it begin after therapy?",
                  options: [
                    'Yes',
                    'No',
                    'Not sure',
                  ],
                  value: q102AfterTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q102AfterTherapy = val),
                ),

                _buildYesNoQuestion(
                  "10.3",
                  "Did you have psychosis before treatment?",
                  q103BeforeTherapy,
                  (v) =>
                      setState(() => q103BeforeTherapy = v),
                ),

                _buildRadioQuestion(
                  number: "10.4",
                  question:
                      "Did symptoms improve after stopping medication?",
                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],
                  value: q104Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q104Improved = val),
                ),

                _buildRadioQuestion(
                  number: "10.5",
                  question:
                      "Did symptoms return after restart?",
                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],
                  value: q105Restarted,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q105Restarted = val),
                ),
              ],

              /// ===================== Q11 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "11",
                question:
                    "Have you had difficulty sleeping during treatment?",
                options: ['Yes', 'No'],
                value: q11Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q11Answer = val),
              ),

              if (q11Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "11.1",
                  question:
                      "Severity of sleep difficulty",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                  ],
                  value: q111Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q111Severity = val),
                ),

                _buildYesNoQuestion(
                  "11.2",
                  "Did it begin after therapy?",
                  q112AfterTherapy,
                  (v) =>
                      setState(() => q112AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "11.3",
                  "Did you have sleep problems before therapy?",
                  q113BeforeTherapy,
                  (v) =>
                      setState(() => q113BeforeTherapy = v),
                ),

                _buildYesNoQuestion(
                  "11.4",
                  "Did symptoms improve after stopping medication?",
                  q114Improved,
                  (v) =>
                      setState(() => q114Improved = v),
                ),

                _buildYesNoQuestion(
                  "11.5",
                  "Did symptoms return after restart?",
                  q115Restarted,
                  (v) =>
                      setState(() => q115Restarted = v),
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

        label: const Text("Save & Next System"),

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

          await _savePsychiatric();

          if (!mounted) return;

          widget.onSaveAndComplete();
        },
      ),
    );
  }

  /// ================= VALIDATION =================

  bool _validateForm() {

    if (q7Answer == null) return false;
    if (q8Answer == null) return false;
    if (q9Answer == null) return false;
    if (q10Answer == null) return false;
    if (q11Answer == null) return false;

    return true;
  }

  /// ================= SAVE =================

  Future<void> _savePsychiatric() async {

    List<Map<String, String>> symptoms = [];

    if (q7Answer == 'Yes') {

      symptoms.add({
        'name': 'Anxiety',
        'severity': _mapSeverity(q71Severity),
      });
    }

    if (q8Answer == 'Yes') {

      symptoms.add({
        'name': 'Depression',
        'severity': _mapSeverity(q82Severity),
      });
    }

    if (q9Answer == 'Yes') {

      symptoms.add({
        'name': 'Suicidal ideation',
        'severity': _mapSuicideSeverity(q91Severity),
      });
    }

    if (q10Answer == 'Yes') {

      symptoms.add({
        'name': 'Psychosis',
        'severity': _mapSeverity(q101Severity),
      });
    }

    if (q11Answer == 'Yes') {

      symptoms.add({
        'name': 'Insomnia',
        'severity': _mapSeverity(q111Severity),
      });
    }

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId: widget.reportId,

        questionnaireSystem: "PSYCHIATRIC",

        symptomName: s['name']!,

        symptomPresent: "Yes",

        severity: s['severity']!,

        regimenType: "SLD",
      );
    }
  }

  /// ================= SEVERITY =================

  String _mapSeverity(String? value) {

    switch (value) {

      case 'Mild':
        return 'mild';

      case 'Moderate':
        return 'moderate';

      case 'Severe':
        return 'severe';

      case 'Very severe':
        return 'life threatening';

      case 'Life-threatening':
        return 'life threatening';

      default:
        return 'moderate';
    }
  }

  String _mapSuicideSeverity(String? value) {

    switch (value) {

      case 'Passive thoughts':
        return 'moderate';

      case 'Active thoughts':
        return 'severe';

      case 'Active plan / emergency':
        return 'life threatening';

      default:
        return 'severe';
    }
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
      options: ['Yes', 'No'],
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
}