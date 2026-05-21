import 'package:flutter/material.dart';
import 'systems_api.dart';

class GastrointestinalSLDScreen extends StatefulWidget {

  final String reportId;
  final VoidCallback onSaveAndComplete;

  const GastrointestinalSLDScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<GastrointestinalSLDScreen> createState() =>
      _GastrointestinalSLDScreenState();
}

class _GastrointestinalSLDScreenState
    extends State<GastrointestinalSLDScreen> {

  /// ================= Q17 =================

  String? q17Answer;
  String? q171Severity;
  final q172Duration = TextEditingController();
  String? q173AfterTherapy;
  String? q174BeforeTherapy;
  String? q175Improved;
  String? q176Restarted;
  String? q177Diet;
  String? q178OtherMeds;

  /// ================= Q18 =================

  String? q18Answer;
  final q18Duration = TextEditingController();
  String? q181Severity;
  String? q182AfterTherapy;
  String? q183Improved;
  String? q184Restarted;
  String? q185OtherMeds;

  /// ================= Q19 =================

  String? q19Answer;
  String? q191Severity;
  final q192Duration = TextEditingController();
  String? q193AfterTherapy;
  String? q194BeforeTherapy;
  String? q195Improved;
  String? q196Restarted;
  String? q197History;
  String? q198Stress;

  /// ================= Q20 =================

  String? q20Answer;
  String? q201Severity;
  final q202Duration = TextEditingController();
  String? q203AfterTherapy;
  String? q204BeforeTherapy;
  String? q205Improved;
  String? q206Restarted;

  /// ================= Q21 =================

  String? q21Answer;
  String? q211Severity;
  final q212Duration = TextEditingController();
  String? q213AfterTherapy;
  String? q214BeforeTherapy;
  String? q215Improved;
  String? q216Restarted;

  /// ================= Q22 =================

  String? q22Answer;
  String? q221Severity;
  final q222Duration = TextEditingController();
  String? q223AfterTherapy;
  String? q224BeforeTherapy;
  String? q225Improved;
  String? q226Restarted;

  bool showErrors = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue[50],

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            children: [

              /// ================= 17 =================

              _buildRadioQuestion(

                number: "17",

                question:
                    "Have you experienced nausea since starting the treatment?",

                options: ['Yes', 'No'],

                value: q17Answer,

                onChanged: (v) =>
                    setState(() => q17Answer = v),
              ),

              if (q17Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "17.1",

                  question:
                      "How severe is your nausea?",

                  options: [

                    'Mild – Loss of appetite but eating habits are unchanged',

                    'Moderate – Reduced oral intake without significant weight loss, dehydration, or malnutrition',

                    'Severe – Unable to maintain adequate food or fluid intake; required medical support or hospitalization',
                  ],

                  value: q171Severity,

                  onChanged: (v) =>
                      setState(() =>
                          q171Severity = v),
                ),

                _buildTextField(

                  label:
                      "17.2 Duration (weeks)",

                  controller: q172Duration,
                ),

                _buildRadioQuestion(

                  number: "17.3",

                  question:
                      "Did the nausea begin after starting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure'
                  ],

                  value: q173AfterTherapy,

                  onChanged: (v) =>
                      setState(() =>
                          q173AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "17.4",
                  "Did you experience nausea before treatment?",
                  q174BeforeTherapy,
                  (v) => setState(() =>
                      q174BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "17.5",

                  question:
                      "Did nausea improve after stopping/reducing medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q175Improved,

                  onChanged: (v) =>
                      setState(() =>
                          q175Improved = v),
                ),

                _buildRadioQuestion(

                  number: "17.6",

                  question:
                      "Did nausea return after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q176Restarted,

                  onChanged: (v) =>
                      setState(() =>
                          q176Restarted = v),
                ),

                _buildYesNoQuestion(
                  "17.7",
                  "Have you recently changed your diet?",
                  q177Diet,
                  (v) => setState(() =>
                      q177Diet = v),
                ),

                _buildYesNoQuestion(
                  "17.8",
                  "Are you taking any other medications that may cause nausea?",
                  q178OtherMeds,
                  (v) => setState(() =>
                      q178OtherMeds = v),
                ),
              ],

              /// ================= 18 =================

              _buildRadioQuestion(

                number: "18",

                question:
                    "Have you experienced vomiting since starting the treatment?",

                options: [
                  'Yes',
                  'No',
                  'Not sure'
                ],

                value: q18Answer,

                onChanged: (v) =>
                    setState(() => q18Answer = v),
              ),

              if (q18Answer == 'Yes') ...[

                _buildTextField(

                  label:
                      "Duration (weeks)",

                  controller: q18Duration,
                ),

                _buildRadioQuestion(

                  number: "18.1",

                  question:
                      "Highest number of vomiting episodes in 24 hours?",

                  options: [

                    'Mild – 1–2 episodes in 24 hours',

                    'Moderate – 3–5 episodes in 24 hours',

                    'Severe – 6 or more episodes in 24 hours or required medical attention',

                    'Life-threatening – Required urgent medical intervention',
                  ],

                  value: q181Severity,

                  onChanged: (v) =>
                      setState(() =>
                          q181Severity = v),
                ),

                _buildRadioQuestion(

                  number: "18.2",

                  question:
                      "Did vomiting begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure'
                  ],

                  value: q182AfterTherapy,

                  onChanged: (v) =>
                      setState(() =>
                          q182AfterTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "18.3",

                  question:
                      "Did vomiting improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q183Improved,

                  onChanged: (v) =>
                      setState(() =>
                          q183Improved = v),
                ),

                _buildRadioQuestion(

                  number: "18.4",

                  question:
                      "Did vomiting recur after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q184Restarted,

                  onChanged: (v) =>
                      setState(() =>
                          q184Restarted = v),
                ),

                _buildYesNoQuestion(
                  "18.5",
                  "Are you taking any other medications that may cause vomiting?",
                  q185OtherMeds,
                  (v) => setState(() =>
                      q185OtherMeds = v),
                ),
              ],

              /// ================= 19 =================

              _buildRadioQuestion(

                number: "19",

                question:
                    "Have you experienced abdominal pain since starting treatment?",

                options: ['Yes', 'No'],

                value: q19Answer,

                onChanged: (v) =>
                    setState(() => q19Answer = v),
              ),

              if (q19Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "19.1",

                  question:
                      "How severe is the abdominal pain?",

                  options: [

                    'Mild – Present but does not interfere with daily activities',

                    'Moderate – Interferes with routine daily activities',

                    'Severe – Interferes with self-care activities or requires medical attention',
                  ],

                  value: q191Severity,

                  onChanged: (v) =>
                      setState(() =>
                          q191Severity = v),
                ),

                _buildTextField(

                  label:
                      "19.2 Duration (weeks)",

                  controller: q192Duration,
                ),

                _buildRadioQuestion(

                  number: "19.3",

                  question:
                      "Did abdominal pain begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure'
                  ],

                  value: q193AfterTherapy,

                  onChanged: (v) =>
                      setState(() =>
                          q193AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "19.4",
                  "Did you have abdominal pain before treatment?",
                  q194BeforeTherapy,
                  (v) => setState(() =>
                      q194BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "19.5",

                  question:
                      "Did pain improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q195Improved,

                  onChanged: (v) =>
                      setState(() =>
                          q195Improved = v),
                ),

                _buildRadioQuestion(

                  number: "19.6",

                  question:
                      "Did pain return after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q196Restarted,

                  onChanged: (v) =>
                      setState(() =>
                          q196Restarted = v),
                ),

                _buildYesNoQuestion(
                  "19.7",
                  "History of GI conditions?",
                  q197History,
                  (v) => setState(() =>
                      q197History = v),
                ),

                _buildYesNoQuestion(
                  "19.8",
                  "Recent significant stressful event?",
                  q198Stress,
                  (v) => setState(() =>
                      q198Stress = v),
                ),
              ],

              /// ================= 20 =================

              _buildRadioQuestion(

                number: "20",

                question:
                    "Have you experienced constipation since starting treatment?",

                options: ['Yes', 'No'],

                value: q20Answer,

                onChanged: (v) =>
                    setState(() => q20Answer = v),
              ),

              if (q20Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "20.1",

                  question:
                      "How severe is your constipation?",

                  options: [

                    'Mild – Occasional symptoms',

                    'Moderate – Persistent symptoms interfering with activities',

                    'Severe – Requires manual evacuation',

                    'Life-threatening – Required urgent intervention',
                  ],

                  value: q201Severity,

                  onChanged: (v) =>
                      setState(() =>
                          q201Severity = v),
                ),

                _buildTextField(

                  label:
                      "20.2 Duration (weeks)",

                  controller: q202Duration,
                ),

                _buildRadioQuestion(

                  number: "20.3",

                  question:
                      "Did constipation begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure'
                  ],

                  value: q203AfterTherapy,

                  onChanged: (v) =>
                      setState(() =>
                          q203AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "20.4",
                  "Did you have constipation before treatment?",
                  q204BeforeTherapy,
                  (v) => setState(() =>
                      q204BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "20.5",

                  question:
                      "Did constipation improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q205Improved,

                  onChanged: (v) =>
                      setState(() =>
                          q205Improved = v),
                ),

                _buildRadioQuestion(

                  number: "20.6",

                  question:
                      "Did constipation return after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q206Restarted,

                  onChanged: (v) =>
                      setState(() =>
                          q206Restarted = v),
                ),
              ],

              /// ================= 21 =================

              _buildRadioQuestion(

                number: "21",

                question:
                    "Have you experienced diarrhea since starting treatment?",

                options: ['Yes', 'No'],

                value: q21Answer,

                onChanged: (v) =>
                    setState(() => q21Answer = v),
              ),

              if (q21Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "21.1",

                  question:
                      "Highest increase in stools/day?",

                  options: [

                    'Mild – Fewer than 4 additional stools/day',

                    'Moderate – 4 to 6 additional stools/day',

                    'Severe – 7 or more additional stools/day or hospitalization',

                    'Life-threatening – Required urgent intervention',
                  ],

                  value: q211Severity,

                  onChanged: (v) =>
                      setState(() =>
                          q211Severity = v),
                ),

                _buildTextField(

                  label:
                      "21.2 Duration (weeks)",

                  controller: q212Duration,
                ),

                _buildRadioQuestion(

                  number: "21.3",

                  question:
                      "Did diarrhea begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure'
                  ],

                  value: q213AfterTherapy,

                  onChanged: (v) =>
                      setState(() =>
                          q213AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "21.4",
                  "Did you have diarrhea before treatment?",
                  q214BeforeTherapy,
                  (v) => setState(() =>
                      q214BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "21.5",

                  question:
                      "Did diarrhea improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q215Improved,

                  onChanged: (v) =>
                      setState(() =>
                          q215Improved = v),
                ),

                _buildRadioQuestion(

                  number: "21.6",

                  question:
                      "Did diarrhea return after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q216Restarted,

                  onChanged: (v) =>
                      setState(() =>
                          q216Restarted = v),
                ),
              ],

              /// ================= 22 =================

              _buildRadioQuestion(

                number: "22",

                question:
                    "Have you experienced symptoms of gastritis?",

                options: ['Yes', 'No'],

                value: q22Answer,

                onChanged: (v) =>
                    setState(() => q22Answer = v),
              ),

              if (q22Answer == 'Yes') ...[

                _buildRadioQuestion(

                  number: "22.1",

                  question:
                      "How severe were the gastritis symptoms?",

                  options: [

                    'Asymptomatic – Detected only on examination',

                    'Mild to Moderate – Symptoms present; medical treatment required',

                    'Severe – Significant difficulty eating or maintaining nutrition',

                    'Life-threatening – Required urgent intervention',
                  ],

                  value: q221Severity,

                  onChanged: (v) =>
                      setState(() =>
                          q221Severity = v),
                ),

                _buildTextField(

                  label:
                      "22.2 Duration (weeks)",

                  controller: q222Duration,
                ),

                _buildRadioQuestion(

                  number: "22.3",

                  question:
                      "Did symptoms begin after medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not sure'
                  ],

                  value: q223AfterTherapy,

                  onChanged: (v) =>
                      setState(() =>
                          q223AfterTherapy = v),
                ),

                _buildYesNoQuestion(
                  "22.4",
                  "Did you have similar symptoms before treatment?",
                  q224BeforeTherapy,
                  (v) => setState(() =>
                      q224BeforeTherapy = v),
                ),

                _buildRadioQuestion(

                  number: "22.5",

                  question:
                      "Did symptoms improve after stopping medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q225Improved,

                  onChanged: (v) =>
                      setState(() =>
                          q225Improved = v),
                ),

                _buildRadioQuestion(

                  number: "22.6",

                  question:
                      "Did symptoms return after restarting medication?",

                  options: [
                    'Yes',
                    'No',
                    'Not applicable'
                  ],

                  value: q226Restarted,

                  onChanged: (v) =>
                      setState(() =>
                          q226Restarted = v),
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

        backgroundColor: Colors.blue[600],

        foregroundColor: Colors.white,

        label:
            const Text("Save & Next System"),

        onPressed: () async {

          final saved =
              await _saveGastrointestinal();

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

      Future<bool> _saveGastrointestinal() async {

  List<Map<String, String>> symptoms = [];

  /// ================= Q17 NAUSEA =================

  if (q17Answer == 'Yes') {

    symptoms.add({
      'name': 'Nausea',
      'severity': _mapSeverity(q171Severity),
      'duration': q172Duration.text,
    });

    

    if (q173AfterTherapy == 'Yes') {
      symptoms.add({
        'name': 'Nausea after medication',
        'severity': 'N/A',
      });
    }

    if (q174BeforeTherapy == 'Yes') {
      symptoms.add({
        'name': 'Nausea before treatment',
        'severity': 'N/A',
      });
    }

    if (q175Improved == 'Yes') {
      symptoms.add({
        'name': 'Nausea improved after stopping medication',
        'severity': 'N/A',
      });
    }

    if (q176Restarted == 'Yes') {
      symptoms.add({
        'name': 'Nausea restarted after rechallenge',
        'severity': 'N/A',
      });
    }

    if (q177Diet == 'Yes') {
      symptoms.add({
        'name': 'Recent diet change',
        'severity': 'N/A',
      });
    }

    if (q178OtherMeds == 'Yes') {
      symptoms.add({
        'name': 'Other nausea-causing medications',
        'severity': 'N/A',
      });
    }
  }

  /// ================= Q18 VOMITING =================

  if (q18Answer == 'Yes') {

    symptoms.add({
      'name': 'Vomiting',
      'severity': _mapSeverity(q181Severity),
      'duration': q18Duration.text,
    });

   

    if (q182AfterTherapy == 'Yes') {
      symptoms.add({
        'name': 'Vomiting after medication ',
        'severity': 'N/A',
      });
    }

    if (q183Improved == 'Yes') {
      symptoms.add({
        'name': 'Vomiting improved after stopping medication',
        'severity': 'N/A',
      });
    }

    if (q184Restarted == 'Yes') {
      symptoms.add({
        'name': 'Vomiting restarted after rechallenge',
        'severity': 'N/A',
      });
    }

    if (q185OtherMeds == 'Yes') {
      symptoms.add({
        'name': 'Other vomiting-causing medications',
        'severity': 'N/A',
      });
    }
  }

  /// ================= Q19 ABDOMINAL PAIN =================

  if (q19Answer == 'Yes') {

    symptoms.add({
      'name': 'Abdominal pain',
      'severity': _mapSeverity(q191Severity),
      'duration': q192Duration.text,
    });

    

    if (q193AfterTherapy == 'Yes') {
      symptoms.add({
        'name': 'Abdominal pain after medication',
        'severity': 'N/A',
      });
    }

    if (q194BeforeTherapy == 'Yes') {
      symptoms.add({
        'name': 'Abdominal pain before treatment',
        'severity': 'N/A',
      });
    }

    if (q195Improved == 'Yes') {
      symptoms.add({
        'name': 'Abdominal pain improved after stopping medication',
        'severity': 'N/A',
      });
    }

    if (q196Restarted == 'Yes') {
      symptoms.add({
        'name': 'Abdominal pain restarted after rechallenge',
        'severity': 'N/A',
      });
    }

    if (q197History == 'Yes') {
      symptoms.add({
        'name': 'History of GI disease',
        'severity': 'N/A',
      });
    }

    if (q198Stress == 'Yes') {
      symptoms.add({
        'name': 'Recent stressful event',
        'severity': 'N/A',
      });
    }
  }

  /// ================= Q20 CONSTIPATION =================

  if (q20Answer == 'Yes') {

    symptoms.add({
      'name': 'Constipation',
      'severity': _mapSeverity(q201Severity),
      'duration': q202Duration.text,
    });

   

    if (q203AfterTherapy == 'Yes') {
      symptoms.add({
        'name': 'Constipation after medication',
        'severity': 'N/A',
      });
    }

    if (q204BeforeTherapy == 'Yes') {
      symptoms.add({
        'name': 'Constipation before treatment',
        'severity': 'N/A',
      });
    }

    if (q205Improved == 'Yes') {
      symptoms.add({
        'name': 'Constipation improved after stopping medication',
        'severity': 'N/A',
      });
    }

    if (q206Restarted == 'Yes') {
      symptoms.add({
        'name': 'Constipation restarted after rechallenge',
        'severity': 'N/A',
      });
    }
  }

  /// ================= Q21 DIARRHEA =================

  if (q21Answer == 'Yes') {

    symptoms.add({
      'name': 'Diarrhea',
      'severity': _mapSeverity(q211Severity),
    });

 

    if (q213AfterTherapy == 'Yes') {
      symptoms.add({
        'name': 'Diarrhea after medication',
        'severity': 'N/A',
      });
    }

    if (q214BeforeTherapy == 'Yes') {
      symptoms.add({
        'name': 'Diarrhea before treatment',
        'severity': 'N/A',
      });
    }

    if (q215Improved == 'Yes') {
      symptoms.add({
        'name': 'Diarrhea improved after stopping medication',
        'severity': 'N/A',
      });
    }

    if (q216Restarted == 'Yes') {
      symptoms.add({
        'name': 'Diarrhea restarted after rechallenge',
        'severity': 'N/A',
      });
    }
  }

  /// ================= Q22 GASTRITIS =================

  if (q22Answer == 'Yes') {

    symptoms.add({
      'name': 'Gastritis',
      'severity': _mapSeverity(q221Severity),
    });

    

    if (q223AfterTherapy == 'Yes') {
      symptoms.add({
        'name': 'Gastritis after medication',
        'severity': 'N/A',
      });
    }

    if (q224BeforeTherapy == 'Yes') {
      symptoms.add({
        'name': 'Gastritis before treatment',
        'severity': 'N/A',
      });
    }

    if (q225Improved == 'Yes') {
      symptoms.add({
        'name': 'Gastritis improved after stopping medication',
        'severity': 'N/A',
      });
    }

    if (q226Restarted == 'Yes') {
      symptoms.add({
        'name': 'Gastritis restarted after rechallenge',
        'severity': 'N/A',
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
          "GASTROINTESTINAL SYSTEM",

      symptomName: s['name']!,

      symptomPresent: "Yes",

      severity: s['severity']!,
     durationWeeks:
    int.tryParse(s['duration'] ?? ''),
      regimenType: "SLD",
    );
  }

  return true;
}
       /// ================= SEVERITY =================

  String _mapSeverity(String? value) {

    if (value == null) return 'moderate';

    final lower = value.toLowerCase();

    if (lower.contains('mild') ||
        lower.contains('grade 1')) {
      return 'mild';
    }

    if (lower.contains('moderate') ||
        lower.contains('grade 2')) {
      return 'moderate';
    }

    if (lower.contains('severe') ||
        lower.contains('grade 3')) {
      return 'severe';
    }

    if (lower.contains('life-threatening') ||
        lower.contains('grade 4')) {
      return 'life threatening';
    }

    if (lower.contains('asymptomatic') ||
        lower.contains('grade 0')) {
      return 'asymptomatic';
    }

    return 'moderate';
  }
  Widget _buildRadioQuestion({
    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String) onChanged,
  }) {

    return Card(

      margin:
          const EdgeInsets.only(bottom: 16),

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

                  color: Colors.black,

                  fontWeight: FontWeight.bold,

                  fontSize: 16,
                ),

                children: const [

                  TextSpan(

                    text: " *",

                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            ...options.map(

              (e) => RadioListTile<String>(

                value: e,

                groupValue: value,

                title: Text(e),

                onChanged: (v) =>
                    onChanged(v!),
              ),
            ),
          ],
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
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(bottom: 16),

      child: TextField(

        controller: controller,

        keyboardType: TextInputType.number,

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
}