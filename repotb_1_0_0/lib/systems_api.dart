import 'dart:convert';
import 'package:http/http.dart' as http;
import 'systems_mapping.dart';  // ✅ FIXED

class SystemsApi {
  static const String baseUrl = "https://adr-backend-1dlb.onrender.com";  // ✅ FIXED
  
  static Future<bool> saveSymptom({
    required String reportId,
    required String questionnaireSystem,  // "RESPIRATORY SYSTEM"
    required String symptomName,
    required String symptomPresent,
    String severity = "N/A",
  }) async {
    final systemEnum = SystemMapper.getSystemEnum(questionnaireSystem);  // → "Respiratory"
    
    final data = {
      "report_id": reportId,
      "system_name": systemEnum,  // ✅ ENUM value: "Respiratory"
      "symptom_name": symptomName,
      "symptom_present": symptomPresent,
      "severity": severity,
    };
    
    print('🔵 SENDING to FastAPI: $data');  // ✅ Better debug
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/systems'),  // ✅ Full URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),  // ✅ Correct JSON encoding
      );
      
      print('📱 API Response [${response.statusCode}]: ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ API Error: $e');
      return false;
    }
  }
}
