import 'package:flutter/material.dart';
import 'respiratory_screen.dart';
import 'gastrointestinal_screen.dart';
import 'centralNervous_system.dart';
import 'ocular_screen.dart';
import 'skin_screen.dart';
import 'psychiatric_screen.dart';
import 'musculoskeletal_screen.dart';
import 'genitourinary_screen.dart';
import 'general_screen.dart';
import 'investigations_screen.dart';
import 'timer_widget.dart';


class FLDQuestionnaireScreen extends StatefulWidget {
  final String reportId;
  
  const FLDQuestionnaireScreen({
  super.key,
  required this.reportId,
  
});

  @override
  State<FLDQuestionnaireScreen> createState() => _FLDQuestionnaireScreenState();
}

class _FLDQuestionnaireScreenState extends State<FLDQuestionnaireScreen> {
  int currentSystemIndex = 0;
  bool isComplete = false;
  
  final List<String> systems = [
    "RESPIRATORY SYSTEM", "GASTROINTESTINAL SYSTEM", "CENTRAL NERVOUS SYSTEM",
    "OCULAR INVOLVEMENT", "SKIN AND SUBCUTANEOUS TISSUE RELATED SYMPTOMS",
    "PSYCHIATRIC DISORDERS (PRO CTCAE)", "MUSCULOSKELETAL SYMPTOMS",
    "GENITOURINARY SYMPTOMS", "GENERAL NONSPECIFIC SYMPTOMS", "INVESTIGATIONS"
  ];

  @override
  Widget build(BuildContext context) {
    if (isComplete) {
      return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text('Questionnaire Complete!', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green[600],

        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                'All questions completed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Thank you for completing the questionnaire', 
                   style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    final currentSystem = systems[currentSystemIndex];
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop && currentSystemIndex > 0) {
          setState(() => currentSystemIndex--);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
         title: Text('${currentSystemIndex + 1}/10 ${systems[currentSystemIndex]}', 
     style: const TextStyle(color: Colors.white)),

          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: currentSystemIndex > 0
                ? () => setState(() => currentSystemIndex--)
                : null,
          ),
         actions: [

  const Padding(

    padding: EdgeInsets.only(
      right: 8,
    ),

    child: TimerWidget(),
  ),

  Container(

    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),

    child: Text(

      '${currentSystemIndex + 1}/10',

      style: const TextStyle(

        color: Colors.white,

        fontWeight: FontWeight.bold,
      ),
    ),
  ),
],

        ),
        body: SafeArea(
          child: Column(
            children: [
              // Progress bar
              Container(
                height: 8,
                color: Colors.blue[200],
                child: LinearProgressIndicator(
                  value: (currentSystemIndex + 1) / 10,
                  backgroundColor: Colors.blue[100],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              
              // Questions area - DYNAMIC SYSTEM LOADING
              Expanded(
                child: _buildCurrentSystem(),
              ),
            ],
          ),
        ),
        
      ),
    );
  }

  Widget _buildCurrentSystem() {
    switch (currentSystemIndex) {
      case 0:
        return RespiratoryScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
      case 1:
        return GastrointestinalScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () => setState(() => currentSystemIndex++),
  );
      case 2:
        return CentralnervousSystemScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
        case 3:
        return OcularInvolvementScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
        
        case 4:
        return SkinSubcutaneousScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
        case 5:
        return PsychiatricScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
        case 6:
        return MusculoskeletalScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
        case 7:
        return GenitourinaryScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
        case 8:
        return GeneralSymptomsScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () => setState(() => currentSystemIndex++),
        );
      case 9:
  return InvestigationsScreen(
    reportId: widget.reportId,
    
    onSaveAndComplete: () => setState(() => isComplete = true),
  );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              Text(
                '${systems[currentSystemIndex]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text('Complete previous systems first', 
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
            ],
          ),
        );
    }
  }

  bool _canProceedToNext() {
    // For now, always allow (systems have internal validation)
    return currentSystemIndex < systems.length - 1;
  }

  void _goToNextSystem() {
    if (currentSystemIndex + 1 >= systems.length) {
      setState(() => isComplete = true);
    }
  }
}