import 'package:flutter/material.dart';
import 'cardio_screen.dart'; // already created
import 'centralnervous_sld.dart';
import 'psychiatric_sld.dart';
import 'auditory_sld.dart';
import 'ocular_sld.dart';
import 'gastrointestinal_sld.dart';
import 'endocrine.dart';
import 'musculoskeletal_sld.dart';
import 'skin_sld.dart';
import 'investigations_sld.dart';
import 'general_sld.dart';
import 'others_sld.dart';
import 'timer_widget.dart';

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
    "Psychiatric",
    "Auditory",
    "Ocular",
    "Gastrointestinal",
    "Endocrine",
    "Musculoskeletal",
    "SkinSubcutaneous",
    "Investigations-Hematological,metabolic,renal",
    "General symptoms",
    "Other side effects"
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

  actions: const [

    Padding(

      padding: EdgeInsets.only(
        right: 12,
      ),

      child: TimerWidget(),
    ),
  ],
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
     case 3:
     return AuditorySLDScreen(
       reportId: widget.reportId,
       onSaveAndComplete: () {
         setState(() => currentSystemIndex++);
       },
     );
      case 4:
      return OcularSLDScreen(
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 5:
      return GastrointestinalSLDScreen(
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 6:
      return EndocrineSLDScreen(
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 7:
      return MusculoskeletalSLDScreen(
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 8:
      return SkinSubcutaneousSLDScreen(
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 9:
      return InvestigationsSLDScreen(
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 10:
      return GeneralSymptomsScreen(      
        reportId: widget.reportId,
        onSaveAndComplete: () {
          setState(() => currentSystemIndex++);
        },
      );
      case 11:
      return OtherSideEffectsScreen(
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
