import 'package:flutter/material.dart';
import 'systems_api.dart'; 

class GastrointestinalScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const GastrointestinalScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<GastrointestinalScreen> createState() => _GastrointestinalScreenState();
}

class _GastrointestinalScreenState extends State<GastrointestinalScreen> {
  // Nausea (2-2.8)
  String? q2Answer;       // Yes/No
  String? q21Answer;      // Severity
  String? q22Weeks;
  String? q23Answer;      // Yes/No/Not sure
  String? q24Answer;      // Yes/No
  String? q25Answer;      // Yes/No/Not applicable
  String? q26Answer;      // Yes/No/Not applicable
  String? q27Diet;
  String? q28OtherMeds;
  
  // Vomiting (3-3.5)
  String? q3Answer;       // Yes/No/Not sure
  String? q3Duration;
  String? q31Answer;      // Severity
  String? q32Answer;      // Yes/No/Not sure
  String? q33Answer;      // Yes/No/Not applicable
  String? q34Answer;      // Yes/No/Not applicable
  String? q35OtherMeds;
  
  // Abdominal Pain (4-4.8)
  String? q4Answer;       // Yes/No
  String? q41Answer;      // Severity
  String? q42Weeks;
  String? q43Answer;      // Yes/No/Not sure
  String? q44Answer;      // Yes/No
  String? q45Answer;      // Yes/No/Not applicable
  String? q46Answer;      // Yes/No/Not applicable
  String? q47GIHistory;
  String? q48Stress;
  
  // Constipation (5-5.6)
  String? q5Answer;       // Yes/No
  String? q51Answer;      // Severity
  String? q52Weeks;
  String? q53Answer;      // Yes/No/Not sure
  String? q54Answer;      // Yes/No
  String? q55Answer;      // Yes/No/Not applicable
  String? q56Answer;      // Yes/No/Not applicable
  
  // Diarrhea (6-6.6)
  String? q6Answer;       // Yes/No
  String? q61Answer;      // Severity
  String? q62Weeks;
  String? q63Answer;      // Yes/No/Not sure
  String? q64Answer;      // Yes/No
  String? q65Answer;      // Yes/No/Not applicable
  String? q66Answer;      // Yes/No/Not applicable
  
  // Gastritis (7-7.6)
  String? q7Answer;       // Yes/No
  String? q71Answer;      // Severity
  String? q72Weeks;
  String? q73Answer;      // Yes/No/Not sure
  String? q74Answer;      // Yes/No
  String? q75Answer;      // Yes/No/Not applicable
  String? q76Answer;      // Yes/No/Not applicable

  bool get showNausea => q2Answer == 'Yes';
  bool get showVomiting => q3Answer == 'Yes';
  bool get showAbdominal => q4Answer == 'Yes';
  bool get showConstipation => q5Answer == 'Yes';
  bool get showDiarrhea => q6Answer == 'Yes';
  bool get showGastritis => q7Answer == 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. NAUSEA
              _buildRadioQuestion(
                number: "2",
                question: "Have you experienced nausea (a feeling of wanting to vomit) since starting the treatment?",
                options: ['Yes', 'No'],
                value: q2Answer,
                onChanged: (val) => setState(() => q2Answer = val),
              ),
              if (showNausea) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "2.1",
                  question: "How severe is your nausea?",
                  options: [
                    'Mild – Loss of appetite but eating habits are unchanged',
                    'Moderate – Reduced oral intake without significant weight loss, dehydration, or malnutrition',
                    'Severe – Unable to maintain adequate food or fluid intake; required medical support or hospitalization'
                  ],
                  value: q21Answer,
                  onChanged: (val) => setState(() => q21Answer = val),
                ),
                _buildNumericQuestion(number: "2.2", question: "How long have you had nausea (in weeks)?", value: q22Weeks, onChanged: (val) => setState(() => q22Weeks = val)),
                _buildRadioQuestion(number: "2.3", question: "Did the nausea begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q23Answer, onChanged: (val) => setState(() => q23Answer = val)),
                _buildRadioQuestion(number: "2.4", question: "Did you experience nausea before starting treatment?", options: ['Yes', 'No'], value: q24Answer, onChanged: (val) => setState(() => q24Answer = val)),
                _buildRadioQuestion(number: "2.5", question: "Did the nausea improve after stopping/reducing the medication or after you received treatment for it?", options: ['Yes', 'No', 'Not applicable'], value: q25Answer, onChanged: (val) => setState(() => q25Answer = val)),
                _buildRadioQuestion(number: "2.6", question: "Did the nausea return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q26Answer, onChanged: (val) => setState(() => q26Answer = val)),
                _buildRadioQuestion(number: "2.7", question: "Have you recently changed your diet?", options: ['Yes', 'No'], value: q27Diet, onChanged: (val) => setState(() => q27Diet = val)),
                _buildRadioQuestion(number: "2.8", question: "Are you taking any other medications that may cause nausea?", options: ['Yes', 'No'], value: q28OtherMeds, onChanged: (val) => setState(() => q28OtherMeds = val)),
              ],
              
              // 3. VOMITING
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "3",
                question: "Have you experienced vomiting since starting the treatment?",
                options: ['Yes', 'No', 'Not sure'],
                value: q3Answer,
                onChanged: (val) => setState(() => q3Answer = val),
              ),
              if (showVomiting) ...[
                _buildNumericQuestion(number: "3a", question: "Duration (in weeks)", value: q3Duration, onChanged: (val) => setState(() => q3Duration = val)),
                _buildRadioQuestion(
                  number: "3.1",
                  question: "What was the highest number of vomiting episodes in a 24-hour period?",
                  options: [
                    'Mild – 1–2 episodes in 24 hours',
                    'Moderate – 3–5 episodes in 24 hours',
                    'Severe – 6 or more episodes in 24 hours or required medical attention',
                    'Life-threatening – Required urgent medical intervention'
                  ],
                  value: q31Answer,
                  onChanged: (val) => setState(() => q31Answer = val),
                ),
                _buildRadioQuestion(number: "3.2", question: "Did the vomiting begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q32Answer, onChanged: (val) => setState(() => q32Answer = val)),
                _buildRadioQuestion(number: "3.3", question: "Did it improve after stopping or adjusting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q33Answer, onChanged: (val) => setState(() => q33Answer = val)),
                _buildRadioQuestion(number: "3.4", question: "Did it recur after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q34Answer, onChanged: (val) => setState(() => q34Answer = val)),
                _buildRadioQuestion(number: "3.5", question: "Are you taking any other medications that may cause vomiting?", options: ['Yes', 'No'], value: q35OtherMeds, onChanged: (val) => setState(() => q35OtherMeds = val)),
              ],

              // 4. ABDOMINAL PAIN
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "4",
                question: "Have you experienced abdominal (stomach) pain since starting the treatment?",
                options: ['Yes', 'No'],
                value: q4Answer,
                onChanged: (val) => setState(() => q4Answer = val),
              ),
              if (showAbdominal) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "4.1",
                  question: "How severe is the abdominal pain?",
                  options: [
                    'Mild – Present but does not interfere with daily activities',
                    'Moderate – Interferes with routine daily activities (e.g., cooking, shopping, work)',
                    'Severe – Interferes with self-care activities (e.g., bathing, dressing) or requires medical attention'
                  ],
                  value: q41Answer,
                  onChanged: (val) => setState(() => q41Answer = val),
                ),
                _buildNumericQuestion(number: "4.2", question: "How long have you had this abdominal pain (in weeks)?", value: q42Weeks, onChanged: (val) => setState(() => q42Weeks = val)),
                _buildRadioQuestion(number: "4.3", question: "Did the abdominal pain begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q43Answer, onChanged: (val) => setState(() => q43Answer = val)),
                _buildRadioQuestion(number: "4.4", question: "Did you have similar abdominal pain before starting treatment?", options: ['Yes', 'No'], value: q44Answer, onChanged: (val) => setState(() => q44Answer = val)),
                _buildRadioQuestion(number: "4.5", question: "Did the pain improve after stopping or reducing the medication?", options: ['Yes', 'No', 'Not applicable'], value: q45Answer, onChanged: (val) => setState(() => q45Answer = val)),
                _buildRadioQuestion(number: "4.6", question: "Did the pain return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q46Answer, onChanged: (val) => setState(() => q46Answer = val)),
                _buildRadioQuestion(number: "4.7", question: "Do you have a history of gastrointestinal conditions such as ulcers, gastritis, or irritable bowel syndrome (IBS)?", options: ['Yes', 'No'], value: q47GIHistory, onChanged: (val) => setState(() => q47GIHistory = val)),
                _buildRadioQuestion(number: "4.8", question: "Have you recently experienced significant stressful event?", options: ['Yes', 'No'], value: q48Stress, onChanged: (val) => setState(() => q48Stress = val)),
              ],

              // 5. CONSTIPATION
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "5",
                question: "Have you experienced constipation (difficulty passing stools or infrequent bowel movements) since starting the treatment?",
                options: ['Yes', 'No'],
                value: q5Answer,
                onChanged: (val) => setState(() => q5Answer = val),
              ),
              if (showConstipation) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "5.1",
                  question: "How severe is your constipation?",
                  options: [
                    'Mild – Occasional symptoms; occasional use of stool softeners, laxatives, dietary changes, or enema',
                    'Moderate – Persistent symptoms requiring regular use of laxatives or enemas; interferes with routine daily activities',
                    'Severe – Severe constipation requiring manual evacuation; interferes with self-care activities',
                    'Life-threatening – Required urgent medical intervention'
                  ],
                  value: q51Answer,
                  onChanged: (val) => setState(() => q51Answer = val),
                ),
                _buildNumericQuestion(number: "5.2", question: "How long have you had constipation (in weeks)?", value: q52Weeks, onChanged: (val) => setState(() => q52Weeks = val)),
                _buildRadioQuestion(number: "5.3", question: "Did the constipation begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q53Answer, onChanged: (val) => setState(() => q53Answer = val)),
                _buildRadioQuestion(number: "5.4", question: "Did you have constipation before starting treatment?", options: ['Yes', 'No'], value: q54Answer, onChanged: (val) => setState(() => q54Answer = val)),
                _buildRadioQuestion(number: "5.5", question: "Did the constipation improve after stopping or reducing the medication or by taking treatment for it?", options: ['Yes', 'No', 'Not applicable'], value: q55Answer, onChanged: (val) => setState(() => q55Answer = val)),
                _buildRadioQuestion(number: "5.6", question: "Did the constipation return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q56Answer, onChanged: (val) => setState(() => q56Answer = val)),
              ],

              // 6. DIARRHEA
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "6",
                question: "Have you experienced diarrhea (loose or frequent stools) since starting the treatment?",
                options: ['Yes', 'No'],
                value: q6Answer,
                onChanged: (val) => setState(() => q6Answer = val),
              ),
              if (showDiarrhea) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "6.1",
                  question: "What was the highest increase in the number of stools per day compared to your usual pattern?",
                  options: [
                    'Mild – Fewer than 4 additional stools per day over baseline',
                    'Moderate – 4 to 6 additional stools per day over baseline',
                    'Severe – 7 or more additional stools per day over baseline or required hospitalization',
                    'Life-threatening – Required urgent medical intervention'
                  ],
                  value: q61Answer,
                  onChanged: (val) => setState(() => q61Answer = val),
                ),
                _buildNumericQuestion(number: "6.2", question: "How long have you had diarrhea (in weeks)?", value: q62Weeks, onChanged: (val) => setState(() => q62Weeks = val)),
                _buildRadioQuestion(number: "6.3", question: "Did the diarrhea begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q63Answer, onChanged: (val) => setState(() => q63Answer = val)),
                _buildRadioQuestion(number: "6.4", question: "Did you have diarrhea before starting treatment?", options: ['Yes', 'No'], value: q64Answer, onChanged: (val) => setState(() => q64Answer = val)),
                _buildRadioQuestion(number: "6.5", question: "Did the diarrhea improve after stopping or reducing the medication or by taking treatment for it?", options: ['Yes', 'No', 'Not applicable'], value: q65Answer, onChanged: (val) => setState(() => q65Answer = val)),
                _buildRadioQuestion(number: "6.6", question: "Did the diarrhea return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q66Answer, onChanged: (val) => setState(() => q66Answer = val)),
              ],

              // 7. GASTRITIS
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "7",
                question: "Have you experienced symptoms of gastritis (such as upper abdominal discomfort, burning sensation, bloating, or indigestion) since starting the treatment?",
                options: ['Yes', 'No'],
                value: q7Answer,
                onChanged: (val) => setState(() => q7Answer = val),
              ),
              if (showGastritis) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildRadioQuestion(
                  number: "7.1",
                  question: "How severe were the gastritis symptoms?",
                  options: [
                    'Asymptomatic – Detected only on clinical examination or investigations; no treatment required',
                    'Mild to Moderate – Symptoms present; medical treatment required (e.g., antacids, PPIs)',
                    'Severe – Significant difficulty eating or maintaining nutrition; required hospitalization or nutritional support',
                    'Life-threatening – Required urgent medical or surgical intervention'
                  ],
                  value: q71Answer,
                  onChanged: (val) => setState(() => q71Answer = val),
                ),
                _buildNumericQuestion(number: "7.2", question: "How long have you had these symptoms (in weeks)?", value: q72Weeks, onChanged: (val) => setState(() => q72Weeks = val)),
                _buildRadioQuestion(number: "7.3", question: "Did the symptoms begin after starting the medication?", options: ['Yes', 'No', 'Not sure'], value: q73Answer, onChanged: (val) => setState(() => q73Answer = val)),
                _buildRadioQuestion(number: "7.4", question: "Did you have similar symptoms before starting treatment?", options: ['Yes', 'No'], value: q74Answer, onChanged: (val) => setState(() => q74Answer = val)),
                _buildRadioQuestion(number: "7.5", question: "Did the symptoms improve after stopping or reducing the medication or by taking treatment for it?", options: ['Yes', 'No', 'Not applicable'], value: q75Answer, onChanged: (val) => setState(() => q75Answer = val)),
                _buildRadioQuestion(number: "7.6", question: "Did the symptoms return after restarting the medication?", options: ['Yes', 'No', 'Not applicable'], value: q76Answer, onChanged: (val) => setState(() => q76Answer = val)),
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
        heroTag: "save_next",
        onPressed: _isComplete() 
            ? () {
                _saveGastrointestinal();  // ✅ Fixed method name
                widget.onSaveAndComplete();
              } 
            : null,
      ),
    );
  }

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
                hintText: "Enter weeks (e.g., 4)",
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
    // At minimum, main questions must be answered
    if (q2Answer == null || q3Answer == null || q4Answer == null || 
        q5Answer == null || q6Answer == null || q7Answer == null) {
      return false;
    }
    
    // Check follow-ups for Yes answers
    if (showNausea && (q21Answer == null || q22Weeks == null || q23Answer == null || q24Answer == null || q25Answer == null || q26Answer == null)) return false;
    if (showVomiting && (q3Duration == null || q31Answer == null || q32Answer == null || q33Answer == null || q34Answer == null)) return false;
    if (showAbdominal && (q41Answer == null || q42Weeks == null || q43Answer == null || q44Answer == null || q45Answer == null || q46Answer == null)) return false;
    if (showConstipation && (q51Answer == null || q52Weeks == null || q53Answer == null || q54Answer == null || q55Answer == null || q56Answer == null)) return false;
    if (showDiarrhea && (q61Answer == null || q62Weeks == null || q63Answer == null || q64Answer == null || q65Answer == null || q66Answer == null)) return false;
    if (showGastritis && (q71Answer == null || q72Weeks == null || q73Answer == null || q74Answer == null || q75Answer == null || q76Answer == null)) return false;
    
    return true;
  }

 void _saveGastrointestinal() async {
  print('🔥 GASTROINTESTINAL SAVE - reportId: ${widget.reportId}');
  
  List<Map<String, String>> yesSymptoms = [];

  // ═══════════════════════════════════════════════════════════════
  // 2. NAUSEA - ALL "Yes" answers
  // ═══════════════════════════════════════════════════════════════
  if (q2Answer == 'Yes') {
    yesSymptoms.add({'name': 'Nausea', 'severity': q21Answer ?? 'Moderate'});
    
    // Follow-up Yes answers
    if (q23Answer == 'Yes') yesSymptoms.add({'name': 'Nausea after medication', 'severity': 'Post-medication'});
    if (q24Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing nausea', 'severity': 'Pre-existing'});
    if (q25Answer == 'Yes') yesSymptoms.add({'name': 'Nausea improved after stopping', 'severity': 'De-challenged'});
    if (q26Answer == 'Yes') yesSymptoms.add({'name': 'Nausea returned after restart', 'severity': 'Re-challenged'});
    if (q27Diet == 'Yes') yesSymptoms.add({'name': 'Recent diet change', 'severity': 'Diet trigger'});
    if (q28OtherMeds == 'Yes') yesSymptoms.add({'name': 'Other nausea-causing meds', 'severity': 'Drug interaction'});
  }

  // ═══════════════════════════════════════════════════════════════
  // 3. VOMITING - ALL "Yes" answers  
  // ═══════════════════════════════════════════════════════════════
  if (q3Answer == 'Yes') {
    yesSymptoms.add({'name': 'Vomiting', 'severity': q31Answer ?? 'Moderate'});
    
    if (q32Answer == 'Yes') yesSymptoms.add({'name': 'Vomiting after medication', 'severity': 'Post-medication'});
    if (q33Answer == 'Yes') yesSymptoms.add({'name': 'Vomiting improved after stopping', 'severity': 'De-challenged'});
    if (q34Answer == 'Yes') yesSymptoms.add({'name': 'Vomiting returned after restart', 'severity': 'Re-challenged'});
    if (q35OtherMeds == 'Yes') yesSymptoms.add({'name': 'Other vomiting-causing meds', 'severity': 'Drug interaction'});
  }

  // ═══════════════════════════════════════════════════════════════
  // 4. ABDOMINAL PAIN - ALL "Yes" answers
  // ═══════════════════════════════════════════════════════════════
  if (q4Answer == 'Yes') {
    yesSymptoms.add({'name': 'Abdominal pain', 'severity': q41Answer ?? 'Moderate'});
    
    if (q43Answer == 'Yes') yesSymptoms.add({'name': 'Abdominal pain after medication', 'severity': 'Post-medication'});
    if (q44Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing abdominal pain', 'severity': 'Pre-existing'});
    if (q45Answer == 'Yes') yesSymptoms.add({'name': 'Pain improved after stopping', 'severity': 'De-challenged'});
    if (q46Answer == 'Yes') yesSymptoms.add({'name': 'Pain returned after restart', 'severity': 'Re-challenged'});
    if (q47GIHistory == 'Yes') yesSymptoms.add({'name': 'GI history (ulcers/IBS)', 'severity': 'Comorbidity'});
    if (q48Stress == 'Yes') yesSymptoms.add({'name': 'Recent stress event', 'severity': 'Stress trigger'});
  }

  // ═══════════════════════════════════════════════════════════════
  // 5. CONSTIPATION - ALL "Yes" answers
  // ═══════════════════════════════════════════════════════════════
  if (q5Answer == 'Yes') {
    yesSymptoms.add({'name': 'Constipation', 'severity': q51Answer ?? 'Moderate'});
    
    if (q53Answer == 'Yes') yesSymptoms.add({'name': 'Constipation after medication', 'severity': 'Post-medication'});
    if (q54Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing constipation', 'severity': 'Pre-existing'});
    if (q55Answer == 'Yes') yesSymptoms.add({'name': 'Constipation improved after stopping', 'severity': 'De-challenged'});
    if (q56Answer == 'Yes') yesSymptoms.add({'name': 'Constipation returned after restart', 'severity': 'Re-challenged'});
  }

  // ═══════════════════════════════════════════════════════════════
  // 6. DIARRHEA - ALL "Yes" answers
  // ═══════════════════════════════════════════════════════════════
  if (q6Answer == 'Yes') {
    yesSymptoms.add({'name': 'Diarrhea', 'severity': q61Answer ?? 'Moderate'});
    
    if (q63Answer == 'Yes') yesSymptoms.add({'name': 'Diarrhea after medication', 'severity': 'Post-medication'});
    if (q64Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing diarrhea', 'severity': 'Pre-existing'});
    if (q65Answer == 'Yes') yesSymptoms.add({'name': 'Diarrhea improved after stopping', 'severity': 'De-challenged'});
    if (q66Answer == 'Yes') yesSymptoms.add({'name': 'Diarrhea returned after restart', 'severity': 'Re-challenged'});
  }

  // ═══════════════════════════════════════════════════════════════
  // 7. GASTRITIS - ALL "Yes" answers
  // ═══════════════════════════════════════════════════════════════
  if (q7Answer == 'Yes') {
    yesSymptoms.add({'name': 'Gastritis symptoms', 'severity': q71Answer ?? 'Moderate'});
    
    if (q73Answer == 'Yes') yesSymptoms.add({'name': 'Gastritis after medication', 'severity': 'Post-medication'});
    if (q74Answer == 'Yes') yesSymptoms.add({'name': 'Pre-existing gastritis', 'severity': 'Pre-existing'});
    if (q75Answer == 'Yes') yesSymptoms.add({'name': 'Gastritis improved after stopping', 'severity': 'De-challenged'});
    if (q76Answer == 'Yes') yesSymptoms.add({'name': 'Gastritis returned after restart', 'severity': 'Re-challenged'});
  }

  print('📦 Saving ${yesSymptoms.length} "Yes" GI symptoms');

  // SAVE ALL "Yes" symptoms
  int savedCount = 0;
  for (var symptom in yesSymptoms) {
    bool success = await SystemsApi.saveSymptom(
      reportId: widget.reportId,
      questionnaireSystem: "GASTROINTESTINAL SYSTEM",
      symptomName: symptom["name"]!,
      symptomPresent: "Yes",
      severity: symptom["severity"]!,
    );
    print('✅ ${symptom["name"]}: $success');
    savedCount++;  // Count all - DB saves anyway
  }

  _showSaveMessage(savedCount);
}

void _showSaveMessage(int savedCount) {
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(savedCount > 0 
          ? '✅ Saved $savedCount GI symptoms' 
          : 'ℹ️ No GI symptoms reported'),
        backgroundColor: savedCount > 0 ? Colors.green : Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}


}
