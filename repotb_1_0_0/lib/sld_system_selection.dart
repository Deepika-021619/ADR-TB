import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'timer_widget.dart';

import 'cardio_screen.dart';
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

class SLDSystemSelectionScreen extends StatefulWidget {
  final String reportId;

  const SLDSystemSelectionScreen({
    Key? key,
    required this.reportId,
  }) : super(key: key);

  @override
  State<SLDSystemSelectionScreen> createState() =>
      _SLDSystemSelectionScreenState();
}

class _SLDSystemSelectionScreenState
    extends State<SLDSystemSelectionScreen> {

  final Map<String, bool> completedSystems = {

    "Cardiovascular": false,
    "Central Nervous": false,
    "Psychiatric": false,
    "Auditory": false,
    "Ocular": false,
    "Gastrointestinal": false,
    "Endocrine": false,
    "Musculoskeletal": false,
    "Skin & Subcutaneous": false,
    "Investigations": false,
    "General Symptoms": false,
    "Other Side Effects": false,
  };

  int get completedCount =>
      completedSystems.values.where((e) => e).length;

  Future<void> openSystem(
      String system,
      Widget page,
      ) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );

    if (result == true) {
      setState(() {
        completedSystems[system] = true;
      });
    }
  }

  void generateReport() {

    if (!completedSystems["Investigations"]! ||
    !completedSystems["General Symptoms"]! ||
    !completedSystems["Other Side Effects"]!) {

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Required Section"),
          content: const Text(
            "Please complete the General Symptoms, Investigations and other side effects sections before generating the report.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "SLD report generation will start here.",
        ),
      ),
    );

    // TODO:
    // Navigator.push(...)
    // Open SLD Report Screen
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required Widget page,
    bool requiredSection = false,
  }) {

    bool done = completedSystems[title]!;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),

      child: ListTile(

        leading: Icon(
          done ? Icons.check_circle : icon,
          color: done ? Colors.green : Colors.blue,
        ),

        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: done ? Colors.green : Colors.black,
          ),
        ),

        subtitle: requiredSection
            ? const Text(
                "Required",
                style: TextStyle(color: Colors.red),
              )
            : null,

        trailing: const Icon(Icons.arrow_forward_ios),

        onTap: () {
          openSystem(title, page);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("SLD Questionnaires"),

        backgroundColor: Colors.blue,

        actions: const [

          Padding(
            padding: EdgeInsets.only(right: 12),
            child: TimerWidget(),
          ),

        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Select the affected organ systems.\nGeneral Symptoms, Investigations and Other Side effects are mandatory before generating the report.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView(

                children: [

                  buildCard(
                    icon: FontAwesomeIcons.heartPulse,
                    title: "Cardiovascular",
                    page: CardiovascularScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.brain,
                    title: "Central Nervous",
                    page: CentralNervousSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: Icons.psychology,
                    title: "Psychiatric",
                    page: PsychiatricSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.earListen,
                    title: "Auditory",
                    page: AuditorySLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.eye,
                    title: "Ocular",
                    page: OcularSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.pills,
                    title: "Gastrointestinal",
                    page: GastrointestinalSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.droplet,
                    title: "Endocrine",
                    page: EndocrineSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.bone,
                    title: "Musculoskeletal",
                    page: MusculoskeletalSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.handDots,
                    title: "Skin & Subcutaneous",
                    page: SkinSubcutaneousSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  const Divider(height: 30),

                  buildCard(
                    icon: FontAwesomeIcons.flask,
                    title: "Investigations",
                    requiredSection: true,
                    page: InvestigationsSLDScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.stethoscope,
                    title: "General Symptoms",
                    requiredSection: true,
                    page: GeneralSymptomsScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.notesMedical,
                    title: "Other Side Effects",
                    requiredSection: true,
                    page: OtherSideEffectsScreen(
                      reportId: widget.reportId,
                      
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Completed: $completedCount / ${completedSystems.length}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(

                icon: const Icon(Icons.description),

                label: const Text("Generate Report"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),

                onPressed: generateReport,
              ),
            ),
          ],
        ),
      ),
    );
  }
}