import 'package:flutter/material.dart';
import 'systems_api.dart';

class CentralNervousSLDScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;

  const CentralNervousSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<CentralNervousSLDScreen> createState() =>
      _CentralNervousSLDScreenState();
}

class _CentralNervousSLDScreenState
    extends State<CentralNervousSLDScreen> {

  /// ===================== Q4 =====================

  String? q4Answer;
  String? q41Severity;

  final TextEditingController q42DurationController =
      TextEditingController();

  String? q43AfterTherapy;
  String? q44BeforeTreatment;
  String? q45Improved;
  String? q46Restart;
  String? q47Conditions;
  String? q48Injury;

  /// ===================== Q5 =====================

  String? q5Answer;
  String? q51Severity;

  List<String> q52Symptoms = [];

  String? q53AfterTherapy;
  String? q54BeforeTherapy;
  String? q55Improved;
  String? q56Restarted;

  /// ===================== Q6 =====================

  String? q6Answer;
  String? q61Severity;
  String? q62AfterTherapy;
  String? q63BeforeTherapy;
  String? q64Improved;
  String? q65Restarted;

  bool showErrors = false;

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

              /// ===================== Q4 =====================

              _buildRadioQuestion(
                number: "4",
                question:
                    "Have you experienced numbness, tingling, or burning sensation in hands or feet?",
                options: ['Yes', 'No'],
                value: q4Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q4Answer = val),
              ),

              if (q4Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "4.1",
                  question: "Severity",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                    'Life-threatening',
                  ],
                  value: q41Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q41Severity = val),
                ),

                /// Duration
                Card(
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
                          text: const TextSpan(
                            text:
                                "4.2 Duration of symptoms (weeks)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: " *",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller:
                              q42DurationController,

                          keyboardType:
                              TextInputType.number,

                          decoration:
                              const InputDecoration(
                            border:
                                OutlineInputBorder(),
                            hintText:
                                "Enter duration in weeks",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _buildRadioQuestion(
                  number: "4.3",
                  question:
                      "Did symptoms begin after medication?",
                  options: [
                    'Yes',
                    'No',
                    'Not sure',
                  ],
                  value: q43AfterTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q43AfterTherapy = val),
                ),

                _buildRadioQuestion(
                  number: "4.4",
                  question:
                      "Did you have similar symptoms before treatment?",
                  options: ['Yes', 'No'],
                  value: q44BeforeTreatment,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q44BeforeTreatment = val),
                ),

                _buildRadioQuestion(
                  number: "4.5",
                  question:
                      "Did symptoms improve after stopping/reducing medication?",
                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],
                  value: q45Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q45Improved = val),
                ),

                _buildRadioQuestion(
                  number: "4.6",
                  question:
                      "Did symptoms return after restarting medication?",
                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],
                  value: q46Restart,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q46Restart = val),
                ),

                _buildRadioQuestion(
                  number: "4.7",
                  question:
                      "Pre-existing diabetes or neuropathy?",
                  options: ['Yes', 'No'],
                  value: q47Conditions,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q47Conditions = val),
                ),

                _buildRadioQuestion(
                  number: "4.8",
                  question:
                      "Recent physical activity/injury?",
                  options: ['Yes', 'No'],
                  value: q48Injury,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q48Injury = val),
                ),
              ],

              /// ===================== Q5 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "5",
                question:
                    "Are you experiencing vertigo or dizziness?",
                options: ['Yes', 'No'],
                value: q5Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q5Answer = val),
              ),

              if (q5Answer == 'Yes') ...[

                _buildRadioQuestion(
                  number: "5.1",
                  question:
                      "Severity of vertigo/dizziness",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                    'Disabling',
                  ],
                  value: q51Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q51Severity = val),
                ),

                _buildCheckboxQuestion(
                  number: "5.2",
                  question:
                      "Associated symptoms",
                  options: [
                    'Nausea/vomiting',
                    'Hearing loss',
                    'Tinnitus',
                    'Unsteady gait/falls',
                  ],
                  selected: q52Symptoms,
                  onChanged: (val, checked) {

                    setState(() {

                      if (checked) {
                        q52Symptoms.add(val);
                      } else {
                        q52Symptoms.remove(val);
                      }
                    });
                  },
                ),

                _buildRadioQuestion(
                  number: "5.3",
                  question:
                      "Did it begin after therapy?",
                  options: [
                    'Yes',
                    'No',
                    'Unsure',
                  ],
                  value: q53AfterTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q53AfterTherapy = val),
                ),

                _buildRadioQuestion(
                  number: "5.4",
                  question:
                      "Did you have vertigo before therapy?",
                  options: ['Yes', 'No'],
                  value: q54BeforeTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q54BeforeTherapy = val),
                ),

                _buildRadioQuestion(
                  number: "5.5",
                  question:
                      "Did symptoms improve after stopping drug?",
                  options: [
                    'Yes',
                    'No',
                    'Drug not discontinued',
                  ],
                  value: q55Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q55Improved = val),
                ),

                _buildRadioQuestion(
                  number: "5.6",
                  question:
                      "Did symptoms return after restart?",
                  options: [
                    'Yes',
                    'No',
                    'Drug not re-administered',
                  ],
                  value: q56Restarted,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q56Restarted = val),
                ),
              ],

              /// ===================== Q6 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(
                number: "6",
                question:
                    "Have you experienced seizures?",
                options: ['Yes', 'No'],
                value: q6Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) =>
                    setState(() => q6Answer = val),
              ),

              if (q6Answer == 'Present') ...[

                _buildRadioQuestion(
                  number: "6.1",
                  question:
                      "Type/severity of seizure",
                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                    'Life-threatening',
                    'Grade 5',
                  ],
                  value: q61Severity,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() => q61Severity = val),
                ),

                _buildRadioQuestion(
                  number: "6.2",
                  question:
                      "Did it begin after therapy?",
                  options: [
                    'Yes',
                    'No',
                    'Unsure',
                  ],
                  value: q62AfterTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q62AfterTherapy = val),
                ),

                _buildRadioQuestion(
                  number: "6.3",
                  question:
                      "Did you have seizures before therapy?",
                  options: ['Yes', 'No'],
                  value: q63BeforeTherapy,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q63BeforeTherapy = val),
                ),

                _buildRadioQuestion(
                  number: "6.4",
                  question:
                      "Did symptoms improve after discontinuation?",
                  options: ['Yes', 'No'],
                  value: q64Improved,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q64Improved = val),
                ),

                _buildRadioQuestion(
                  number: "6.5",
                  question:
                      "Did symptoms reappear after restart?",
                  options: ['Yes', 'No'],
                  value: q65Restarted,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) =>
                      setState(() =>
                          q65Restarted = val),
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

          await _saveCNS();

          if (!mounted) return;

          widget.onSaveAndComplete();
        },
      ),
    );
  }

  /// ===================== VALIDATION =====================

  bool _validateForm() {

    if (q4Answer == null) return false;
    if (q5Answer == null) return false;
    if (q6Answer == null) return false;

    if (q4Answer == 'Yes') {

      if (q41Severity == null) return false;
      if (q42DurationController.text.isEmpty) {
        return false;
      }
      if (q43AfterTherapy == null) return false;
      if (q44BeforeTreatment == null) return false;
      if (q45Improved == null) return false;
      if (q46Restart == null) return false;
      if (q47Conditions == null) return false;
      if (q48Injury == null) return false;
    }

    if (q5Answer == 'Yes') {

      if (q51Severity == null) return false;
      if (q53AfterTherapy == null) return false;
      if (q54BeforeTherapy == null) return false;
      if (q55Improved == null) return false;
      if (q56Restarted == null) return false;
    }

    if (q6Answer == 'Present') {

      if (q61Severity == null) return false;
      if (q62AfterTherapy == null) return false;
      if (q63BeforeTherapy == null) return false;
      if (q64Improved == null) return false;
      if (q65Restarted == null) return false;
    }

    return true;
  }

  /// ===================== SAVE =====================

  Future<void> _saveCNS() async {

    List<Map<String, dynamic>> symptoms = [];

    /// ---------- Q4 ----------

    if (q4Answer == 'Yes') {

      int duration =
          int.tryParse(
            q42DurationController.text,
          ) ??
          0;

      symptoms.add({
        'name': 'Peripheral neuropathy',
        'severity':
            _mapSeverity(q41Severity),
        'duration': duration,
      });

      if (q43AfterTherapy == 'Yes') {

        symptoms.add({
          'name':
              'Peripheral neuropathy after medication',
          'severity': 'mild',
          'duration': duration,
        });
      }

      if (q45Improved == 'Yes') {

        symptoms.add({
          'name':
              'Peripheral neuropathy improved after stopping',
          'severity': 'mild',
          'duration': duration,
        });
      }

      if (q46Restart == 'Yes') {

        symptoms.add({
          'name':
              'Peripheral neuropathy returned after restart',
          'severity': 'moderate',
          'duration': duration,
        });
      }
    }

    /// ---------- Q5 ----------

    if (q5Answer == 'Yes') {

      symptoms.add({
        'name': 'Vertigo',
        'severity':
            _mapVertigoSeverity(q51Severity),
        'duration': null,
      });

      if (q53AfterTherapy == 'Yes') {

        symptoms.add({
          'name':
              'Vertigo after medication',
          'severity': 'mild',
          'duration': null,
        });
      }

      if (q55Improved == 'Yes') {

        symptoms.add({
          'name':
              'Vertigo improved after stopping',
          'severity': 'mild',
          'duration': null,
        });
      }

      if (q56Restarted == 'Yes') {

        symptoms.add({
          'name':
              'Vertigo returned after restart',
          'severity': 'moderate',
          'duration': null,
        });
      }

      if (q52Symptoms.contains(
          'Nausea/vomiting')) {

        symptoms.add({
          'name':
              'Nausea with vertigo',
          'severity': 'moderate',
          'duration': null,
        });
      }

      if (q52Symptoms.contains(
          'Hearing loss')) {

        symptoms.add({
          'name':
              'Hearing loss with vertigo',
          'severity': 'moderate',
          'duration': null,
        });
      }

      if (q52Symptoms.contains(
          'Tinnitus')) {

        symptoms.add({
          'name':
              'Tinnitus with vertigo',
          'severity': 'moderate',
          'duration': null,
        });
      }

      if (q52Symptoms.contains(
          'Unsteady gait/falls')) {

        symptoms.add({
          'name':
              'Unsteady gait with vertigo',
          'severity': 'severe',
          'duration': null,
        });
      }
    }

    /// ---------- Q6 ----------

    if (q6Answer == 'Present') {

      symptoms.add({
        'name': 'Seizures',
        'severity':
            _mapSeverity(q61Severity),
        'duration': null,
      });

      if (q62AfterTherapy == 'Yes') {

        symptoms.add({
          'name':
              'Seizures after medication',
          'severity': 'moderate',
          'duration': null,
        });
      }

      if (q64Improved == 'Yes') {

        symptoms.add({
          'name':
              'Seizures improved after stopping',
          'severity': 'moderate',
          'duration': null,
        });
      }

      if (q65Restarted == 'Yes') {

        symptoms.add({
          'name':
              'Seizures returned after restart',
          'severity': 'severe',
          'duration': null,
        });
      }
    }

    /// ---------- SAVE ----------

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId: widget.reportId,

        questionnaireSystem:
            "CENTRAL NERVOUS SYSTEM",

        symptomName: s['name'],

        symptomPresent: "Yes",

        severity: s['severity'],

        durationWeeks: s['duration'],

        regimenType: "SLD",
      );
    }
  }

  /// ===================== HELPERS =====================

  String _mapSeverity(String? value) {

    switch (value) {

      case 'Mild':
        return 'mild';

      case 'Moderate':
        return 'moderate';

      case 'Severe':
        return 'severe';

      case 'Life-threatening':
        return 'life threatening';

      case 'Death':
        return 'life threatening';

      default:
        return 'moderate';
    }
  }

  String _mapVertigoSeverity(
      String? value) {

    switch (value) {

      case 'Mild':
        return 'mild';

      case 'Moderate':
        return 'moderate';

      case 'Severe':
        return 'severe';

      case 'Disabling':
        return 'life threatening';

      default:
        return 'moderate';
    }
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

  @override
  void dispose() {

    q42DurationController.dispose();

    super.dispose();
  }
}