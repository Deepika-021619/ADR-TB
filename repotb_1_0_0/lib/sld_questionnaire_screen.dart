import 'package:flutter/material.dart';
class SLDQuestionnaireScreen extends StatelessWidget {
  final String portal, reportId;
  const SLDQuestionnaireScreen({super.key, required this.portal, required this.reportId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SLD Questionnaire")),
      body: const Center(child: Text("SLD Questions Here")),
    );
  }
}
