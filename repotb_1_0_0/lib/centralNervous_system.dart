import 'package:flutter/material.dart';
import 'systems_api.dart';

class CentralnervousSystemScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const CentralnervousSystemScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<CentralnervousSystemScreen> createState() => _CentralnervousSystemScreenState();
}

class _CentralnervousSystemScreenState extends State<CentralnervousSystemScreen> {

String normalizeSeverity(String? input) {
  if (input == null) return "mild";

  final val = input.toLowerCase();
  if (val.contains("life")) return "life-threatening";
  if (val.contains("mild")) return "mild";
  if (val.contains("moderate")) return "moderate";
  if (val.contains("severe")) return "severe";

  return "mild"; // fallback
}

  // Numbness/Tingling (8-8.8)
  String? q8Answer;        
  String? q81Answer;       
  String? q82Weeks;
  String? q83Answer;       
  String? q84Answer;       
  String? q85Answer;       
  String? q86Answer;       
  String? q87PreExisting;
  String? q88NewActivity;

  // Headaches (9-9.6)
  String? q9Answer;        
  String? q91Answer;       
  String? q92Weeks;
  String? q93Answer;       
  String? q94Answer;       
  String? q95Answer;       
  String? q96Answer;       

  // Seizures (10-10.7)
  String? q10Answer;       
  String? q101Answer;      
  String? q102Weeks;
  String? q103Episodes;
  String? q104Answer;      
  String? q105History;
  String? q106Answer;      
  String? q107Answer;      

  bool get showNumbness => q8Answer == 'Yes';
  bool get showHeadaches => q9Answer == 'Yes';
  bool get showSeizures => q10Answer == 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 8. NUMBNESS/TINGLING
              _buildRadioQuestion(
                number: "8",
                question: "Have you experienced numbness, tingling, or a burning sensation in your hands or feet since starting the treatment?",
                options: ['Yes', 'No'],
                value: q8Answer,
                onChanged: (val) => setState(() => q8Answer = val),
              ),
              if (showNumbness) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "8.1",
                  question: "How severe is the condition?",
                  options: [
                    'Mild / Asymptomatic - No symptoms or only mild symptoms; detected clinically or on investigations; does not interfere with daily activities',
                    'Moderate - Symptoms interfere with daily activities and require medical treatment',
                    'Severe - Marked limitation of daily functioning; hospitalization or intensive treatment required',
                    'Life threatening - Life threatening consequences; urgent medical intervention required'
                  ],
                  value: q81Answer,
                  onChanged: (val) => setState(() => q81Answer = val),
                ),
                _buildNumericQuestion(number: "8.2", question: "How long have you had these symptoms (in weeks)?", value: q82Weeks, onChanged: (val) => setState(() => q82Weeks = val)),
                _buildRadioQuestion(number: "8.3", question: "Did these symptoms begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q83Answer, onChanged: (val) => setState(() => q83Answer = val)),
                _buildRadioQuestion(number: "8.4", question: "Did you have similar symptoms before starting treatment?", options: ['Yes', 'No'], value: q84Answer, onChanged: (val) => setState(() => q84Answer = val)),
                _buildRadioQuestion(number: "8.5", question: "Did the symptoms improve after stopping or reducing the medication or after receiving treatment (e.g., vitamin supplementation)?", options: ['Yes', 'No', 'Not applicable'], value: q85Answer, onChanged: (val) => setState(() => q85Answer = val)),
                _buildRadioQuestion(number: "8.6", question: "Did the symptoms return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q86Answer, onChanged: (val) => setState(() => q86Answer = val)),
                _buildRadioQuestion(number: "8.7", question: "Do you have any pre-existing conditions such as diabetes or known peripheral neuropathy?", options: ['Yes', 'No'], value: q87PreExisting, onChanged: (val) => setState(() => q87PreExisting = val)),
                _buildRadioQuestion(number: "8.8", question: "Have you recently started any new physical activities or sustained any injury that could explain these symptoms?", options: ['Yes', 'No'], value: q88NewActivity, onChanged: (val) => setState(() => q88NewActivity = val)),
              ],

              // 9. HEADACHES
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "9",
                question: "Have you experienced headaches since starting the treatment?",
                options: ['Yes', 'No'],
                value: q9Answer,
                onChanged: (val) => setState(() => q9Answer = val),
              ),
              if (showHeadaches) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "9.1",
                  question: "How severe is the headache?",
                  options: [
                    'Mild - Present but does not interfere with daily activities',
                    'Moderate - Interferes with routine daily activities (e.g., work, household tasks)',
                    'Severe - Interferes with self-care activities (e.g., bathing, dressing) or requires medical attention'
                  ],
                  value: q91Answer,
                  onChanged: (val) => setState(() => q91Answer = val),
                ),
                _buildNumericQuestion(number: "9.2", question: "How long have you had the headache (in weeks)?", value: q92Weeks, onChanged: (val) => setState(() => q92Weeks = val)),
                _buildRadioQuestion(number: "9.3", question: "Did the headache begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q93Answer, onChanged: (val) => setState(() => q93Answer = val)),
                _buildRadioQuestion(number: "9.4", question: "Did you experience similar headaches before starting treatment?", options: ['Yes', 'No'], value: q94Answer, onChanged: (val) => setState(() => q94Answer = val)),
                _buildRadioQuestion(number: "9.5", question: "Did the headache improve after stopping or reducing the medication?", options: ['Yes', 'No', 'Not applicable'], value: q95Answer, onChanged: (val) => setState(() => q95Answer = val)),
                _buildRadioQuestion(number: "9.6", question: "Did the headache return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q96Answer, onChanged: (val) => setState(() => q96Answer = val)),
              ],

              // 10. SEIZURES
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "10",
                question: "Have you experienced any seizures (fits or convulsions) since starting the treatment?",
                options: ['Yes', 'No'],
                value: q10Answer,
                onChanged: (val) => setState(() => q10Answer = val),
              ),
              if (showSeizures) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "10.1",
                  question: "What was the most severe seizure episode experienced?",
                  options: [
                    'Mild - Brief partial seizure without loss of consciousness',
                    'Moderate - Brief generalized seizure',
                    'Severe - New-onset seizure (partial or generalized) or multiple seizures despite medical treatment',
                    'Life threatening - Prolonged or repeated seizures requiring urgent medical intervention'
                  ],
                  value: q101Answer,
                  onChanged: (val) => setState(() => q101Answer = val),
                ),
                _buildNumericQuestion(number: "10.2", question: "When did the seizure first occur (weeks after starting treatment)?", value: q102Weeks, onChanged: (val) => setState(() => q102Weeks = val)),
                _buildNumericQuestion(number: "10.3", question: "Number of seizure episodes:", value: q103Episodes, onChanged: (val) => setState(() => q103Episodes = val)),
                _buildRadioQuestion(number: "10.4", question: "Did the seizure occur after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q104Answer, onChanged: (val) => setState(() => q104Answer = val)),
                _buildRadioQuestion(number: "10.5", question: "Did you have a history of seizures before starting treatment?", options: ['Yes', 'No'], value: q105History, onChanged: (val) => setState(() => q105History = val)),
                _buildRadioQuestion(number: "10.6", question: "Did seizures stop or improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q106Answer, onChanged: (val) => setState(() => q106Answer = val)),
                _buildRadioQuestion(number: "10.7", question: "Did seizures recur after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q107Answer, onChanged: (val) => setState(() => q107Answer = val)),
              ],
              
              const SizedBox(height: 100), // Space for buttons
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        label: const Text(
          'Save & Next System', 
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        heroTag: "save_cns_next",
        onPressed: _isComplete() 
            ? () {
                _saveCentralNervousSystem();
                widget.onSaveAndComplete();
              } 
            : null,
      ),
    );
  }

  // ✅ SAME BUILDER METHODS (unchanged)
  Widget _buildRadioQuestion({
    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String) onChanged,
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
            Text("$number. $question", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...options.map((option) => RadioListTile<String>(
              title: Text(option, style: const TextStyle(fontSize: 14)),
              value: option,
              groupValue: value,
              onChanged: (val) => onChanged(val ?? ''),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericQuestion({
    required String number,
    required String question,
    required String? value,
    required Function(String) onChanged,
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
            Text("$number. $question", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              initialValue: value,
              decoration: InputDecoration(
                hintText: "Enter number (e.g., 4)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isComplete() {
    // Main questions must be answered
    if (q8Answer == null || q9Answer == null || q10Answer == null) {
      return false;
    }
    
    // Check follow-ups for Yes answers
    if (showNumbness && (q81Answer == null || q82Weeks == null || q83Answer == null || q84Answer == null || q85Answer == null || q86Answer == null || q87PreExisting == null || q88NewActivity == null)) return false;
    if (showHeadaches && (q91Answer == null || q92Weeks == null || q93Answer == null || q94Answer == null || q95Answer == null || q96Answer == null)) return false;
    if (showSeizures && (q101Answer == null || q102Weeks == null || q103Episodes == null || q104Answer == null || q105History == null || q106Answer == null || q107Answer == null)) return false;
    
    return true;
  }

  // ✅ FIXED: Complete save implementation matching Respiratory
  void _saveCentralNervousSystem() async {
    print('🔥 CNS SAVE - reportId: ${widget.reportId}');
    
    List<Map<String, String>> yesSymptoms = [];
    int savedCount = 0;

    // 8. NUMBNESS/TINGLING
    if (q8Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Numbness/tingling in hands/feet',
        'severity': q81Answer ?? 'Moderate',
        'extra': q82Weeks ?? '',
      });
      
      // Follow-up Yes answers
      if (q83Answer == 'Yes') yesSymptoms.add({'name': 'Numbness after medication', 'severity': 'Post-medication onset', 'extra': ''});
      if (q84Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing numbness', 'severity': 'Pre-existing condition', 'extra': ''});
      if (q85Answer == 'Yes') yesSymptoms.add({'name': 'Numbness improved after stopping', 'severity': 'De-challenged', 'extra': ''});
      if (q86Answer == 'Yes') yesSymptoms.add({'name': 'Numbness returned after restart', 'severity': 'Re-challenged', 'extra': ''});
      if (q87PreExisting == 'Yes') yesSymptoms.add({'name': 'Pre-existing diabetes/neuropathy', 'severity': 'Comorbidity', 'extra': ''});
      if (q88NewActivity == 'Yes') yesSymptoms.add({'name': 'Recent activity/injury causing numbness', 'severity': 'Environmental trigger', 'extra': ''});
    }

    // 9. HEADACHES
    if (q9Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Headaches',
        'severity': q91Answer ?? 'Moderate',
        'extra': q92Weeks ?? '',
      });
      
      if (q93Answer == 'Yes') yesSymptoms.add({'name': 'Headache after medication', 'severity': 'Post-medication onset', 'extra': ''});
      if (q94Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing headaches', 'severity': 'Pre-existing condition', 'extra': ''});
      if (q95Answer == 'Yes') yesSymptoms.add({'name': 'Headache improved after stopping', 'severity': 'De-challenged', 'extra': ''});
      if (q96Answer == 'Yes') yesSymptoms.add({'name': 'Headache returned after restart', 'severity': 'Re-challenged', 'extra': ''});
    }

    // 10. SEIZURES
    if (q10Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Seizures',
        'severity': q101Answer ?? 'Severe',
        'extra': '${q102Weeks ?? ''} weeks, ${q103Episodes ?? '0'} episodes',
      });
      
      if (q104Answer == 'Yes') yesSymptoms.add({'name': 'Seizure after medication', 'severity': 'Post-medication onset', 'extra': ''});
      if (q105History == 'Yes') yesSymptoms.add({'name': 'Pre-existing seizure history', 'severity': 'Pre-existing condition', 'extra': ''});
      if (q106Answer == 'Yes') yesSymptoms.add({'name': 'Seizures improved after stopping', 'severity': 'De-challenged', 'extra': ''});
      if (q107Answer == 'Yes') yesSymptoms.add({'name': 'Seizures returned after restart', 'severity': 'Re-challenged', 'extra': ''});
    }

    print('📦 Saving ${yesSymptoms.length} "Yes" symptoms');

    // Save each Yes symptom to API
    for (var symptom in yesSymptoms) {
      try {
        bool success = await SystemsApi.saveSymptom(
          reportId: widget.reportId,
          questionnaireSystem: "CENTRAL NERVOUS SYSTEM",
          symptomName: symptom['name']!,
          symptomPresent: "Yes",
          severity: normalizeSeverity(symptom['severity']),
        );
        print('✅ ${symptom['name']}: $success');
        if (success) savedCount++;
      } catch (e) {
        print('❌ ${symptom['name']}: $e');
      }
    }

    _showSaveMessage(savedCount);
  }

  void _showSaveMessage(int savedCount) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(savedCount > 0 
            ? '✅ Saved $savedCount CNS symptoms' 
            : 'ℹ️ No symptoms to save (only "Yes" answers are saved)'
          ),
          backgroundColor: savedCount > 0 ? Colors.green : Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}