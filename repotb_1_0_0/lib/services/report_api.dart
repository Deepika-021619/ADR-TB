import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportApi {
  static const String baseUrl =
    'https://tb-adr-backend-baabb4bgecgebude.centralindia-01.azurewebsites.net';

  static Future<Map<String, dynamic>> getFullReport(String reportId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reports/$reportId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('Failed to load report: ${response.statusCode}');
  }
}