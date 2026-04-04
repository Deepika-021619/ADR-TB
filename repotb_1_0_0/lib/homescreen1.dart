import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logo.png"),
          fit: BoxFit.contain,
            opacity: 0.3,  // ✅ Logo 70% transparent
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("repoTB ADR"),
          backgroundColor: Colors.blue.shade400,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            // Button (top)
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.medical_services, size: 32, color: Colors.white),
                      SizedBox(width: 12),
                      Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ✅ BIG Description (ABOVE logo - takes more space)
            Expanded(
                flex: 2,  // ✅ Bigger container
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.97),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],  // ✅ Nice shadow
                ),
                child: SingleChildScrollView(
                  child: const Text(
                    "TB related ADR reporting App is designed to support active Tuberculosis(TB) patients and healthcare providers by providing a platform to report and manage Adverse Drug Reactions(ADRs) associated with TB treatment. By enabling real-time reporting and tracking of side effects, the app aims to enhance patient safety, improve treatment outcomes, and facilitate communication between patients and healthcare providers.",
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.7,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
