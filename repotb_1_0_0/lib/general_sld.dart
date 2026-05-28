import 'package:flutter/material.dart';
import 'systems_api.dart';

class GeneralSymptomsScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const GeneralSymptomsScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<GeneralSymptomsScreen> createState() =>
      _GeneralSymptomsScreenState();
}

class _GeneralSymptomsScreenState
    extends State<GeneralSymptomsScreen> {

  // =====================================
  // Q34 FATIGUE
  // =====================================

  String? q34Answer;

  final q341DurationController =
      TextEditingController();

  String? q342Severity;
  String? q343AfterStart;
  String? q344Before;
  String? q345Improved;
  String? q346Reappeared;
  String? q347Lifestyle;

  final q348OtherIssuesController =
      TextEditingController();

  // =====================================
  // Q35 WEIGHT LOSS
  // =====================================

  String? q35Answer;

  final q351BeforeWeightController =
      TextEditingController();

  final q351CurrentWeightController =
      TextEditingController();

  // =====================================
  // Q36 FEVER
  // =====================================

  String? q36Answer;

  final q361DurationController =
      TextEditingController();

  String? q362Severity;
  String? q363AfterStart;
  String? q364Before;
  String? q365Improved;
  String? q366Reappeared;

  // =====================================
  // Q37 JOINT PAIN
  // =====================================

  String? q37Answer;

  final q371DurationController =
      TextEditingController();

  String? q372Severity;

  List<String> q373Joints = [];

  final q373OtherController =
      TextEditingController();

  String? q374AfterStart;
  String? q375Before;
  String? q376Improved;
  String? q377Reappeared;

  // =====================================
  // Q38 HEADACHE
  // =====================================

  String? q38Answer;
  String? q381Severity;
  String? q382AfterStart;
  String? q383Before;
  String? q384Improved;
  String? q385Reappeared;

  // =====================================
  // Q39 ITCHING
  // =====================================

  String? q39Answer;
  String? q391Severity;
  String? q392AfterStart;
  String? q393Before;
  String? q394Improved;
  String? q395Reappeared;

  // =====================================
  // VALIDATION
  // =====================================

  bool validateForm() {

    if (q34Answer == null) {
      return false;
    }

    if (q34Answer == 'Yes') {

      if (q341DurationController
              .text
              .isEmpty ||
          q342Severity == null ||
          q343AfterStart == null ||
          q344Before == null ||
          q345Improved == null ||
          q346Reappeared == null ||
          q347Lifestyle == null) {

        return false;
      }
    }

    if (q35Answer == null) {
      return false;
    }

    if (q35Answer == 'Yes') {

      if (q351BeforeWeightController
              .text
              .isEmpty ||
          q351CurrentWeightController
              .text
              .isEmpty) {

        return false;
      }
    }

    if (q36Answer == null) {
      return false;
    }

    if (q36Answer == 'Yes') {

      if (q361DurationController
              .text
              .isEmpty ||
          q362Severity == null ||
          q363AfterStart == null ||
          q364Before == null ||
          q365Improved == null ||
          q366Reappeared == null) {

        return false;
      }
    }

    if (q37Answer == null) {
      return false;
    }

    if (q37Answer == 'Yes') {

      if (q371DurationController
              .text
              .isEmpty ||
          q372Severity == null ||
          q374AfterStart == null ||
          q375Before == null ||
          q376Improved == null ||
          q377Reappeared == null) {

        return false;
      }

      if (q373Joints.isEmpty &&
          q373OtherController
              .text
              .isEmpty) {

        return false;
      }
    }

    if (q38Answer == null) {
      return false;
    }

    if (q38Answer == 'Yes') {

      if (q381Severity == null ||
          q382AfterStart == null ||
          q383Before == null ||
          q384Improved == null ||
          q385Reappeared == null) {

        return false;
      }
    }

    if (q39Answer == null) {
      return false;
    }

    if (q39Answer == 'Yes') {

      if (q391Severity == null ||
          q392AfterStart == null ||
          q393Before == null ||
          q394Improved == null ||
          q395Reappeared == null) {

        return false;
      }
    }

    return true;
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

              // =====================================
              // Q34 FATIGUE
              // =====================================

              _buildRadioQuestion(

                number: "34",

                question:
                    "Have you experienced unusual fatigue or weakness since starting the medication?",

                options: ['Yes', 'No','Unknown'],

                value: q34Answer,

                isRequired: true,

                onChanged: (val) {

                  setState(() {
                    q34Answer = val;
                  });
                },
              ),

              if (q34Answer == 'Yes') ...[

                _buildTextField(

                  label:
                      "34.1 Duration (weeks)",

                  controller:
                      q341DurationController,

                  keyboardType:
                      TextInputType.number,

                  isRequired: true,
                ),

                _buildRadioQuestion(

                  number: "34.2",

                  question:
                      "How severe was the fatigue?",

                  options: [
                    'Mild',
                    'Moderate',
                    'Severe',
                  ],

                  value: q342Severity,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q342Severity = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "34.3",

                  question:
                      "Did this symptom begin after starting therapy?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not sure',
                  ],

                  value: q343AfterStart,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q343AfterStart = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "34.4",

                  question:
                      "Did you experience similar fatigue before treatment?",

                  options: ['Yes', 'No','Unknown'],

                  value: q344Before,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q344Before = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "34.5",

                  question:
                      "Did fatigue improve after stopping/adjusting medication?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not applicable',
                  ],

                  value: q345Improved,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q345Improved = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "34.6",

                  question:
                      "Did fatigue reappear after restarting medication?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not applicable',
                  ],

                  value: q346Reappeared,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q346Reappeared = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "34.7",

                  question:
                      "Any significant lifestyle changes?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not applicable',
                  ],

                  value: q347Lifestyle,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q347Lifestyle = val;
                    });
                  },
                ),

                _buildTextField(

                  label:
                      "34.8 Other health issues or medications",

                  controller:
                      q348OtherIssuesController,
                ),
              ],

              const SizedBox(height: 30),

              // =====================================
              // Q35 WEIGHT LOSS
              // =====================================

              _buildRadioQuestion(

                number: "35",

                question:
                    "Have you lost weight after starting TB treatment?",

                options: ['Yes', 'No','Unknown'],

                value: q35Answer,

                isRequired: true,

                onChanged: (val) {

                  setState(() {
                    q35Answer = val;
                  });
                },
              ),

              if (q35Answer == 'Yes') ...[

                _buildTextField(

                  label:
                      "Weight before treatment (kg)",

                  controller:
                      q351BeforeWeightController,

                  keyboardType:
                      TextInputType.number,

                  isRequired: true,
                ),

                _buildTextField(

                  label:
                      "Current weight (kg)",

                  controller:
                      q351CurrentWeightController,

                  keyboardType:
                      TextInputType.number,

                  isRequired: true,
                ),
              ],

              const SizedBox(height: 30),

              // =====================================
              // Q36 FEVER
              // =====================================

              _buildRadioQuestion(

                number: "36",

                question:
                    "Have you experienced fever since starting medication?",

                options: ['Yes', 'No','Unknown'],

                value: q36Answer,

                isRequired: true,

                onChanged: (val) {

                  setState(() {
                    q36Answer = val;
                  });
                },
              ),

              if (q36Answer == 'Yes') ...[

                _buildTextField(

                  label:
                      "36.1 Fever duration",

                  controller:
                      q361DurationController,

                  isRequired: true,
                ),

                _buildRadioQuestion(

                  number: "36.2",

                  question:
                      "How severe was the fever?",

                  options: [
                    'Mild',
                    'Moderate',
                    'High grade',
                    'Very high / Prolonged',
                  ],

                  value: q362Severity,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q362Severity = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "36.3",

                  question:
                      "Did fever begin after therapy?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not sure',
                  ],

                  value: q363AfterStart,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q363AfterStart = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "36.4",

                  question:
                      "Did you have similar fever before treatment?",

                  options: ['Yes', 'No','Unknown'],

                  value: q364Before,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q364Before = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "36.5",

                  question:
                      "Did fever improve after stopping medication?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not applicable',
                  ],

                  value: q365Improved,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q365Improved = val;
                    });
                  },
                ),

                _buildRadioQuestion(

                  number: "36.6",

                  question:
                      "Did fever reappear after restarting medication?",

                  options: [
                    'Yes',
                    'No','Unknown',
                    'Not applicable',
                  ],

                  value: q366Reappeared,

                  isRequired: true,

                  onChanged: (val) {

                    setState(() {
                      q366Reappeared = val;
                    });
                  },
                ),
              ],
               // =====================================
// Q37 JOINT PAIN
// =====================================

const SizedBox(height: 30),

_buildRadioQuestion(

  number: "37",

  question:
      "Have you experienced any joint pain since starting the medication?",

  options: ['Yes', 'No','Unknown'],

  value: q37Answer,

  isRequired: true,

  onChanged: (val) {

    setState(() {
      q37Answer = val;
    });
  },
),

if (q37Answer == 'Yes') ...[

  _buildTextField(

    label:
        "37.1 How long have you had joint pain (in weeks)?",

    controller:
        q371DurationController,

    keyboardType:
        TextInputType.number,

    isRequired: true,
  ),

  _buildRadioQuestion(

    number: "37.2",

    question:
        "How severe was the joint pain?",

    options: [

      'Mild – Mild joint pain without limitation of daily activities.',

      'Moderate – Joint pain that interferes with instrumental activities of daily living.',

      'Severe – Joint pain that limits self-care activities or significantly restricts movement.',
    ],

    value: q372Severity,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q372Severity = val;
      });
    },
  ),

  Card(

    elevation: 2,

    color: Colors.white,

    margin:
        const EdgeInsets.only(
      bottom: 16,
    ),

    child: Padding(

      padding:
          const EdgeInsets.all(16),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          RichText(

            text: const TextSpan(

              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
                color: Colors.black,
              ),

              children: [

                TextSpan(
                  text:
                      "37.3 Which joints are affected?",
                ),

                TextSpan(
                  text: " *",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          ...[
            'Knees',
            'Ankles',
            'Shoulders',
            'Elbows',
            'Wrists',
            'Fingers',
            'Multiple joints',
          ].map(

            (joint) => CheckboxListTile(

              contentPadding:
                  EdgeInsets.zero,

              activeColor:
                  Colors.blue[700],
              
              value:
                  q373Joints.contains(joint),

              title: Text(joint),
              controlAffinity:
               ListTileControlAffinity.leading,
              onChanged: (val) {

                setState(() {

                  if (val == true) {

                    q373Joints.add(joint);

                  } else {

                    q373Joints.remove(joint);
                  }
                });
              },
            ),
          ),

          _buildTextField(

            label:
                "Other joints",

            controller:
                q373OtherController,
          ),
        ],
      ),
    ),
  ),

  _buildRadioQuestion(

    number: "37.4",

    question:
        "Did the joint pain begin after starting therapy?",

    options: [
      'Yes',
      'No','Unknown',
      'Not sure',
    ],

    value: q374AfterStart,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q374AfterStart = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "37.5",

    question:
        "Did you experience similar joint pain before treatment?",

    options: ['Yes', 'No','Unknown'],

    value: q375Before,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q375Before = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "37.6",

    question:
        "Did the joint pain improve after stopping or adjusting the medication?",

    options: [
      'Yes',
      'No','Unknown',
      'Not applicable',
    ],

    value: q376Improved,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q376Improved = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "37.7",

    question:
        "Did the joint pain reappear after restarting the medication?",

    options: [
      'Yes',
      'No','Unknown',
      'Not applicable',
    ],

    value: q377Reappeared,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q377Reappeared = val;
      });
    },
  ),
],


// =====================================
// Q38 HEADACHE
// =====================================

const SizedBox(height: 30),

_buildRadioQuestion(

  number: "38",

  question:
      "Have you had headaches after starting TB treatment?",

  options: ['Yes', 'No','Unknown'],

  value: q38Answer,

  isRequired: true,

  onChanged: (val) {

    setState(() {
      q38Answer = val;
    });
  },
),

if (q38Answer == 'Yes') ...[

  _buildRadioQuestion(

    number: "38.1",

    question:
        "How severe were the headaches?",

    options: [

      'Mild – Mild pain, did not interfere with daily activities',

      'Moderate – Pain that limited routine activities.',

      'Severe – Severe pain that limited self-care activities.',
    ],

    value: q381Severity,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q381Severity = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "38.2",

    question:
        "Did the headache start after beginning TB treatment?",

    options: ['Yes', 'No','Unknown'],

    value: q382AfterStart,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q382AfterStart = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "38.3",

    question:
        "Was the headache present before starting medication?",

    options: ['Yes', 'No','Unknown'],

    value: q383Before,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q383Before = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "38.4",

    question:
        "Did the headache improve after stopping or adjusting medication?",

    options: ['Yes', 'No','Unknown'],

    value: q384Improved,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q384Improved = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "38.5",

    question:
        "Did the headache reappear after restarting medication?",

    options: ['Yes', 'No','Unknown'],

    value: q385Reappeared,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q385Reappeared = val;
      });
    },
  ),
],


// =====================================
// Q39 ITCHING
// =====================================

const SizedBox(height: 30),

_buildRadioQuestion(

  number: "39",

  question:
      "Have you experienced itching after starting TB treatment?",

  options: ['Yes', 'No','Unknown'],

  value: q39Answer,

  isRequired: true,

  onChanged: (val) {

    setState(() {
      q39Answer = val;
    });
  },
),

if (q39Answer == 'Yes') ...[

  _buildRadioQuestion(

    number: "39.1",

    question:
        "How severe was the itching?",

    options: [

      'Mild – Mild or localized itching',

      'Moderate – Intense or widespread itching with skin changes',

      'Severe – Constant itching affecting sleep or daily activities',
    ],

    value: q391Severity,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q391Severity = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "39.2",

    question:
        "Did itching start after beginning TB treatment?",

    options: ['Yes', 'No','Unknown'],

    value: q392AfterStart,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q392AfterStart = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "39.3",

    question:
        "Was itching present before starting medication?",

    options: ['Yes', 'No','Unknown'],

    value: q393Before,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q393Before = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "39.4",

    question:
        "Did itching improve after stopping or adjusting medication?",

    options: ['Yes', 'No','Unknown'],

    value: q394Improved,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q394Improved = val;
      });
    },
  ),

  _buildRadioQuestion(

    number: "39.5",

    question:
        "Did itching reappear after restarting medication?",

    options: ['Yes', 'No','Unknown'],

    value: q395Reappeared,

    isRequired: true,

    onChanged: (val) {

      setState(() {
        q395Reappeared = val;
      });
    },
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
                .saveGeneralSymptomsSLD(

              data: {

                "report_id":
                    widget.reportId,

                "fatigue_present":
                    q34Answer,

                "fatigue_duration_weeks":
                    int.tryParse(
                      q341DurationController.text,
                    ),

                "fatigue_severity":
                    q342Severity,

                "fatigue_after_start":
                    q343AfterStart,

                "fatigue_before":
                    q344Before,

                "fatigue_improved":
                    q345Improved,

                "fatigue_reappeared":
                    q346Reappeared,

                "fatigue_lifestyle":
                    q347Lifestyle,

                "fatigue_other_issues":
                    q348OtherIssuesController.text,

                "weight_loss_present":
                    q35Answer,

                "weight_before":
                    double.tryParse(
                      q351BeforeWeightController.text,
                    ),

                "current_weight":
                    double.tryParse(
                      q351CurrentWeightController.text,
                    ),

                "fever_present":
                    q36Answer,

                "fever_duration":
                    q361DurationController.text,

                "fever_severity":
                    q362Severity,

                "fever_after_start":
                    q363AfterStart,

                "fever_before":
                    q364Before,

                "fever_improved":
                    q365Improved,

                "fever_reappeared":
                    q366Reappeared,
                 "joint_pain_present": 
                 q37Answer,
                "joint_pain_duration_weeks":
    int.tryParse(
      q371DurationController.text,
    ),
"joint_pain_severity":
    q372Severity,
"affected_joints":
    q373Joints.join(','),

"joint_other":
    q373OtherController.text,

"joint_after_start":
    q374AfterStart,

"joint_before":
    q375Before,

"joint_improved":
    q376Improved,

"joint_reappeared":
    q377Reappeared,

           "headache_present":
             q38Answer,

           "headache_severity":
             q381Severity,

          "headache_after_start":
           q382AfterStart,

           "headache_before":
           q383Before,

          "headache_improved":
           q384Improved,

           "headache_reappeared":
           q385Reappeared,

          "itching_present":
            q39Answer,
 
        "itching_severity":
           q391Severity,

           "itching_after_start":
          q392AfterStart,

        "itching_before":
         q393Before,

       "itching_improved":
            q394Improved,

        "itching_reappeared":
           q395Reappeared,
              },
            );

            widget.onSaveAndComplete();

          } catch (e) {

            ScaffoldMessenger.of(context)
                .showSnackBar(

              const SnackBar(
                content: Text(
                  "Failed to save General Symptoms",
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
    bool isRequired = false,
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

            RichText(

              text: TextSpan(

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                children: [

                  TextSpan(
                    text:
                        "$number. $question",
                  ),

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

    Function(String)? onChanged,

    bool isRequired = false,

    TextInputType keyboardType =
        TextInputType.text,
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

            RichText(

              text: TextSpan(

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                children: [

                  TextSpan(
                    text: label,
                  ),

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

                keyboardType:
                    keyboardType,

                onChanged: onChanged,

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

    q341DurationController.dispose();

    q348OtherIssuesController.dispose();

    q351BeforeWeightController.dispose();

    q351CurrentWeightController.dispose();

    q361DurationController.dispose();

    q371DurationController.dispose();

    q373OtherController.dispose();

    super.dispose();
  }
}