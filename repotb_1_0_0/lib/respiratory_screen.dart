import 'package:flutter/material.dart';
import 'systems_api.dart'; 

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
  String? q15Answer;     // Yes/No/Not applicable
  String? q16Answer;     // Yes/No/Not applicable
  String? q17Answer;     // Yes/No
  String? q18Answer;     // Yes/No
  
  bool get showFollowup => q1Answer == 'Yes';

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
                    'Severe - I have difficulty performing routine activities or need medical attention'
                  ],
                  value: q11Answer,
                  onChanged: (val) => setState(() => q11Answer = val),
                ),
                
                // 1.2 Weeks (numeric)
                _buildNumericQuestion(
                  number: "1.2",
                  question: "How long have you had this shortness of breath (in weeks)?",
                  value: q12Weeks,
                  onChanged: (val) => setState(() => q12Weeks = val),
                ),
                
                // 1.3-1.8 Yes/No questions
                _buildRadioQuestion(
                  number: "1.3",
                  question: "Did the shortness of breath begin or was present before starting the medication?",
                  options: ['Yes', 'No'],
                  value: q13Answer,
                  onChanged: (val) => setState(() => q13Answer = val),
                ),
                _buildRadioQuestion(
                  number: "1.4",
                  question: "Did the shortness of breath begin or worsen after starting the medication?",
                  options: ['Yes', 'No', 'Not sure'],
                  value: q14Answer,
                  onChanged: (val) => setState(() => q14Answer = val),
                ),
                _buildRadioQuestion(
                  number: "1.5",
                  question: "Did the symptom improve after the medication was stopped or after you received treatment for it?",
                  options: ['Yes', 'No', 'Not applicable'],
                  value: q15Answer,
                  onChanged: (val) => setState(() => q15Answer = val),
                ),
                _buildRadioQuestion(
                  number: "1.6",
                  question: "Did the shortness of breath return after restarting the medication?",
                  options: ['Yes', 'No', 'Not applicable'],
                  value: q16Answer,
                  onChanged: (val) => setState(() => q16Answer = val),
                ),
                _buildRadioQuestion(
                  number: "1.7",
                  question: "Do you have any pre-existing lung conditions such as asthma, COPD, or prior lung disease?",
                  options: ['Yes', 'No'],
                  value: q17Answer,
                  onChanged: (val) => setState(() => q17Answer = val),
                ),
                _buildRadioQuestion(
                  number: "1.8",
                  question: "Have you recently had a respiratory infection or been exposed to dust, smoke, or allergens?",
                  options: ['Yes', 'No'],
                  value: q18Answer,
                  onChanged: (val) => setState(() => q18Answer = val),
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
        onPressed: _isComplete()
            ? () {
                _saveRespiratory();        
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

  // ✅ SIMPLIFIED: Button enables after Q1 only
  bool _isComplete() {
    return q1Answer != null;
  }

  // ✅ YES-ONLY SAVING: Only "Yes" answers go to DB
  void _saveRespiratory() async {
    print('🔥 RESPIRATORY SAVE - reportId: ${widget.reportId}');
    print('Q1 Answer: $q1Answer');
    
    if (q1Answer != 'Yes') {
      print('ℹ️ No main symptom (Q1: $q1Answer) - checking followups only');
      
      // Check followup Yes answers only
      await _saveYesFollowups();
      _showSaveMessage(0);
      return;
    }

    // Main symptom + followups
    List<Map<String, String>> yesSymptoms = [];

    // Q1: Main shortness of breath
    yesSymptoms.add({
      'name': 'Shortness of breath',
      'severity': (q11Answer ?? 'moderate').split(' ')[0].toLowerCase(),
      'extra': q12Weeks ?? '',
    });

    // Q1.3: Pre-existing
    if (q13Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Pre-existing shortness of breath',
        
        'extra': '',
      });
    }

    // Q1.4: After medication
    if (q14Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Shortness of breath after medication',
        
        'extra': '',
      });
    }

    // Q1.5: Improved after stopping
    if (q15Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Shortness improved after stopping medication',
        
        'extra': '',
      });
    }

    // Q1.6: Returned after restart
    if (q16Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Shortness returned after medication restart',
        
        'extra': '',
      });
    }

    // Q1.7: Pre-existing lung disease
    if (q17Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Pre-existing lung conditions (asthma/COPD)',
        
        'extra': '',
      });
    }

    // Q1.8: Recent infection/exposure
    if (q18Answer == 'Yes') {
      yesSymptoms.add({
        'name': 'Recent respiratory infection/exposure',
        
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
          // Pass duration as extra field if your API supports it
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

    if (q17Answer == 'Yes') {
      followupYes.add({
        'name': 'Pre-existing lung conditions (asthma/COPD)',
        
        'extra': '',
      });
    }
    if (q18Answer == 'Yes') {
      followupYes.add({
        'name': 'Recent respiratory infection/exposure',
        
        'extra': '',
      });
    }

    for (var symptom in followupYes) {
      await SystemsApi.saveSymptom(
        reportId: widget.reportId,
        questionnaireSystem: "Respiratory",
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
            : 'ℹ️ No symptoms to save (only "Yes" answers are saved)'
          ),
          backgroundColor: savedCount > 0 ? Colors.green : Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
