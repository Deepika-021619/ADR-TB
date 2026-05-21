import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'drugdetails.dart';
import 'timer_widget.dart';

class StartReporterScreen extends StatefulWidget {
  final String portal;
  final String reportId;

  const StartReporterScreen({
    super.key,
    required this.portal,
    required this.reportId,
  });

  @override
  State<StartReporterScreen> createState() => _StartReporterScreenState();
}

class _StartReporterScreenState extends State<StartReporterScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController hospitalCtrl = TextEditingController();
  

  String? reporterType;
  String? rstate;
  bool isLoading = false;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> createReporterDetails() async {
    final name = nameCtrl.text.trim();
    final hospital = hospitalCtrl.text.trim();

    // this is for validation
    if (name.isEmpty) {
      _showError(" Reporter Name is required!");
      return;
    }
    if (hospital.isEmpty) {
      _showError(" Hospital name is required!");
      return;
    }
    if (reporterType == null) {
      _showError(" Please select reporter type");
      return;
    }
    if (rstate?.isEmpty?? true) {
      _showError(" Please select State");
      return;
    }
    

    setState(() => isLoading = true);

    try {
      final reporterResponse = await http.post(
       Uri.parse("http://127.0.0.1:8000/Reporter_details/reporter_details"),
        headers: { 
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "report_id": widget.reportId,
          "r_name": name,
          "r_type": reporterType,
          "hospital_address": hospital,
          "r_state": rstate,
        }),
      ).timeout(const Duration(seconds: 20));

      print("Reporter Status: ${reporterResponse.statusCode}");
      print("Reporter Response: ${reporterResponse.body}");

      if (reporterResponse.statusCode == 200 || reporterResponse.statusCode == 201) {

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DrugDetailsScreen(
        portal: widget.portal,
        reportId: widget.reportId,
      ),
    ),
  );

  // Optional: clear form
  nameCtrl.clear();
  hospitalCtrl.clear();

  setState(() {
    reporterType = null;
    rstate = null;
  });

} else {

        _showError("❌ Failed: Data already entered ");
      }
    } catch (e) {
      print("❌ ERROR: $e");
      _showError("❌ Network Error: Please try again later ");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporter Details - Report ${widget.reportId}"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: TimerWidget(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // the Report ID will be displayed on top
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    "Report ID: ${widget.reportId}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text("Enter reporter details below", 
                    style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // for name
            TextField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Reporter Name *",              
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            //dropdown for reporter type
            DropdownButtonFormField<String>(
              value: reporterType,
              hint: const Text ("Select Reporter Type *"),
              decoration: const InputDecoration(
                labelText: "Role of the reporter *",
                border: OutlineInputBorder(),
            ),
            items: const[
              DropdownMenuItem(value: "Physician", child: Text("Physician")),
              //DropdownMenuItem(value: "Pharmacist", child: Text("Pharmacist")),
              DropdownMenuItem(value: "Nurse", child: Text("Nurse")),
              DropdownMenuItem(value: "Other HCP", child: Text("Other HCP")),
            ],
            onChanged: (value) => setState(() => reporterType = value),
            ),
             const SizedBox(height: 15),

            

            //  for hospital name
            TextField(
              controller: hospitalCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Hospital Name *",
                
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // for state
            DropdownButtonFormField<String>(
            value: rstate,
            hint: const Text("Select State *"),
            decoration: InputDecoration(
              labelText: "State",
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
            onChanged: (value) => setState(() => rstate = value),
            ),
          
            const SizedBox(height: 25),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: createReporterDetails,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Save Reporter Details"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back to home"),
                  ),
          ],
        ),
      ),
    );
  }
}
