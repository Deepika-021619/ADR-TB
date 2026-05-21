import 'package:flutter/material.dart';
import 'systems_api.dart';

class SkinSubcutaneousSLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const SkinSubcutaneousSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<SkinSubcutaneousSLDScreen> createState() =>
      _SkinSubcutaneousSLDScreenState();
}

class _SkinSubcutaneousSLDScreenState
    extends State<SkinSubcutaneousSLDScreen> {

  /// ===================== Q26 =====================

  String? q26Answer;

  String? q261Severity;

  String? q262AfterTherapy;

  String? q263BeforeTherapy;

  String? q264Improved;

  String? q265Restarted;

  /// ===================== Q27 =====================

  String? q27Answer;

  String? q271Extent;

  String? q272Diagnosis;

  String? q273AfterTherapy;

  String? q274BeforeTherapy;

  String? q275Improved;

  String? q276Restarted;

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

              /// ===================== Q26 =====================

              _buildRadioQuestion(

                number: "26",

                question:
                    "Have you noticed darkening or discoloration of your skin during TB treatment?",

                options: ['Yes', 'No'],

                value: q26Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q26Answer = val),
              ),

              if (q26Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "26.1",

                  question:
                      "How severe was the skin discoloration?",

                  options: [

                    'Mild cosmetic discoloration – Visible darkening without emotional distress',

                    'Marked discoloration – Noticeable change causing psychological distress or reduced confidence',

                    'Severe – Significant discoloration leading to social withdrawal',

                    'Very severe – Disabling psychological impact affecting daily functioning',
                  ],

                  value: q261Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q261Severity = val),
                ),

                _buildRadioQuestion(

                  number: "26.2",

                  question:
                      "Did this discoloration start after beginning TB treatment?",

                  options: ['Yes', 'No'],

                  value: q262AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q262AfterTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "26.3",

                  question:
                      "Did you have similar skin pigmentation before therapy?",

                  options: ['Yes', 'No'],

                  value: q263BeforeTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q263BeforeTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "26.4",

                  question:
                      "Did the discoloration improve after stopping or adjusting the drug?",

                  options: ['Yes', 'No'],

                  value: q264Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q264Improved = val),
                ),

                _buildRadioQuestion(

                  number: "26.5",

                  question:
                      "Did the discoloration return after restarting the drug?",

                  options: ['Yes', 'No'],

                  value: q265Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q265Restarted = val),
                ),
              ],

              /// ===================== Q27 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "27",

                question:
                    "Have you developed a severe skin rash during TB treatment?",

                options: ['Yes', 'No'],

                value: q27Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q27Answer = val),
              ),

              if (q27Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "27.1",

                  question:
                      "What was the extent of the skin rash?",

                  options: [

                    'Rash involving <10% of body surface area (BSA)',

                    'Rash involving 10–30% of body surface area (BSA)',

                    'Rash involving >30% of body surface area (BSA)',

                    'Stevens-Johnson Syndrome (SJS) / Toxic Epidermal Necrolysis (TEN) confirmed by doctor',
                  ],

                  value: q271Extent,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q271Extent = val),
                ),

                _buildRadioQuestion(

                  number: "27.2",

                  question:
                      "Did a doctor confirm the diagnosis?",

                  options: [

                    'Yes – SJS',

                    'Yes – TEN',

                    'Severe drug rash (not SJS/TEN)',

                    'Not confirmed',
                  ],

                  value: q272Diagnosis,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q272Diagnosis = val),
                ),

                _buildRadioQuestion(

                  number: "27.3",

                  question:
                      "Did this skin rash start after beginning TB treatment?",

                  options: ['Yes', 'No'],

                  value: q273AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q273AfterTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "27.4",

                  question:
                      "Did you have similar skin rash before therapy?",

                  options: ['Yes', 'No'],

                  value: q274BeforeTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q274BeforeTherapy = val),
                ),

                _buildRadioQuestion(

                  number: "27.5",

                  question:
                      "Did the rash improve after stopping or adjusting the drug?",

                  options: ['Yes', 'No'],

                  value: q275Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q275Improved = val),
                ),

                _buildRadioQuestion(

                  number: "27.6",

                  question:
                      "Did the rash return after restarting the drug?",

                  options: ['Yes', 'No'],

                  value: q276Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q276Restarted = val),
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

          await _saveSkinSubcutaneous();

          if (!mounted) return;

          widget.onSaveAndComplete();
        },
      ),
    );
  }

  /// ===================== VALIDATION =====================

  bool _validateForm() {

    if (q26Answer == null) {
      return false;
    }

    if (q27Answer == null) {
      return false;
    }

    if (q26Answer == 'Yes') {

      if (q261Severity == null) return false;

      if (q262AfterTherapy == null) return false;

      if (q263BeforeTherapy == null) return false;

      if (q264Improved == null) return false;

      if (q265Restarted == null) return false;
    }

    if (q27Answer == 'Yes') {

      if (q271Extent == null) return false;

      if (q272Diagnosis == null) return false;

      if (q273AfterTherapy == null) return false;

      if (q274BeforeTherapy == null) return false;

      if (q275Improved == null) return false;

      if (q276Restarted == null) return false;
    }

    return true;
  }

  /// ===================== SAVE =====================

  Future<void> _saveSkinSubcutaneous() async {

    List<Map<String, dynamic>> symptoms = [];

    /// ---------- Q26 ----------

    if (q26Answer == 'Yes') {

      symptoms.add({

        'name':
            'Skin discoloration',

        'severity':
            _mapDiscolorationSeverity(
                q261Severity),
      });

      if (q262AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Skin discoloration after TB therapy',

          'severity': 'N/A',
        });
      }

      if (q263BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Skin discoloration before therapy',

          'severity': 'N/A',
        });
      }

      if (q264Improved == 'Yes') {

        symptoms.add({

          'name':
              'Skin discoloration improved after stopping drug',

          'severity': 'N/A',
        });
      }

      if (q265Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Skin discoloration restarted after rechallenge',

          'severity': 'N/A',
        });
      }
    }

    /// ---------- Q27 ----------

    if (q27Answer == 'Yes') {

      symptoms.add({

        'name':
            'Severe skin rash',

        'severity':
            _mapRashSeverity(
                q271Extent),
      });

      if (q272Diagnosis !=null) {

        symptoms.add({

          'name':
              'Skin rash diagnosis - $q272Diagnosis',

          'severity': 'N/A',
        });
      }

      if (q273AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Skin rash after TB therapy',

          'severity': 'N/A',
        });
      }

      if (q274BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Skin rash before therapy',

          'severity': 'N/A',
        });
      }

      if (q275Improved == 'Yes') {

        symptoms.add({

          'name':
              'Skin rash improved after stopping drug',

          'severity': 'N/A',
        });
      }

      if (q276Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Skin rash restarted after rechallenge',

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
            "SKIN AND SUBCUTANEOUS TISSUE RELATED SYMPTOMS",

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

  String _mapDiscolorationSeverity(
      String? value) {

    if (value == null) {
      return 'moderate';
    }

    final lower =
        value.toLowerCase();

    if (lower.contains('mild')) {
      return 'mild';
    }

    if (lower.contains('marked')) {
      return 'moderate';
    }

    if (lower.contains('severe') &&
        !lower.contains('very')) {
      return 'severe';
    }

    if (lower.contains('very severe')) {
      return 'life threatening';
    }

    return 'moderate';
  }

  String _mapRashSeverity(
      String? value) {

    if (value == null) {
      return 'moderate';
    }

    final lower =
        value.toLowerCase();

    if (lower.contains('<10')) {
      return 'mild';
    }

    if (lower.contains('10–30')) {
      return 'moderate';
    }

    if (lower.contains('>30')) {
      return 'severe';
    }

    if (lower.contains('sjs') ||
        lower.contains('ten')) {
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