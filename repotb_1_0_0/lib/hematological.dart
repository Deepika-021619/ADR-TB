import 'package:flutter/material.dart';
import 'systems_api.dart';

class HematologicalSLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const HematologicalSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<HematologicalSLDScreen> createState() =>
      _HematologicalSLDScreenState();
}

class _HematologicalSLDScreenState
    extends State<HematologicalSLDScreen> {

  /// ===================== Q28 =====================

  String? q28Answer;

  final TextEditingController
      q281HgbController =
          TextEditingController();

  final TextEditingController
      q281LLNController =
          TextEditingController();

  final TextEditingController
      q281BaselineController =
          TextEditingController();

  /// ===================== Q29 =====================

  String? q29Answer;

  final TextEditingController
      q291PlateletController =
          TextEditingController();

  final TextEditingController
      q291LLNController =
          TextEditingController();

  final TextEditingController
      q291BaselineController =
          TextEditingController();

  /// ===================== Q30 =====================

  String? q30Answer;

  final TextEditingController
      q301ANCController =
          TextEditingController();

  final TextEditingController
      q301LLNController =
          TextEditingController();

  final TextEditingController
      q301BaselineController =
          TextEditingController();

  String? q302Fever;

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

              /// ===================== Q28 =====================

              _buildRadioQuestion(

                number: "28",

                question:
                    "Did you get your hemoglobin (Hgb) tested recently?",

                options: ['Yes', 'No'],

                value: q28Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q28Answer = val),
              ),

              if (q28Answer == 'Yes') ...[

                _buildTextField(

                  number: "28.1",

                  label:
                      "Hemoglobin (Hgb)",

                  controller:
                      q281HgbController,

                  hint:
                      "Enter Hgb value",

                  required: true,
                ),

                _buildTextField(

                  number: "",

                  label:
                      "Lower limit of normal (LLN)",

                  controller:
                      q281LLNController,

                  hint:
                      "Enter LLN",

                  required: true,
                ),

                _buildTextField(

                  number: "",

                  label:
                      "Baseline Hgb (optional)",

                  controller:
                      q281BaselineController,

                  hint:
                      "Enter baseline Hgb",

                  required: false,
                ),
              ],

              /// ===================== Q29 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "29",

                question:
                    "Have you had platelet count checked recently or experienced unusual bleeding/bruising?",

                options: ['Yes', 'No'],

                value: q29Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q29Answer = val),
              ),

              if (q29Answer == 'Yes') ...[

                _buildTextField(

                  number: "29.1",

                  label:
                      "Platelet count (/µL)",

                  controller:
                      q291PlateletController,

                  hint:
                      "Enter platelet count",

                  required: true,
                ),

                _buildTextField(

                  number: "",

                  label:
                      "Lower limit of normal (LLN)",

                  controller:
                      q291LLNController,

                  hint:
                      "Enter LLN",

                  required: true,
                ),

                _buildTextField(

                  number: "",

                  label:
                      "Baseline platelet count (optional)",

                  controller:
                      q291BaselineController,

                  hint:
                      "Enter baseline platelet count",

                  required: false,
                ),
              ],

              /// ===================== Q30 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "30",

                question:
                    "Did you get your Absolute Neutrophil Count (ANC) tested recently?",

                options: ['Yes', 'No'],

                value: q30Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q30Answer = val),
              ),

              if (q30Answer == 'Yes') ...[

                _buildTextField(

                  number: "30.1",

                  label:
                      "Absolute Neutrophil Count (ANC)",

                  controller:
                      q301ANCController,

                  hint:
                      "Enter ANC",

                  required: true,
                ),

                _buildTextField(

                  number: "",

                  label:
                      "Lower limit of normal (LLN)",

                  controller:
                      q301LLNController,

                  hint:
                      "Enter LLN",

                  required: true,
                ),

                _buildTextField(

                  number: "",

                  label:
                      "Baseline ANC (optional)",

                  controller:
                      q301BaselineController,

                  hint:
                      "Enter baseline ANC",

                  required: false,
                ),

                _buildRadioQuestion(

                  number: "30.2",

                  question:
                      "Did you have fever (≥38°C) along with low neutrophil count?",

                  options: ['Yes', 'No'],

                  value: q302Fever,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q302Fever = val),
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

          await _saveHematological();

          if (!mounted) return;

          widget.onSaveAndComplete();
        },
      ),
    );
  }

  /// ===================== VALIDATION =====================

  bool _validateForm() {

    if (q28Answer == null) return false;

    if (q29Answer == null) return false;

    if (q30Answer == null) return false;

    if (q28Answer == 'Yes') {

      if (q281HgbController
          .text.isEmpty) {
        return false;
      }

      if (q281LLNController
          .text.isEmpty) {
        return false;
      }
    }

    if (q29Answer == 'Yes') {

      if (q291PlateletController
          .text.isEmpty) {
        return false;
      }

      if (q291LLNController
          .text.isEmpty) {
        return false;
      }
    }

    if (q30Answer == 'Yes') {

      if (q301ANCController
          .text.isEmpty) {
        return false;
      }

      if (q301LLNController
          .text.isEmpty) {
        return false;
      }

      if (q302Fever == null) {
        return false;
      }
    }

    return true;
  }

  /// ===================== SAVE =====================

  Future<void> _saveHematological() async {

    List<Map<String, dynamic>> symptoms = [];

    /// ---------- Q28 ----------

    if (q28Answer == 'Yes') {

      final hgb =
          double.tryParse(
              q281HgbController.text);

      final lln =
          double.tryParse(
              q281LLNController.text);

      String severity =
          _calculateHgbSeverity(
              hgb, lln);

      symptoms.add({

        'name': 'Low hemoglobin',

        'severity': severity,
      });

      if (q281BaselineController
          .text.isNotEmpty) {

        symptoms.add({

          'name':
              'Baseline hemoglobin available',

          'severity': 'N/A',
        });
      }
    }

    /// ---------- Q29 ----------

    if (q29Answer == 'Yes') {

      final platelets =
          double.tryParse(
              q291PlateletController
                  .text);

      String severity =
          _calculatePlateletSeverity(
              platelets);

      symptoms.add({

        'name':
            'Thrombocytopenia',

        'severity': severity,
      });

      if (q291BaselineController
          .text.isNotEmpty) {

        symptoms.add({

          'name':
              'Baseline platelet count available',

          'severity': 'N/A',
        });
      }
    }

    /// ---------- Q30 ----------

    if (q30Answer == 'Yes') {

      final anc =
          double.tryParse(
              q301ANCController.text);

      String severity =
          _calculateANCSeverity(
              anc);

      symptoms.add({

        'name':
            'Neutropenia',

        'severity': severity,
      });

      if (q302Fever != null) {

        symptoms.add({

          'name':
              'Fever with neutropenia',

          'severity': 'N/A',
        });
      }

      if (q301BaselineController
          .text.isNotEmpty) {

        symptoms.add({

          'name':
              'Baseline ANC available',

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
            "HEMATOLOGICAL",

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

  /// ===================== SEVERITY HELPERS =====================

  String _calculateHgbSeverity(
      double? hgb,
      double? lln) {

    if (hgb == null ||
        lln == null) {
      return 'moderate';
    }

    if (hgb >= lln) {
      return 'mild';
    }

    double ratio =
        hgb / lln;

    if (ratio >= 0.8) {
      return 'mild';
    }

    if (ratio >= 0.65) {
      return 'moderate';
    }

    if (ratio >= 0.5) {
      return 'severe';
    }

    return 'life threatening';
  }

  String _calculatePlateletSeverity(
      double? platelets) {

    if (platelets == null) {
      return 'moderate';
    }

    if (platelets >= 75000) {
      return 'mild';
    }

    if (platelets >= 50000) {
      return 'moderate';
    }

    if (platelets >= 25000) {
      return 'severe';
    }

    return 'life threatening';
  }

  String _calculateANCSeverity(
      double? anc) {

    if (anc == null) {
      return 'moderate';
    }

    if (anc >= 1500) {
      return 'mild';
    }

    if (anc >= 1000) {
      return 'moderate';
    }

    if (anc >= 500) {
      return 'severe';
    }

    return 'life threatening';
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

  Widget _buildTextField({

    required String number,

    required String label,

    required TextEditingController
        controller,

    required String hint,

    required bool required,
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
                    number.isNotEmpty
                        ? "$number. $label"
                        : label,

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.black,

                  fontSize: 16,
                ),

                children: [

                  if (required)

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

            TextField(

              controller:
                  controller,

              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),

              decoration:
                  InputDecoration(

                border:
                    const OutlineInputBorder(),

                hintText:
                    hint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {

    q281HgbController.dispose();

    q281LLNController.dispose();

    q281BaselineController.dispose();

    q291PlateletController.dispose();

    q291LLNController.dispose();

    q291BaselineController.dispose();

    q301ANCController.dispose();

    q301LLNController.dispose();

    q301BaselineController.dispose();

    super.dispose();
  }
}