import 'package:flutter/material.dart';
import 'systems_api.dart';
import 'package:printing/printing.dart';
import '../services/sld_report_generator.dart';

import '../services/report_api.dart';
import '../services/grading_reportsld.dart';
import '../services/questionnaire_timer.dart';

class OtherSideEffectsScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const OtherSideEffectsScreen({

    super.key,

    required this.reportId,

    required this.onSaveAndComplete,
  });

  @override
  State<OtherSideEffectsScreen> createState() =>
      _OtherSideEffectsScreenState();
}

class _OtherSideEffectsScreenState
    extends State<OtherSideEffectsScreen> {

  String? q401;
  String? q402;
  String? q403;
  String? q404;
  String? q405;
  String? q406;
  String? q407;
  String? q408;
  String? q409;
  String? q4010;
  String? q4011;
  String? q4012;
  String? q4013;
  String? q4014;
  String? q4015;
  String? q4016;
  String? q4017;
  String? q4018;

  final q4019Controller =
      TextEditingController();

  bool validateForm() {

    return q401 != null &&
        q402 != null &&
        q403 != null &&
        q404 != null &&
        q405 != null &&
        q406 != null &&
        q407 != null &&
        q408 != null &&
        q409 != null &&
        q4010 != null &&
        q4011 != null &&
        q4012 != null &&
        q4013 != null &&
        q4014 != null &&
        q4015 != null &&
        q4016 != null &&
        q4017 != null &&
        q4018 != null;
  }
   void _showReportDialog() {

  showDialog(

    context: context,

    barrierDismissible: false,

    builder: (context) {

      return AlertDialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        title: const Text(
          "ADR Report Generated",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        content: const Text(
          "The SLD ADR report has been successfully generated.",
        ),

        actions: [

          // CLOSE BUTTON
          TextButton(

            onPressed: () {
            if (mounted) {
              Navigator.pop(context);
            }

              widget.onSaveAndComplete();
            },

            child: const Text("Close"),
          ),

          // DOWNLOAD REPORT BUTTON
          ElevatedButton.icon(

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),

           onPressed: () async {

  try {

    final reportData =
        await ReportApi.getFullReport(
      widget.reportId,
    );
    final totalDuration =
    QuestionnaireTimer.getElapsed();

final hours =
    totalDuration.inHours
        .toString()
        .padLeft(2, '0');

final minutes =
    totalDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

final seconds =
    totalDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

reportData['completion_time'] =
    "$hours:$minutes:$seconds";

    final systemsRaw =
        reportData['systems'];
        print('FULL REPORT DATA:');
print(reportData);

print('SYSTEMS RAW:');
print(systemsRaw);
      print(reportData);
print(systemsRaw);
    final List<Map<String, dynamic>> systems =

        systemsRaw is List

            ? List<Map<String, dynamic>>.from(
                systemsRaw)

            : [];

    final cardioSymptoms = systems
        .where(
          (s) =>
              s['system_name'] ==
              'Cardiovascular',
        )
        .toList();

    final cardioReport =
        GradingReportSLD
            .generateCardioReport(
                cardioSymptoms);

    final pdfBytes =
        await SLDReportGenerator.generateReport(

      reportId: widget.reportId,
        reportData: reportData,

      cardioReport: cardioReport,
    );

    if (!mounted) return;

    showDialog(

      context: context,

      builder: (dialogContext) => AlertDialog(

        title: const Text(
          'TB ADR Report Preview',
        ),

        content: SizedBox(

          width: 700,
          height: 800,

          child: PdfPreview(

            build: (format) async =>
                pdfBytes,
          ),
        ),

        actions: [

          TextButton(

            onPressed: () =>
                Navigator.pop(dialogContext),

            child: const Text('Close'),
          ),
        ],
      ),
    );
    } catch (e) {

  if (!mounted) return;

  ScaffoldMessenger.of(context)
      .showSnackBar(

    SnackBar(

      content: Text(
        'PDF generation failed: $e',
      ),
    ),
  );
}
  
},

            icon: const Icon(Icons.download),

            label: const Text(
              "Download Report",
            ),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(

                "40. OTHER SIDE EFFECTS",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,

                  color: Colors.blue[800],
                ),
              ),

              const SizedBox(height: 10),

              Text(

                "Please select Yes if you experienced any of the following after starting TB treatment:",

                style: TextStyle(

                  fontSize: 15,

                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 25),

              _buildRadioQuestion(
                number: "40.1",
                question:
                    "Have you had pain, swelling, or hardness at the injection site?",
                value: q401,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q401 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.2",
                question:
                    "Have you had a severe allergic reaction (sudden swelling, breathing difficulty, severe rash)?",
                value: q402,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q402 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.3",
                question:
                    "Have you experienced sudden severe allergy with fainting or shock?",
                value: q403,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q403 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.4",
                question:
                    "Have you been told that you have protein in your urine?",
                value: q404,
                options: ['Yes', 'No', 'Not tested'],
                onChanged: (val) {
                  setState(() {
                    q404 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.5",
                question:
                    "Have you been diagnosed with lupus (SLE) after starting treatment?",
                value: q405,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q405 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.6",
                question:
                    "Have you had rash with fever, facial swelling, or enlarged lymph nodes (DRESS)?",
                value: q406,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q406 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.7",
                question:
                    "Have you experienced new or worsening tremors (shaking of hands/body)?",
                value: q407,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q407 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.8",
                question:
                    "Have you had inflammation, swelling, or bleeding of the gums?",
                value: q408,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q408 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.9",
                question:
                    "Have you had a change in your sense of taste?",
                value: q409,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q409 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.10",
                question:
                    "Have you experienced excessive salivation?",
                value: q4010,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4010 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.11",
                question:
                    "Have you had mouth sores or painful ulcers (stomatitis)?",
                value: q4011,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4011 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.12",
                question:
                    "Have you developed skin changes with dark patches, scaling, or symptoms suggestive of pellagra?",
                value: q4012,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4012 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.13",
                question:
                    "Have you been told that your blood clotting time (prothrombin time/INR) is increased?",
                value: q4013,
                options: ['Yes', 'No', 'Not tested'],
                onChanged: (val) {
                  setState(() {
                    q4013 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.14",
                question:
                    "Have you experienced breast tenderness or enlargement (gynecomastia)?",
                value: q4014,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4014 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.15",
                question:
                    "Have you experienced bloating (feeling of fullness or abdominal swelling)?",
                value: q4015,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4015 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.16",
                question:
                    "Have you had loss of appetite after starting TB treatment?",
                value: q4016,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4016 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.17",
                question:
                    "Have you experienced forgetfulness or changes in memory, concentration, or thinking?",
                value: q4017,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4017 = val;
                  });
                },
              ),

              _buildRadioQuestion(
                number: "40.18",
                question:
                    "Have you noticed swelling of your legs or feet?",
                value: q4018,
                options: ['Yes', 'No'],
                onChanged: (val) {
                  setState(() {
                    q4018 = val;
                  });
                },
              ),

              _buildTextField(

                label:
                    "40.19 Any other symptoms",

                controller:
                    q4019Controller,
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,

      floatingActionButton:
          FloatingActionButton.extended(

        backgroundColor: Colors.green[600],

        foregroundColor: Colors.white,

        label: const Text(

          "Submit",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        onPressed: () async {

          if (!validateForm()) {

            ScaffoldMessenger.of(context)
                .showSnackBar(

              const SnackBar(

                content: Text(
                  "Please complete all required fields",
                ),
              ),
            );

            return;
          }

          try {

            await SystemsApi
                .saveOtherSideEffects(

              data: {

                "report_id":
                    widget.reportId,

                "injection_site_reaction":
                    q401,

                "severe_allergic_reaction":
                    q402,

                "anaphylaxis":
                    q403,

                "proteinuria":
                    q404,

                "sle":
                    q405,

                "dress_syndrome":
                    q406,

                "tremors":
                    q407,

                "gum_inflammation":
                    q408,

                "taste_change":
                    q409,

                "excess_salivation":
                    q4010,

                "stomatitis":
                    q4011,

                "pellagra":
                    q4012,

                "increased_inr":
                    q4013,

                "gynecomastia":
                    q4014,

                "bloating":
                    q4015,

                "loss_of_appetite":
                    q4016,

                "memory_changes":
                    q4017,

                "leg_swelling":
                    q4018,

                "other_symptoms":
                    q4019Controller.text,
              },
            );

            _showReportDialog();

          } catch (e) {

            ScaffoldMessenger.of(context)
                .showSnackBar(

              const SnackBar(

                content: Text(
                  "Failed to save Other Side Effects",
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildRadioQuestion({

    required String number,

    required String question,

    required List<String> options,

    required String? value,

    required Function(String?) onChanged,
  }) {

    return Card(

      margin:
          const EdgeInsets.only(bottom: 16),

      elevation: 2,

      color: Colors.white,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              "$number. $question",

              style: const TextStyle(

                fontSize: 16,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...options.map(

              (option) => RadioListTile<String>(

                activeColor:
                    Colors.blue[700],

                contentPadding:
                    EdgeInsets.zero,

                title: Text(

                  option,

                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),

                value: option,

                groupValue: value,

                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({

    required String label,

    required TextEditingController
        controller,
  }) {

    return Card(

      elevation: 2,

      color: Colors.white,

      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              label,

              style: const TextStyle(

                fontSize: 16,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(

              padding:
                  const EdgeInsets.all(8),

              decoration: BoxDecoration(

                color: Colors.grey[100],

                borderRadius:
                    BorderRadius.circular(8),

                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),

              child: TextField(

                controller: controller,

                style: const TextStyle(
                  fontSize: 14,
                ),

                decoration:
                    const InputDecoration(

                  border: InputBorder.none,

                  contentPadding:
                      EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

                  isDense: true,
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

    q4019Controller.dispose();

    super.dispose();
  }
}