import 'package:flutter/material.dart';
import 'systems_api.dart';

class OcularSLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const OcularSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<OcularSLDScreen> createState() =>
      _OcularSLDScreenState();
}

class _OcularSLDScreenState
    extends State<OcularSLDScreen> {

  /// ===================== Q14 Vision loss =====================

  String? q14Answer;

  final TextEditingController q141RightTop =
      TextEditingController();

  final TextEditingController q141RightBottom =
      TextEditingController();

  final TextEditingController q141LeftTop =
      TextEditingController();

  final TextEditingController q141LeftBottom =
      TextEditingController();

  String? q142Baseline;
  String? q143Severity;
  String? q144AfterTherapy;
  String? q145BeforeTherapy;
  String? q146Improved;
  String? q147Restarted;
  String? q148EyeDisease;
  String? q149LightExposure;

  /// ===================== Q15 Color vision =====================

  String? q15Answer;
  String? q151ColorTest;

  

  String? q152Severity;
  String? q153AfterTherapy;
  String? q154BeforeTherapy;
  String? q155Improved;
  String? q156Restarted;

  /// ===================== Q16 Visual field =====================

  String? q16Answer;
  String? q161Area;
  String? q162Severity;
  String? q163AfterTherapy;
  String? q164BeforeTherapy;
  String? q165Improved;
  String? q166Restarted;

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

              /// ===================== Q14 =====================

              _buildRadioQuestion(

                number: "14",

                question:
                    "Have you experienced any blurring or decrease in vision since starting the treatment?",

                options: ['Yes', 'No'],

                value: q14Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q14Answer = val),
              ),

              if (q14Answer == 'Yes') ...[

                _buildSnellenSection(),

                _buildYesNoQuestion(
                  "14.2",
                  "Baseline visual acuity available?",
                  q142Baseline,
                  (v) => setState(() =>
                      q142Baseline = v),
                ),

                _buildRadioQuestion(

                  number: "14.3",

                  question:
                      "How severe was your vision affected?",

                  options: [

                    'Mild – Symptomatic with moderate decrease in visual acuity',

                    'Moderate – Marked decrease in visual acuity',

                    'Severe – Visual acuity 20/200 or worse',
                  ],

                  value: q143Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q143Severity = val),
                ),

                _buildRadioQuestion(

                  number: "14.4",

                  question:
                      "Did the visual symptoms begin after starting the medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure',
                  ],

                  value: q144AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q144AfterTherapy = val),
                ),

                _buildYesNoQuestion(
                  "14.5",
                  "Did you have similar visual problems before treatment?",
                  q145BeforeTherapy,
                  (v) => setState(() =>
                      q145BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "14.6",

                  question:
                      "Did vision improve after stopping or adjusting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],

                  value: q146Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q146Improved = val),
                ),

                _buildRadioQuestion(

                  number: "14.7",

                  question:
                      "Did symptoms recur after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],

                  value: q147Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q147Restarted = val),
                ),

                _buildYesNoQuestion(
                  "14.8",
                  "Do you have any pre-existing eye conditions?",
                  q148EyeDisease,
                  (v) => setState(() =>
                      q148EyeDisease = v),
                ),

                _buildYesNoQuestion(
                  "14.9",
                  "Have you recently experienced visual strain or bright light exposure?",
                  q149LightExposure,
                  (v) => setState(() =>
                      q149LightExposure = v),
                ),
              ],

              /// ===================== Q15 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "15",

                question:
                    "Have you noticed any change in your color vision or difficulty distinguishing colors?",

                options: ['Yes', 'No'],

                value: q15Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q15Answer = val),
              ),

              if (q15Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "15.1",

                  question:
                      "Was color vision tested?",

                  options: [
                    'Normal',
                    'Abnormal',
                    'Not tested',
                  ],

                  value: q151ColorTest,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q151ColorTest = val),
                ),

                

                _buildRadioQuestion(

                  number: "15.2",

                  question:
                      "How serious is the event?",

                  options: [

                    'Grade 0 – Asymptomatic: No visual complaints; no functional limitation; Ishihara 35–38/38; no intervention required.',

                    'Grade 1 – Mild:: Dullness or haziness in vision; subtle difficulty distinguishing colors; no interference with daily activities; Ishihara 25–34/38.',

                    'Grade 2 – Moderate: Noticeable difficulty differentiating colors (e.g., red–green confusion); challenges in reading, driving, recognizing faces, or work-related tasks; Ishihara 15–24/38.',

                    'Grade 3 – Severe: Marked color vision loss significantly interfering with daily functioning; Ishihara 1–14/38.',

                    'Grade 4 – Profound: Near total color vision loss; Ishihara 0/38; possible optic neuropathy requiring urgent evaluation.',
                  ],

                  value: q152Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q152Severity = val),
                ),

                _buildRadioQuestion(

                  number: "15.3",

                  question:
                      "Did this symptom begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure',
                  ],

                  value: q153AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q153AfterTherapy = val),
                ),

                _buildYesNoQuestion(
                  "15.4",
                  "Did you experience similar problems before treatment?",
                  q154BeforeTherapy,
                  (v) => setState(() =>
                      q154BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "15.5",

                  question:
                      "Did symptoms improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],

                  value: q155Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q155Improved = val),
                ),

                _buildRadioQuestion(

                  number: "15.6",

                  question:
                      "Did symptoms reappear after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],

                  value: q156Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q156Restarted = val),
                ),
              ],

              /// ===================== Q16 =====================

              const SizedBox(height: 20),

              _buildRadioQuestion(

                number: "16",

                question:
                    "Have you experienced any patchy or partial loss of vision?",

                options: ['Yes', 'No'],

                value: q16Answer,

                isRequired: true,

                showError: showErrors,

                onChanged: (val) =>
                    setState(() => q16Answer = val),
              ),

              if (q16Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "16.1",

                  question:
                      "Specify affected area",

                  options: [

                    'Right Upper Quadrant',

                    'Right Lower Quadrant',

                    'Left Upper Quadrant',

                    'Left Lower Quadrant',

                    'Central vision',

                    'Peripheral vision',

                    'Not sure',
                  ],

                  value: q161Area,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q161Area = val),
                ),

                _buildRadioQuestion(

                  number: "16.2",

                  question:
                      "How severe is the vision loss?",

                  options: [

                    'Mild: Patchy visual field defect',

                    'Moderate: Marked field defect',

                    'Severe: Best corrected visual acuity 20/200 or worse',
                  ],

                  value: q162Severity,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q162Severity = val),
                ),

                _buildRadioQuestion(

                  number: "16.3",

                  question:
                      "Did this visual problem begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure',
                  ],

                  value: q163AfterTherapy,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q163AfterTherapy = val),
                ),

                _buildYesNoQuestion(
                  "16.4",
                  "Did you have similar visual problems before treatment?",
                  q164BeforeTherapy,
                  (v) => setState(() =>
                      q164BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "16.5",

                  question:
                      "Did symptoms improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],

                  value: q165Improved,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q165Improved = val),
                ),

                _buildRadioQuestion(

                  number: "16.6",

                  question:
                      "Did symptoms reappear after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable',
                  ],

                  value: q166Restarted,

                  isRequired: true,

                  showError: showErrors,

                  onChanged: (val) =>
                      setState(() =>
                          q166Restarted = val),
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
            const Text("Save & Next System"),

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
              await _saveOcular();

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

  /// ================= SAVE =================

  Future<bool> _saveOcular() async {

    List<Map<String, String>> symptoms = [];

    /// ================= Q14 =================

    if (q14Answer == 'Yes') {

      symptoms.add({

        'name': 'Vision loss',

        'severity':
            _mapVisionSeverity(q143Severity),
      });

      if (q144AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Vision loss after medication',

          'severity': 'mild',
        });
      }

      if (q145BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Vision loss before treatment',

          'severity': 'mild',
        });
      }

      if (q146Improved == 'Yes') {

        symptoms.add({

          'name':
              'Vision loss improved after stopping',

          'severity': 'mild',
        });
      }

      if (q147Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Vision loss returned after restart',

          'severity': 'moderate',
        });
      }
    }

    /// ================= Q15 =================

    if (q15Answer == 'Yes') {

      symptoms.add({

        'name': 'Color vision defect',

        'severity':
            _mapColorSeverity(q152Severity),
      });

      if (q153AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Color vision defect after medication',

          'severity': 'mild',
        });
      }

      if (q154BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Color vision defect before treatment',

          'severity': 'mild',
        });
      }

      if (q155Improved == 'Yes') {

        symptoms.add({

          'name':
              'Color vision defect improved after stopping',

          'severity': 'mild',
        });
      }

      if (q156Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Color vision defect returned after restart',

          'severity': 'moderate',
        });
      }
    }

    /// ================= Q16 =================

    if (q16Answer == 'Yes') {

      symptoms.add({

        'name': 'Visual field defect',

        'severity':
            _mapFieldSeverity(q162Severity),
      });

      if (q163AfterTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Visual field defect after medication',

          'severity': 'mild',
        });
      }

      if (q164BeforeTherapy == 'Yes') {

        symptoms.add({

          'name':
              'Visual field defect before treatment',

          'severity': 'mild',
        });
      }

      if (q165Improved == 'Yes') {

        symptoms.add({

          'name':
              'Visual field defect improved after stopping',

          'severity': 'mild',
        });
      }

      if (q166Restarted == 'Yes') {

        symptoms.add({

          'name':
              'Visual field defect returned after restart',

          'severity': 'moderate',
        });
      }
    }

    if (symptoms.isEmpty) {
      return false;
    }

    for (var s in symptoms) {

      await SystemsApi.saveSymptom(

        reportId: widget.reportId,

        questionnaireSystem:
            "OCULAR INVOLVEMENT",

        symptomName: s['name']!,

        symptomPresent: "Yes",

        severity: s['severity']!,

        regimenType: "SLD",
      );
    }

    return true;
  }

  /// ================= VALIDATION =================

  bool _validateForm() {

    if (q14Answer == null) return false;
    if (q15Answer == null) return false;
    if (q16Answer == null) return false;

    return true;
  }

  /// ================= SEVERITY =================

  String _mapVisionSeverity(
      String? value) {

    if (value == null) return 'moderate';

    if (value.startsWith('Mild')) {
      return 'mild';
    }

    if (value.startsWith('Moderate')) {
      return 'moderate';
    }

    if (value.startsWith('Severe')) {
      return 'severe';
    }

    return 'moderate';
  }

  String _mapColorSeverity(String? value) {

  if (value == null) {
    return 'moderate';
  }

  final lower = value.toLowerCase();

  if (lower.contains('grade 0')) {
    return 'asymptomatic';
  }

  if (lower.contains('grade 1')) {
    return 'mild';
  }

  if (lower.contains('grade 2')) {
    return 'moderate';
  }

  if (lower.contains('grade 3')) {
    return 'severe';
  }

  if (lower.contains('grade 4')) {
    return 'life threatening';
  }

  return 'moderate';
}

  String _mapFieldSeverity(
      String? value) {

    if (value == null) return 'moderate';
    
    if (value.startsWith('Mild')) {
      return 'mild';
    }

    if (value.startsWith('Moderate')) {
      return 'moderate';
    }

    if (value.startsWith('Severe')) {
      return 'severe';
    }

    return 'moderate';
  }

  /// ================= HELPERS =================

  Widget _buildSnellenSection() {

    return Card(

      margin:
          const EdgeInsets.only(bottom: 16),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(

              "14.1 Visual Acuity Assessment (Snellen Chart)",

              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildTextField(
              controller: q141RightTop,
              label: "Right Eye (OD) numerator",
            ),

            _buildTextField(
              controller: q141RightBottom,
              label: "Right Eye (OD) denominator",
            ),

            _buildTextField(
              controller: q141LeftTop,
              label: "Left Eye (OS) numerator",
            ),

            _buildTextField(
              controller: q141LeftBottom,
              label: "Left Eye (OS) denominator",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({

    required TextEditingController controller,

    required String label,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(bottom: 12),

      child: TextField(

        controller: controller,

        decoration: InputDecoration(

          labelText: label,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),

          filled: true,

          fillColor: Colors.white,
        ),
      ),
    );
  }

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

  @override
  void dispose() {

    q141RightTop.dispose();
    q141RightBottom.dispose();
    q141LeftTop.dispose();
    q141LeftBottom.dispose();
    

    super.dispose();
  }
}