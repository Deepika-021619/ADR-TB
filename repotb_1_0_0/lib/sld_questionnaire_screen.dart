import 'package:flutter/material.dart';
import 'cardio_screen.dart'; // already created
import 'centralnervous_sld.dart';
import 'psychiatric_sld.dart';

class SLDQuestionnaireScreen extends StatefulWidget {
  final String portal, reportId;

  const SLDQuestionnaireScreen({
    super.key,
    required this.portal,
    required this.reportId,
  });

  @override
  State<SLDQuestionnaireScreen> createState() => _SLDQuestionnaireScreenState();
}

class _SLDQuestionnaireScreenState extends State<SLDQuestionnaireScreen> {
  int currentSystemIndex = 0;
  bool isComplete = false;

  // ✅ USE EXACT DB ENUM VALUES (IMPORTANT)
  final List<String> systems = [
    "Cardiovascular",
    "Centralnervous",
    "Gastrointestinal",
    "Endocrine",
    "Musculoskeletal",
    "Psychiatric",
    "Auditory",
    "Ocular",
    "SkinSubcutaneous",
    "Hematological",
    "Metabolic",
    "Renal"
  ];

  @override
  Widget build(BuildContext context) {
    if (isComplete) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("SLD Questionnaire Complete"),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text("All SLD systems completed"),
        ),
      );
    }

    final currentSystem = systems[currentSystemIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${currentSystemIndex + 1}/${systems.length} $currentSystem",
        ),
        backgroundColor: Colors.blue,
      ),

      body: _buildCurrentSystem(),
    );
  }

  Widget _buildCurrentSystem() {
    switch (currentSystemIndex) {

      /// ✅ CARDIOVASCULAR (already built)
      case 0:
        return CardiovascularScreen(
          reportId: widget.reportId,
          onSaveAndComplete: () {
            setState(() => currentSystemIndex++);
          },
        );
        case 1:
  return CentralNervousSLDScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {
      setState(() => currentSystemIndex++);
    },
  );
      case 2:
  return PsychiatricSLDScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {
      setState(() => currentSystemIndex++);
    },
  );

      /// 🔜 PLACEHOLDER (for now)
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                systems[currentSystemIndex],
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (currentSystemIndex + 1 >= systems.length) {
                    setState(() => isComplete = true);
                  } else {
                    setState(() => currentSystemIndex++);
                  }
                },
                child: const Text("Next (Not built yet)"),
              ),
            ],
          ),
        );
    }
  }
}
