import 'dart:convert';
import 'package:http/http.dart' as http;
import 'systems_mapping.dart';

class SystemsApi {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // ===============================
  // SYSTEMS (CNS, GI, etc.)
  // ===============================
  static Future<bool> saveSymptom({
    required String reportId,
    required String questionnaireSystem,
    required String symptomName,
    required String symptomPresent,
    String severity = "N/A",
    String? regimenType, //new
    int? durationWeeks,
  }) async {
    final systemEnum = SystemMapper.getSystemEnum(questionnaireSystem);

    final data = {
      "report_id": reportId,
      "system_name": systemEnum,
      "symptom_name": symptomName,
      "symptom_present": symptomPresent,
      "severity": severity,
      "duration_weeks": durationWeeks,  // new
      "regimen_type": regimenType ?? "FLD",
    };

    print('🔵 SENDING to FastAPI: ${data.toString()}');

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/systems'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      print('📱 API Response [${response.statusCode}]: ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ API Error: $e');
      return false;
    }
  }

  // ===============================
  // GENERAL SYMPTOMS
  // ===============================
  static Future<bool> saveGeneralSymptoms(Map<String, dynamic> data) async {
    print('🔵 SENDING GENERAL SYMPTOMS: ${data.toString()}');

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/general_symptoms'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      print('📱 GENERAL API Response [${response.statusCode}]: ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ GENERAL API Error: $e');
      return false;
    }
  }

  // ===============================
  // INVESTIGATIONS
  // ===============================
  static Future<bool> saveInvestigations(Map<String, dynamic> data) async {
    print('🔵 SENDING INVESTIGATIONS: ${data.toString()}');

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/investigations'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      print('📱 INVESTIGATIONS Response [${response.statusCode}]: ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ INVESTIGATIONS API Error: $e');
      return false;
    }
  }
  static Future<bool> saveRespiratoryReport({
  required String reportId,
  required String reportText,
  }) async {
  final response = await http.post(
    Uri.parse('$baseUrl/respiratory/save_report'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'report_id': reportId,
    
    }),
  );
  return response.statusCode == 200;
  }
  // Investigations for SLD (new)
  static Future<void>
saveInvestigationsSLD({

  required Map<String, dynamic>
      data,

}) async {

  try {

    print(
        "🔵 Sending SLD Investigations:");

    print(data);

    final response =
        await http.post(

      Uri.parse(
        "$baseUrl/investigations-sld",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode(data),
    );

    print(
        "📱 SLD Investigation Response: ${response.statusCode}");

    print(response.body);

    if (response.statusCode !=
        200) {

      throw Exception(
        "Failed to save SLD investigations",
      );
    }

  } catch (e) {

    print(
        "❌ SLD Investigation Error: $e");

    rethrow;
  }
}
// General symptoms for SLD (new)
//-------------------------------
 static Future<void>
saveGeneralSymptomsSLD({

  required Map<String, dynamic>
      data,

}) async {

  try {

    print(
        "🔵 Sending General Symptoms SLD:");

    print(data);

    final response =
        await http.post(

      Uri.parse(
        "$baseUrl/general-symptoms-sld",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode(data),
    );

    print(
        "📱 General Symptoms Response: ${response.statusCode}");

    print(response.body);

    if (response.statusCode !=
        200) {

      throw Exception(
        "Failed to save General Symptoms SLD",
      );
    }

  } catch (e) {

    print(
        "❌ General Symptoms Error: $e");

    rethrow;
  }
}

// ===========other side effects for SLD (new)=================
static Future<void> saveOtherSideEffects({

  required Map<String, dynamic> data,

}) async {

  final response = await http.post(

    Uri.parse(
      '$baseUrl/save-other-side-effects',
    ),

    headers: {
      'Content-Type': 'application/json',
    },

    body: jsonEncode(data),
  );

  print(
    "🔵 Sending Other Side Effects:\n$data",
  );

  print(
    "📱 Other Side Effects Response: ${response.statusCode}",
  );

  print(response.body);

  if (response.statusCode != 200) {

    throw Exception(
      'Failed to save Other Side Effects',
    );
  }
}
  // ===============================
  // NEW: Get all systems data for reports ✅
  // ===============================

    static Future<Map<String, Map<String, String>>> getAllSystemsData(String reportId) async {
        print('📡 Fetching ALL systems for report: $reportId');

       try {
    final response = await http.get(
      Uri.parse('$baseUrl/reports/$reportId'),
      headers: {'Content-Type': 'application/json'},
    );

    print('📱 getAllSystemsData Response [${response.statusCode}]: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
         final systems = data['systems'] ?? {};

      Map<String, Map<String, String>> result = {};

      systems.forEach((key, value) {

        // 🔥 HANDLE RESPIRATORY
        if (key == "Respiratory") {

          Map<String, String> resp = {
            "q1Answer": "",
            "q11Answer": "",
            "q12Weeks": "", // (temporary default)
            "q13Answer": "",
            "q14Answer": "",
            "q141Answer": "",
            "q142Answer": "",
            "q15Answer": "",
            "q16Answer": "",
          };

         for (var item in value) {
  final symptom = item['symptom'] ?? "";
  final severity = item['severity'] ?? "";

  print("🔹 Symptom: $symptom");

  //MAIN SYMPTOM BLOCK
         if (symptom == "Shortness of breath") {
         resp["q1Answer"] = "Yes";

    //severity mapping
             if (severity == "mild") {
                resp["q11Answer"] = "Mild - I can perform my usual daily activities";
                 } else if (severity == "moderate") {
                resp["q11Answer"] = "Moderate - It interferes with my daily activities";
                      } else if (severity == "severe") {
                   resp["q11Answer"] = "Severe - I have difficulty performing routine activities";
               }
                   resp["q12Weeks"] = item['duration_weeks']?.toString() ?? "";
                 }

  // followups
            if (symptom.contains("after medication")) {
              resp["q14Answer"] = "Yes";
             }

            if (symptom.contains("improved")) {
                resp["q141Answer"] = "Yes";
            }

             if (symptom.contains("returned")) {
               resp["q142Answer"] = "Yes";
              }
              }

          print("✅ FINAL RESP MAP: $resp");

          result[key] = resp;
        }
      });

      return result;
    }
  } catch (e) {
    print('❌ getAllSystemsData error: $e');
  }

  return {};
}
}