import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'patient_screen.dart';
import 'dart:async';
import '../services/questionnaire_timer.dart';
import 'timer_widget.dart';

class StartReportScreen extends StatefulWidget {
  final String portal;

  const StartReportScreen({super.key, required this.portal});

  @override
  State<StartReportScreen> createState() => _StartReportScreenState();
}

class _StartReportScreenState extends State<StartReportScreen> {
  

  
  

  @override
  void initState() {
    super.initState();
    QuestionnaireTimer.start();

  }

  final TextEditingController nikshayIdController = TextEditingController();
  
 
  final TextEditingController placeController = TextEditingController();

  String? gender = null;
  
  bool isLoading = false;

  Widget requiredLabel(String text) {

  return RichText(

    text: TextSpan(

      text: text,

      style: const TextStyle(

        color: Colors.black87,
        fontSize: 16,
      ),

      children: const [

        TextSpan(

          text: " *",

          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
}

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> createPatientAndReport() async {
  final nikshayId = nikshayIdController.text.trim();
 
  final selectedGender = gender;
 

      if (nikshayId.isEmpty) {
    _showError("NIKSHAY ID is required!");
    return;
  }
  
 
  
  if (selectedGender == null) {
    _showError("Please select Gender!");
    return;
  }
  
  if (placeController.text.trim().isEmpty) {
  _showError("Please enter Place!");
  return;
}

  setState(() => isLoading = true);

    try {
      print("Creating for Patient: ${nikshayIdController.text}");

     final patientResponse = await http.post(
       Uri.parse("https://tb-adr-backend-baabb4bgecgebude.centralindia-01.azurewebsites.net/patient_details/patients"),
        
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "nik_id": nikshayIdController.text.trim(),
          "p_id": nikshayIdController.text.trim(),
          "p_name": "",
          "gender": gender ?? "Not Specified",
          "p_state": placeController.text.trim(),
        }),
      ).timeout(const Duration(seconds: 5));

      print("Patient Status: ${patientResponse.statusCode}");
      print("Patient Response: ${patientResponse.body}");
    if (patientResponse.statusCode == 400 || 
        patientResponse.statusCode == 500 ||
        patientResponse.body.toLowerCase().contains("duplicate") ||
        patientResponse.body.toLowerCase().contains("already exists")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            " Nikshay ID '${nikshayIdController.text}' / Patient ID  already exists!\n"
            "Recheck or use a different Nikshay ID / Patient ID ",
          ),
          backgroundColor: Colors.orange.shade700,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: "OK",
            textColor: Colors.white,
            backgroundColor: Colors.blue.shade600, 
            onPressed: () {},
          ),
        ),
      );
      setState(() => isLoading = false);
      return; // Stop here - don't create report
    }

    if (patientResponse.statusCode != 200 && patientResponse.statusCode != 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Failed to save patient (${patientResponse.statusCode})"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => isLoading = false);
      return;
    }

      // STEP 2 — Create Report
      final reportResponse = await http.post(
        Uri.parse("https://tb-adr-backend-baabb4bgecgebude.centralindia-01.azurewebsites.net/reports"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "nik_id": nikshayIdController.text,
          "portal": widget.portal
        }),
      ).timeout(const Duration(seconds: 20));
      print("Report Status: ${reportResponse.statusCode}");
      print("Report Response: ${reportResponse.body}");

    if (reportResponse.statusCode == 200 || reportResponse.statusCode == 201) {
        final reportData = jsonDecode(reportResponse.body);
        final reportId = reportData["report_id"] ?? "Unknown";
       ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("✅ Report Created: $reportId"),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 1),
  ),
  
);
        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => StartPatientScreen(
      portal: widget.portal,
      reportId: reportId,
    ),
  ),
);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(" Failed: ${reportResponse.statusCode}\n${reportResponse.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }


    } catch (e) {
      print(" ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Network Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => isLoading = false);
  }
  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(

  backgroundColor: Colors.blue[700],

  foregroundColor: Colors.white,

  title: const Text(

    "Patient Details",

    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),

  actions: const [

    Padding(

      padding: EdgeInsets.only(
        right: 12,
      ),

      child: TimerWidget(),
    ),
  ],
),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nikshayIdController,
              decoration: InputDecoration(
                label: requiredLabel("Nikshay ID/ Patient ID"),
                hintText: "Enter Nikshay ID or Patient ID",
                prefixIcon: Icon(Icons.person, color: Colors.red.shade400),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

           

            const SizedBox(height: 15),

            
            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: gender,
              hint: requiredLabel("Select Gender"),
              decoration: InputDecoration(
                label: requiredLabel("Gender"),
                prefixIcon: Icon(Icons.person, color: Colors.red.shade400),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() => gender = value!);
              },
            ),

            const SizedBox(height: 15),

            TextField(
  controller: placeController,
  decoration: InputDecoration(
    label: requiredLabel("Place"),
    hintText: "Enter Hospital / City / District",
    prefixIcon: Icon(
      Icons.location_on,
      color: Colors.red.shade400,
    ),
    border: const OutlineInputBorder(),
  ),
),

// 🔹 SHOW OTHER TEXTBOX

            const SizedBox(height: 25),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: createPatientAndReport,
                    child: const Text("Create Report"),
                  )
          ],
        ),
      ),
    );
  }
}