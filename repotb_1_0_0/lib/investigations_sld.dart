import 'package:flutter/material.dart';
import 'systems_api.dart';

class InvestigationsSLDScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;

  const InvestigationsSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<InvestigationsSLDScreen> createState() =>
      _InvestigationsSLDScreenState();
}

class _InvestigationsSLDScreenState
    extends State<InvestigationsSLDScreen> {

  // =====================================
  // Q28 HEMOGLOBIN
  // =====================================

  String? q28Answer;

  final hgbController = TextEditingController();
  final hgbLLNController = TextEditingController();
  final hgbBaselineController = TextEditingController();

  // =====================================
  // Q29 PLATELETS
  // =====================================

  String? q29Answer;

  final plateletController = TextEditingController();
  final plateletLLNController = TextEditingController();
  final plateletBaselineController = TextEditingController();

  // =====================================
  // Q30 ANC
  // =====================================

  String? q30Answer;

  final ancController = TextEditingController();
  final ancLLNController = TextEditingController();
  final ancBaselineController = TextEditingController();

  String? q302Answer;

  // =====================================
  // Q31 METABOLIC
  // =====================================

  String? q31Answer;

  List<String> q311Symptoms = [];

  String? q312Answer;

  final lactateController = TextEditingController();
  final lactateULNController = TextEditingController();

  final phController = TextEditingController();
  final phULNController = TextEditingController();

  final bicarbonateController = TextEditingController();
  final bicarbonateULNController = TextEditingController();

  String? q313Answer;
  String? q314Answer;
  String? q315Answer;
  String? q316Answer;

  // =====================================
  // Q32 URIC ACID
  // =====================================

  String? q32Answer;

  final uricController = TextEditingController();
  final uricULNController = TextEditingController();
  final uricBaselineController = TextEditingController();

  // =====================================
  // Q33 RENAL
  // =====================================

  String? q33Answer;

  final creatinineController = TextEditingController();
  final creatinineULNController = TextEditingController();
  final creatinineBaselineController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // =====================================
              // Q28 HGB
              // =====================================

              _buildRadioQuestion(

                number: "28",

                question:
                    "Did you get your hemoglobin (Hgb) tested recently?",

                options: ['Yes', 'No','Unknown'],

                value: q28Answer,

                onChanged: (val) {
                  setState(() {
                    q28Answer = val;
                  });
                },
              ),

              if (q28Answer == 'Yes') ...[

                const SizedBox(height: 20),

                Text(
                  "28.1 Please enter your most recent hemoglobin (Hgb) values:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),

                const SizedBox(height: 20),

                _buildTripleFieldRow(
                  title: "Hemoglobin",
                  valueController: hgbController,
                  limitController: hgbLLNController,
                  baselineController: hgbBaselineController,
                  limitLabel: "LLN",
                  valueHint: "g/dL",
                ),
              ],

              // =====================================
              // Q29 Platelets
              // =====================================

              const SizedBox(height: 30),

              _buildRadioQuestion(

                number: "29",

                question:
                    "Have you had your platelet count checked recently or experienced unusual bleeding/bruising since starting medication?",

                options: ['Yes', 'No','Unknown'],

                value: q29Answer,

                onChanged: (val) {
                  setState(() {
                    q29Answer = val;
                  });
                },
              ),

              if (q29Answer == 'Yes') ...[

                const SizedBox(height: 20),

                Text(
                  "29.1 Please enter your platelet values:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),

                const SizedBox(height: 20),

                _buildTripleFieldRow(
                  title: "Platelet Count",
                  valueController: plateletController,
                  limitController: plateletLLNController,
                  baselineController: plateletBaselineController,
                  limitLabel: "LLN",
                  valueHint: "/µL",
                ),
              ],

              // =====================================
              // Q30 ANC
              // =====================================

              const SizedBox(height: 30),

              _buildRadioQuestion(

                number: "30",

                question:
                    "Did you get your Absolute Neutrophil Count (ANC) tested recently?",

                options: ['Yes', 'No','Unknown'],

                value: q30Answer,

                onChanged: (val) {
                  setState(() {
                    q30Answer = val;
                  });
                },
              ),

              if (q30Answer == 'Yes') ...[

                const SizedBox(height: 20),

                Text(
                  "30.1 Please enter ANC values:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),

                const SizedBox(height: 20),

                _buildTripleFieldRow(
                  title: "ANC",
                  valueController: ancController,
                  limitController: ancLLNController,
                  baselineController: ancBaselineController,
                  limitLabel: "LLN",
                  valueHint: "/µL",
                ),

                const SizedBox(height: 20),

                _buildRadioQuestion(

                  number: "30.2",

                  question:
                      "Did you have fever (temperature ≥38°C) along with low neutrophil count?",

                  options: ['Yes', 'No','Unknown'],

                  value: q302Answer,

                  onChanged: (val) {
                    setState(() {
                      q302Answer = val;
                    });
                  },
                ),
              ],

              // =====================================
              // Q31 Lactic Acidosis
              // =====================================

              const SizedBox(height: 30),

              _buildRadioQuestion(

                number: "31",

                question:
                    "Have you experienced symptoms suggestive of lactic acidosis after starting TB treatment?",

                options: ['Yes', 'No','Unknown'],

                value: q31Answer,

                onChanged: (val) {
                  setState(() {
                    q31Answer = val;
                  });
                },
              ),

              if (q31Answer == 'Yes') ...[

                const SizedBox(height: 20),

                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          "31.1 What symptoms did you experience?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                       
                        const SizedBox(height: 10),

                        ...[
                          'Nausea',
                          'Vomiting',
                          'Abdominal pain',
                          'Severe fatigue or weakness',
                          'Rapid or deep breathing',
                          'Muscle pain',
                          'Dizziness',
                          'Confusion / altered sensorium',
                          'No symptoms (lab abnormality only)',
                        ].map(

                          (symptom) => CheckboxListTile(

                            activeColor: Colors.blue[700],

                            value: q311Symptoms.contains(symptom),

                            title: Text(symptom),

                            onChanged: (val) {

                              setState(() {

                                if (val == true) {
                                  q311Symptoms.add(symptom);
                                } else {
                                  q311Symptoms.remove(symptom);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildRadioQuestion(

                  number: "31.2",

                  question:
                      "Did you undergo a blood lactate test?",

                  options: ['Yes', 'No','Unknown'],

                  value: q312Answer,

                  onChanged: (val) {
                    setState(() {
                      q312Answer = val;
                    });
                  },
                ),

                if (q312Answer == 'Yes') ...[

                  const SizedBox(height: 20),

                  Text(
                    "31.2 Lab Values",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildDoubleFieldRow(
                    title: "Serum Lactate",
                    valueController: lactateController,
                    limitController: lactateULNController,
                    limitLabel: "ULN",
                    valueHint: "mmol/L",
                  ),

                  const SizedBox(height: 20),

                  _buildDoubleFieldRow(
                    title: "Blood pH",
                    valueController: phController,
                    limitController: phULNController,
                    limitLabel: "ULN",
                    valueHint: "pH",
                  ),

                  const SizedBox(height: 20),

                  _buildDoubleFieldRow(
                    title: "Bicarbonate",
                    valueController: bicarbonateController,
                    limitController: bicarbonateULNController,
                    limitLabel: "ULN",
                    valueHint: "mEq/L",
                  ),
                ],

                const SizedBox(height: 20),

                _buildRadioQuestion(
                  number: "31.3",
                  question: "What was the clinical severity?",
                  options: [
                    'Asymptomatic lactate elevation (no symptoms)',
                    'Mild metabolic acidosis (symptoms but no admission)',
                    'Severe acidosis (required hospital admission)',
                    'Required ICU admission',
                  ],
                  value: q313Answer,
                  onChanged: (val) {
                    setState(() {
                      q313Answer = val;
                    });
                  },
                ),

                _buildRadioQuestion(
                  number: "31.4",
                  question:
                      "Did this occur after starting Linezolid?",
                  options: ['Yes', 'No','Unknown'],
                  value: q314Answer,
                  onChanged: (val) {
                    setState(() {
                      q314Answer = val;
                    });
                  },
                ),

                _buildRadioQuestion(
                  number: "31.5",
                  question:
                      "Did the condition improve after stopping or reducing Linezolid?",
                  options: ['Yes', 'No','Unknown'],
                  value: q315Answer,
                  onChanged: (val) {
                    setState(() {
                      q315Answer = val;
                    });
                  },
                ),

                _buildRadioQuestion(
                  number: "31.6",
                  question:
                      "Did it recur after restarting Linezolid?",
                  options: ['Yes', 'No','Unknown'],
                  value: q316Answer,
                  onChanged: (val) {
                    setState(() {
                      q316Answer = val;
                    });
                  },
                ),
              ],

              // =====================================
              // Q32 Uric Acid
              // =====================================

              const SizedBox(height: 30),

              _buildRadioQuestion(

                number: "32",

                question:
                    "Have you had your serum uric acid tested recently?",

                options: ['Yes', 'No','Unknown'],

                value: q32Answer,

                onChanged: (val) {
                  setState(() {
                    q32Answer = val;
                  });
                },
              ),

              if (q32Answer == 'Yes') ...[

                const SizedBox(height: 20),

                Text(
                  "32.1 Please enter serum uric acid values:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),

                const SizedBox(height: 20),

                _buildTripleFieldRow(
                  title: "Serum Uric Acid",
                  valueController: uricController,
                  limitController: uricULNController,
                  baselineController: uricBaselineController,
                  limitLabel: "ULN",
                  valueHint: "mg/dL",
                ),
              ],

              // =====================================
              // Q33 Creatinine
              // =====================================

              const SizedBox(height: 30),

              _buildRadioQuestion(

                number: "33",

                question:
                    "Have you had a recent kidney function test (serum creatinine)?",

                options: ['Yes', 'No','Unknown'],

                value: q33Answer,

                onChanged: (val) {
                  setState(() {
                    q33Answer = val;
                  });
                },
              ),

              if (q33Answer == 'Yes') ...[

                const SizedBox(height: 20),

                Text(
                  "33.1 Please enter creatinine values:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),

                const SizedBox(height: 20),

                _buildTripleFieldRow(
                  title: "Serum Creatinine",
                  valueController: creatinineController,
                  limitController: creatinineULNController,
                  baselineController: creatinineBaselineController,
                  limitLabel: "ULN",
                  valueHint: "mg/dL",
                ),
              ],

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
          "Save & Next",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        onPressed: () async {

          await SystemsApi.saveInvestigationsSLD(

            data: {

              "report_id": widget.reportId,

              "hgb_done": q28Answer,
              "hgb_value": double.tryParse(hgbController.text),
              "hgb_lln": double.tryParse(hgbLLNController.text),
              "hgb_baseline": double.tryParse(hgbBaselineController.text),

              "platelet_done": q29Answer,
              "platelet_value": double.tryParse(plateletController.text),
              "platelet_lln": double.tryParse(plateletLLNController.text),
              "platelet_baseline": double.tryParse(plateletBaselineController.text),

              "anc_done": q30Answer,
              "anc_value": double.tryParse(ancController.text),
              "anc_lln": double.tryParse(ancLLNController.text),
              "anc_baseline": double.tryParse(ancBaselineController.text),
              "neutropenic_fever": q302Answer,

              "lactate_acidosis_done": q31Answer,
              "lactate_symptoms": q311Symptoms.join(','),

              "lactate_test_done": q312Answer,

              "serum_lactate":
                  double.tryParse(lactateController.text),

              "serum_lactate_uln":
                  double.tryParse(lactateULNController.text),

              "blood_ph":
                  double.tryParse(phController.text),

              "blood_ph_uln":
                  double.tryParse(phULNController.text),

              "bicarbonate":
                  double.tryParse(bicarbonateController.text),

              "bicarbonate_uln":
                  double.tryParse(bicarbonateULNController.text),

              "lactate_severity": q313Answer,
              "linezolid_related": q314Answer,
              "improved_after_stop": q315Answer,
              "recurred_after_restart": q316Answer,

              "uric_acid_done": q32Answer,
              "uric_acid_value":
                  double.tryParse(uricController.text),
              "uric_acid_uln":
                  double.tryParse(uricULNController.text),
              "uric_acid_baseline":
                  double.tryParse(uricBaselineController.text),

              "creatinine_done": q33Answer,
              "creatinine_value":
                  double.tryParse(creatinineController.text),
              "creatinine_uln":
                  double.tryParse(creatinineULNController.text),
              "creatinine_baseline":
                  double.tryParse(creatinineBaselineController.text),
            },
          );

          if (!mounted) return;

Navigator.pop(context, true);
        },
      ),
    );
  }

  // =====================================
  // RADIO QUESTION
  // =====================================

  Widget _buildRadioQuestion({

    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String?) onChanged,
  }) {

    return Card(

      margin: const EdgeInsets.only(bottom: 16),

      elevation: 2,

      color: Colors.white,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

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

                title: Text(
                  option,
                  style: const TextStyle(fontSize: 14),
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

  // =====================================
  // TRIPLE FIELD ROW
  // =====================================

  Widget _buildTripleFieldRow({

    required String title,
    required TextEditingController valueController,
    required TextEditingController limitController,
    required TextEditingController baselineController,
    required String limitLabel,
    required String valueHint,
  }) {

    return Card(

      elevation: 2,

      color: Colors.white,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),

            Row(

              children: [

                Expanded(
                  flex: 3,
                  child: _buildSmallField(
                    label: "Value",
                    controller: valueController,
                    hint: valueHint,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  flex: 2,
                  child: _buildSmallField(
                    label: limitLabel,
                    controller: limitController,
                    hint: valueHint,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  flex: 2,
                  child: _buildSmallField(
                    label: "Baseline",
                    controller: baselineController,
                    hint: "Optional",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // DOUBLE FIELD ROW
  // =====================================

  Widget _buildDoubleFieldRow({

    required String title,
    required TextEditingController valueController,
    required TextEditingController limitController,
    required String limitLabel,
    required String valueHint,
  }) {

    return Card(

      elevation: 2,

      color: Colors.white,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),

            Row(

              children: [

                Expanded(
                  child: _buildSmallField(
                    label: "Value",
                    controller: valueController,
                    hint: valueHint,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _buildSmallField(
                    label: limitLabel,
                    controller: limitController,
                    hint: valueHint,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // SMALL FIELD
  // =====================================

  Widget _buildSmallField({

    required String label,
    required TextEditingController controller,
    required String hint,
  }) {

    return Container(

      padding: const EdgeInsets.all(8),

      decoration: BoxDecoration(

        color: Colors.grey[100],

        borderRadius: BorderRadius.circular(8),

        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 4),

          TextField(

            controller: controller,

            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),

            style: const TextStyle(fontSize: 14),

            decoration: InputDecoration(

              hintText: hint,

              hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),

              border: InputBorder.none,

              contentPadding:
                  const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),

              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {

    hgbController.dispose();
    hgbLLNController.dispose();
    hgbBaselineController.dispose();

    plateletController.dispose();
    plateletLLNController.dispose();
    plateletBaselineController.dispose();

    ancController.dispose();
    ancLLNController.dispose();
    ancBaselineController.dispose();

    lactateController.dispose();
    lactateULNController.dispose();

    phController.dispose();
    phULNController.dispose();

    bicarbonateController.dispose();
    bicarbonateULNController.dispose();

    uricController.dispose();
    uricULNController.dispose();
    uricBaselineController.dispose();

    creatinineController.dispose();
    creatinineULNController.dispose();
    creatinineBaselineController.dispose();

    super.dispose();
  }
}