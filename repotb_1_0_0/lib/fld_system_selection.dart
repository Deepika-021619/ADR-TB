import 'package:flutter/material.dart';

import 'gastrointestinal_screen.dart';
import 'skin_screen.dart';
import 'centralNervous_system.dart';
import 'musculoskeletal_screen.dart';
import 'respiratory_screen.dart';
import 'ocular_screen.dart';
import 'psychiatric_screen.dart';
import 'genitourinary_screen.dart';
import 'general_screen.dart';
import 'investigations_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FLDSystemSelectionScreen extends StatefulWidget {
  final String reportId;

  const FLDSystemSelectionScreen({
    Key? key,
    required this.reportId,
  }) : super(key: key);

  @override
  State<FLDSystemSelectionScreen> createState() =>
      _FLDSystemSelectionScreenState();
}

class _FLDSystemSelectionScreenState
    extends State<FLDSystemSelectionScreen> {
final Map<String, bool> completedSystems = {
  "Gastrointestinal": false,
  "Skin": false,
  "Central Nervous System": false,
  "Musculoskeletal": false,
  "Respiratory": false,
  "Ocular": false,
  "Psychiatric": false,
  "Genitourinary": false,
  "General": false,
  "Investigations": false,
};

  int get completedCount =>
      completedSystems.values.where((e) => e).length;

  Future<void> openSystem(
      String system, Widget page) async {
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
    if (!completedSystems["General"]! || !completedSystems["Investigations"]!) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Required Section"),
          content: const Text(
            "Please complete the General symptoms and Investigations section before generating the report.",
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Report generation will start here."),
      ),
    );

    // Navigate to report screen later
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
        title: const Text("FLD Questionnaires"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Text(
              "Select only the affected organ systems.\nGeneral and Investigations are mandatory before generating the report.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [

                  buildCard(
                    icon: FontAwesomeIcons.pills,
                    title: "Gastrointestinal",
                    page: GastrointestinalScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
  icon: FontAwesomeIcons.handDots,
  title: "Skin",
  page: SkinSubcutaneousScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {},
  ),
),
                 buildCard(
  icon: FontAwesomeIcons.brain,
  title: "Central Nervous System",
  page: CentralnervousSystemScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {},
  ),
),
                  buildCard(
                    icon: FontAwesomeIcons.bone,
                    title: "Musculoskeletal",
                    page: MusculoskeletalScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.lungs,
                    title: "Respiratory",
                    page: RespiratoryScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  

                  
buildCard(
  icon: FontAwesomeIcons.eye,
  title: "Ocular",
  page: OcularInvolvementScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {},
  ),
),
                  buildCard(
                    icon: Icons.mood,
                    title: "Psychiatric",
                    page: PsychiatricScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  buildCard(
                    icon: FontAwesomeIcons.droplet,
                    title: "Genitourinary",
                    page: GenitourinaryScreen(
                      reportId: widget.reportId,
                      onSaveAndComplete: () {},
                    ),
                  ),

                  const Divider(height: 30),

buildCard(
  icon: FontAwesomeIcons.stethoscope,
  title: "General",
  requiredSection: true,
  page: GeneralSymptomsScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {},
  ),
),

buildCard(
  icon:  FontAwesomeIcons.flask,
  title: "Investigations",
  requiredSection: true,
  page: InvestigationsScreen(
    reportId: widget.reportId,
    onSaveAndComplete: () {},
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
                  padding: const EdgeInsets.all(15),
                  backgroundColor: Colors.green,
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