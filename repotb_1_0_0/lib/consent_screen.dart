import 'package:flutter/material.dart';
import 'start_report_screen.dart';

class ConsentScreen extends StatefulWidget {
  final String portal;

  const ConsentScreen({
    super.key,
    required this.portal,
  });

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],

      appBar: AppBar(
        title: const Text(
          "E-Consent Form",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

     body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Icon(
                Icons.assignment_turned_in_rounded,
                size: 70,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Online Survey and E-Consent Form",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Evaluation of Adverse drug reaction Reporting Mobile Application (TB ADR)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "You are invited to participate in a short survey regarding the ADR reporting mobile application. "
              "The survey aims to assess whether the app can be easily used in different clinical settings."
              "You will be asked to complete an ADR form based on your experience with patients on anti-TB treatment, using a dummy report."
              "We will record the time taken, successful report generation, and any technical glitches to guide app improvements based on user experience.",
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "• Participation is voluntary\n\n"
              "• The survey will take about 10–15 minutes\n\n"
              "• Your responses will be kept confidential\n\n"
              "• No clinical data is collected at the survey, therefore, no ethical approval is required at this stage ",
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            CheckboxListTile(
              value: isAgreed,
              activeColor: Colors.blue[700],
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "I Agree to Participate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isAgreed = value ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                onPressed: isAgreed
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartReportScreen(
                              portal: widget.portal,
                            ),
                          ),
                        );
                      }
                    : null,

                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
    );
  }
}