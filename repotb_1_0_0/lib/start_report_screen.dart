import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'patient_screen.dart';
import '../api_config.dart';

class StartReportScreen extends StatefulWidget {
  final String portal;

  const StartReportScreen({super.key, required this.portal});

  @override
  State<StartReportScreen> createState() => _StartReportScreenState();
}

class _StartReportScreenState extends State<StartReportScreen> {

  final TextEditingController nikshayIdController = TextEditingController();
  final TextEditingController patientIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  

  String? gender = null;
  String? state = null;
  bool isLoading = false;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> createPatientAndReport() async {
  final nikshayId = nikshayIdController.text.trim();
  final patientName = nameController.text.trim();
  final selectedGender = gender;
  final selectedState = state;

      if (nikshayId.isEmpty) {
    _showError("NIKSHAY ID is required!");
    return;
  }
  
  if (patientName.isEmpty) {
    _showError("Patient Name is required!");
    return;
  }
  
  if (selectedGender == null) {
    _showError("Please select Gender!");
    return;
  }
  
  if (selectedState == null) {
    _showError(" Please select State!");
    return;
  }

  setState(() => isLoading = true);

    try {
      print("Creating for Patient: ${nikshayIdController.text}");

     final patientResponse = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/patient_details/patients"),
        
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "nik_id": nikshayIdController.text.trim(),
          "p_id": patientIdController.text.trim().isEmpty ? "" : patientIdController.text.trim(),
          "p_name": nameController.text.trim(),
          "gender": gender ?? "Not Specified",
          "p_state": state ?? "Not Selected",
        }),
      ).timeout(const Duration(seconds: 30));

      print("Patient Status: ${patientResponse.statusCode}");
      print("Patient Response: ${patientResponse.body}");
    if (patientResponse.statusCode == 400 || 
        patientResponse.statusCode == 500 ||
        patientResponse.body.toLowerCase().contains("duplicate") ||
        patientResponse.body.toLowerCase().contains("already exists")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            " Nikshay ID '${nikshayIdController.text}' / Patient ID '${patientIdController.text}' already exists!\n"
            "Recheck or use a different Nikshay ID / Patient ID ",
          ),
          backgroundColor: Colors.orange.shade700,
          duration: const Duration(seconds: 10),
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
        Uri.parse("${ApiConfig.baseUrl}/Reporter_details/reporter_details"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "nik_id": nikshayIdController.text,
          "portal": widget.portal
        }),
      ).timeout(const Duration(seconds: 30));
      print("Report Status: ${reportResponse.statusCode}");
      print("Report Response: ${reportResponse.body}");

    if (reportResponse.statusCode == 200 || reportResponse.statusCode == 201) {
        final reportData = jsonDecode(reportResponse.body);
        final reportId = reportData["report_id"] ?? "Unknown";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("✅ Report Created: $reportId"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 15),
            action: SnackBarAction(
            label: "CONTINUE",  // ✅ Better UX
            textColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartPatientScreen(
                    portal: widget.portal,
                    reportId: reportId,
                  ),
                ),
              );
            },
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
      appBar: AppBar(title: const Text("Patient Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nikshayIdController,
              decoration: InputDecoration(
                labelText: "Nikshay ID *",
                hintText: "Required",
                prefixIcon: Icon(Icons.person, color: Colors.red.shade400),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: patientIdController,
              decoration: InputDecoration(
                labelText: "Patient ID",
                prefixIcon: Icon(Icons.person, color: Colors.red.shade400),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Patient Name *",
                hintText: "Required",
                prefixIcon: Icon(Icons.person, color: Colors.red.shade400),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: gender,
              hint: const Text("Select Gender *"),
              decoration: InputDecoration(
                labelText: "Gender",
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

          DropdownButtonFormField<String>(
            value: state,
            hint: const Text("Select State *"),
            decoration: InputDecoration(
              labelText: "State",
               prefixIcon: Icon(Icons.person, color: Colors.red.shade400),
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: "Andra Pradesh", child: Text("Andra Pradesh")),
              DropdownMenuItem(value: "Arunachal Pradesh", child: Text("Arunachal Pradesh")),
              DropdownMenuItem(value: "Assam", child: Text("Assam")),
              DropdownMenuItem(value: "Bihar", child: Text("Bihar")),
              DropdownMenuItem(value: "Chhattisgarh", child: Text("Chhattisgarh")),
              DropdownMenuItem(value: "Goa", child: Text("Goa")),
              DropdownMenuItem(value: "Gujarat", child: Text("Gujarat")),
              DropdownMenuItem(value: "Haryana", child: Text("Haryana")),
              DropdownMenuItem(value: "Himachal Pradesh", child: Text("Himachal Pradesh")),
              DropdownMenuItem(value: "Jharkhand", child: Text("Jharkhand")),
              DropdownMenuItem(value: "Karnataka", child: Text("Karnataka")),
              DropdownMenuItem(value: "Kerala", child: Text("Kerala")),
              DropdownMenuItem(value: "Madhya Pradesh", child: Text("Madhya Pradesh")),
              DropdownMenuItem(value: "Maharashtra", child: Text("Maharashtra")),
              DropdownMenuItem(value: "Manipur", child: Text("Manipur")),
              DropdownMenuItem(value: "Meghalaya", child: Text("Meghalaya")),
              DropdownMenuItem(value: "Mizoram", child: Text("Mizoram")),
              DropdownMenuItem(value: "Nagaland", child: Text("Nagaland")),
              DropdownMenuItem(value: "Odisha", child: Text("Odisha")),
              DropdownMenuItem(value: "Punjab", child: Text("Punjab")),
              DropdownMenuItem(value: "Rajasthan", child: Text("Rajasthan")),
              DropdownMenuItem(value: "Sikkim", child: Text("Sikkim")),
              DropdownMenuItem(value:"Tamil Nadu",child :Text("Tamil Nadu")),
              DropdownMenuItem(value:"Telangana",child :Text("Telangana")),
              DropdownMenuItem(value: "Tripura", child: Text("Tripura")),
              DropdownMenuItem(value: "Uttar Pradesh", child: Text("Uttar Pradesh")),
              DropdownMenuItem(value: "Uttarakhand", child: Text("Uttarakhand")),
              DropdownMenuItem(value:"West Bengal",child :Text ("West Bengal")),
            ],
            onChanged: (value) {
              setState(() => state = value ?? "");
            },
          ),
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