import 'package:flutter/material.dart';
import 'systems_api.dart'; 
import '../services/grading_report.dart';
import 'timer_widget.dart';

class RespiratoryScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const RespiratoryScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<RespiratoryScreen> createState() => _RespiratoryScreenState();
}


class _RespiratoryScreenState extends State<RespiratoryScreen> {
 
  String? q1Answer;      // Yes/No/Unknown
  String? q11Answer;     // Mild/Moderate/Severe
  String? q12Weeks;      // Numeric weeks
  String? q13Answer;     // Yes/No
  String? q14Answer;     // Yes/No/Not sure
  String? q141Answer;    // Yes/No/Not applicable (1.4.1)
  String? q142Answer;    // Yes/No/Not applicable (1.4.2)
  String? q15Answer;     // Yes/No (now 1.5)
  String? q16Answer;     // Yes/No (now 1.6)
  
  bool get showFollowup => q1Answer == 'Yes';
  bool get showQ141Q142 => showFollowup && q14Answer == 'Yes';
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
              // 1. MAIN QUESTION
              _buildRadioQuestion(
                number: "1",
                question: "Have you experienced any new or worsening shortness of breath since starting the treatment?",
                options: ['Yes', 'No', 'Unknown'],
                value: q1Answer,
                isRequired: true,
                showError: showErrors,
                onChanged: (val) => setState(() => q1Answer = val),
              ),
              
              // FOLLOW-UP (conditional)
              if (showFollowup) ...[
                const SizedBox(height: 20),
                Text("If yes, please continue:", 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                
                // 1.1 Severity
                _buildRadioQuestion(
                  number: "1.1",
                  question: "How severe is your shortness of breath?",
                  options: [
                    'Mild - I can perform my usual daily activities',
                    'Moderate - It interferes with my daily activities', 
                    'Severe - I have difficulty performing routine activities'
                  ],
                  value: q11Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) => setState(() => q11Answer = val),
                ),
                
                // 1.2 Weeks (numeric)
                _buildNumericQuestion(
                  number: "1.2",
                  question: "How long have you had this shortness of breath (in weeks)?",
                  value: q12Weeks,
                  onChanged: (val) => setState(() => q12Weeks = val),
                ),
                
                // 1.3 Pre-existing
                _buildRadioQuestion(
                  number: "1.3",
                  question: "Did the shortness of breath begin or was present before starting the medication?",
                  options: ['Yes', 'No'],
                  value: q13Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) => setState(() => q13Answer = val),
                ),
                
                // 1.4 After medication
                _buildRadioQuestion(
                  number: "1.4",
                  question: "Did the shortness of breath begin or worsen after starting the medication?",
                  options: ['Yes', 'No', 'Unknown'],
                  value: q14Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) => setState(() => q14Answer = val),
                ),
                
                // 1.4.1 & 1.4.2 (conditional)
                if (showQ141Q142) ...[
                  const SizedBox(height: 20),
                  Text("If 1.4 is yes continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                  const SizedBox(height: 20),
                  
                  _buildRadioQuestion(
                    number: "1.4.1",
                    question: "Did the symptoms improve after the medication was stopped or after you received treatment for it?",
                    options: ['Yes', 'No', 'Not applicable'],
                    value: q141Answer,
                    isRequired: true,
                     showError: showErrors,
                    onChanged: (val) => setState(() => q141Answer = val),
                  ),
                  _buildRadioQuestion(
                    number: "1.4.2",
                    question: "Did the shortness of breath return after restarting the medication?",
                    options: ['Yes', 'No', 'Not applicable'],
                    value: q142Answer,
                    isRequired: true,
                    showError: showErrors,
                    onChanged: (val) => setState(() => q142Answer = val),
                  ),
                ],
                
                // 1.5 Pre-existing lung conditions
                _buildRadioQuestion(
                  number: "1.5",
                  question: "Do you have any pre-existing lung conditions such as asthma, COPD, or prior lung disease?",
                  options: ['Yes', 'No','Unknown'],
                  value: q15Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) => setState(() => q15Answer = val),
                ),
                
                // 1.6 Recent infection/exposure
                _buildRadioQuestion(
                  number: "1.6",
                  question: "Have you recently had a respiratory infection or been exposed to dust, smoke, or allergens?",
                  options: ['Yes', 'No', 'Unknown'],
                  value: q16Answer,
                  isRequired: true,
                  showError: showErrors,
                  onChanged: (val) => setState(() => q16Answer = val),
                ),
              ],
              
              const SizedBox(height: 100), // Space for buttons
            ],
          ),
        ),
      ),
      
      // Save & Next Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        
        label: const Text(
          'Save & Next System', 
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        heroTag: "save_next",
        onPressed: () async {

  if (!_isComplete()) {

    setState(() {
      showErrors = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please answer all required questions"),
        backgroundColor: Colors.red,
      ),
    );

    return;
  }

  await _saveRespiratory();

  Navigator.pop(context, true);
},
            
      ),
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

    margin: const EdgeInsets.only(bottom: 16),

    elevation: 2,

    shape: RoundedRectangleBorder(

      side: BorderSide(

        color: (
                showError &&
                value == null
            )

            ? Colors.red

            : Colors.transparent,

        width: 2,
      ),

      borderRadius:
          BorderRadius.circular(12),
    ),

    color: Colors.white,

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

                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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

          const SizedBox(height: 12),

          ...options.map(

            (option) => RadioListTile<String>(

              title: Text(

                option,

                style:
                    const TextStyle(
                  fontSize: 14,
                ),
              ),

              value: option,

              groupValue: value,

              onChanged: (val) =>
                  onChanged(val ?? ''),
            ),
          ),

          // 🔴 ERROR MESSAGE
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
Widget _buildNumericQuestion({

  required String number,
  required String question,
  required String? value,
  required Function(String) onChanged,
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

          TextFormField(

            initialValue: value,

            keyboardType:
                TextInputType.number,

            onChanged: onChanged,

            decoration: InputDecoration(

              hintText:
                  "Enter weeks (e.g., 4)",

              border: OutlineInputBorder(

                borderRadius:
                    BorderRadius.circular(8),
              ),

              filled: true,

              fillColor:
                  Colors.grey[100],
            ),
          ),
        ],
      ),
    ),
  );
}

  // ✅ SIMPLIFIED: Button enables after Q1 only
 bool _isComplete() {

  // Main question mandatory
  if (q1Answer == null) return false;

  // If No/Unknown → enough
  if (q1Answer != 'Yes') return true;

  // Followups mandatory except 1.2
  if (q11Answer == null) return false;
  if (q13Answer == null) return false;
  if (q14Answer == null) return false;
  if (q15Answer == null) return false;
  if (q16Answer == null) return false;

  // If 1.4 = Yes → 1.4.1 and 1.4.2 mandatory
  if (q14Answer == 'Yes') {
    if (q141Answer == null) return false;
    if (q142Answer == null) return false;
  }

  return true;
}

  // ✅ YES-ONLY SAVING: Only "Yes" answers go to DB
  Future<void> _saveRespiratory() async {
    print('🔥 RESPIRATORY SAVE - reportId: ${widget.reportId}');
    print('Q1 Answer: $q1Answer');
    
    if (q1Answer != 'Yes') {
      print('ℹ️ No main symptom (Q1: $q1Answer) - checking followups only');
      
      // Check followup Yes answers only
      await _saveYesFollowups();
      _showSaveMessage(0);
      return;
    }
    final data = {
    'q1Answer': q1Answer ?? '',
    'q11Answer': q11Answer ?? '',
    'q12Weeks': q12Weeks ?? '',
    'q13Answer': q13Answer ?? '',
    'q14Answer': q14Answer ?? '',
    'q141Answer': q141Answer ?? '',
    'q142Answer': q142Answer ?? '',
    'q15Answer': q15Answer ?? '',
    'q16Answer': q16Answer ?? '',
  };
  final report = GradingReportGenerator.generateRespiratoryReport(data);
  print('📄 RESPIRATORY REPORT:\n$report');
  // ============================================

    // Main symptom + followups
    List<Map<String, String>> yesSymptoms = [];

    // Q1: Main shortness of breath
    yesSymptoms.add({
      'name': 'Shortness of breath',
      'severity': (q11Answer ?? 'moderate').split(' ')[0].toLowerCase(),
      'duration': q12Weeks ?? '',
    });

    // Q1.3: Pre-existing
    if (q13Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Pre-existing shortness of breath',
        'severity': 'mild',
        'extra': '',
      });
    }

    // Q1.4: After medication
    if (q14Answer == 'Yes') {
     yesSymptoms.add({
     'name': 'Shortness of breath',
     'severity': (q11Answer ?? 'moderate').split(' ')[0].toLowerCase(),
     'duration': q12Weeks ?? '',
     });
    }
    

    // Q1.4.1: Improved after stopping
    if (q141Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Shortness improved after stopping medication',
        'severity': 'mild',
        'extra': '',
      });
    }

    // Q1.4.2: Returned after restart
    if (q142Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Shortness returned after medication restart',
        'severity': 'mild',
        'extra': '',
      });
    }

    // Q1.5: Pre-existing lung disease
    if (q15Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Pre-existing lung conditions (asthma/COPD)',
        'severity': 'mild',
        'extra': '',
      });
    }

    // Q1.6: Recent infection/exposure
    if (q16Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Recent respiratory infection/exposure',
        'severity': 'mild',
        'extra': '',
      });
    }

    print('📦 Saving ${yesSymptoms.length} "Yes" symptoms');

    // Save each Yes symptom
    int savedCount = 0;
    for (var symptom in yesSymptoms) {
      try {
        bool success = await SystemsApi.saveSymptom(
          reportId: widget.reportId,
          questionnaireSystem: "RESPIRATORY SYSTEM",
          symptomName: symptom['name']!,
          symptomPresent: "Yes",
          severity: symptom['severity']!,
          durationWeeks: symptom["duration"] != null && symptom["duration"]!.isNotEmpty
      ? int.tryParse(symptom["duration"]!)
      : null,   //new
        );
        print('✅ ${symptom['name']}: $success');
        if (success) savedCount++;
      } catch (e) {
        print('❌ ${symptom['name']}: $e');
      }
    }

    _showSaveMessage(savedCount);
  }

  // Helper: Save only followup Yes answers (when Q1=No)
  Future<void> _saveYesFollowups() async {
    List<Map<String, String>> followupYes = [];

    if (q15Answer == 'Yes') {
      followupYes.add({
        'name': 'Pre-existing lung conditions (asthma/COPD)',
        'severity': 'mild',
        'extra': '',
      });
    }
    if (q16Answer == 'Yes') {
      followupYes.add({
        'name': 'Recent respiratory infection/exposure',
        'severity': 'mild',
        'extra': '',
      });
    }

    for (var symptom in followupYes) {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "RESPIRATORY SYSTEM",
        symptomName: symptom['name']!,
        symptomPresent: "Yes",
        severity: symptom['severity']!,
      );
    }
  }

  void _showSaveMessage(int savedCount) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(savedCount > 0 
            ? '✅ Saved $savedCount "Yes" symptoms' 
            : 'ℹ️ No symptoms to save'
          ),
          backgroundColor: savedCount > 0 ? Colors.blue : Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}


