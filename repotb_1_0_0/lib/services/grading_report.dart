String centerText(String text, {int width = 60}) {
  final padding = ((width - text.length) / 2).floor();
  return ' ' * (padding > 0 ? padding : 0) + text;
}
class GradingReportGenerator {

  // ===============================
  // 🔹 RESPIRATORY REPORT
  // ===============================
  static String generateRespiratoryReport(Map<String, String> data) {

    // 🔴 NEGATIVE CASE
    if (data['q1Answer'] != 'Yes') {
      return '''
RESPIRATORY SYSTEM SUMMARY
=========================
Status: NEGATIVE
No new/worsening shortness of breath reported.
''';
    }

    // 🔹 Severity
    String severityGrade;
    switch (data['q11Answer']) {
      case 'Mild - I can perform my usual daily activities':
        severityGrade = 'GRADE 1 (Mild)';
        break;
      case 'Moderate - It interferes with my daily activities':
        severityGrade = 'GRADE 2 (Moderate)';
        break;
      case 'Severe - I have difficulty performing routine activities':
        severityGrade = 'GRADE 3 (Severe)';
        break;
      default:
        severityGrade = 'GRADE UNKNOWN';
    }

    // 🔹 Duration (safe handling)
    final duration = (data['q12Weeks'] ?? "0").trim();

    // 🔹 Causality
    final causality = _calculateRespiratoryCausality(data);

    return '''
RESPIRATORY SYSTEM REPORT

Symptom: Shortness of Breath
Status: POSITIVE
------------------------
Severity: $severityGrade
Duration: $duration weeks
Causality: $causality
------------------------
''';


  }

  // ===============================
  // 🔹 CAUSALITY LOGIC
  // ===============================
  static String _calculateRespiratoryCausality(Map<String, String> data) {

    if (data['q13Answer'] == 'Yes') return 'UNLIKELY';

    if (data['q14Answer'] == 'Yes') {
      if (data['q141Answer'] == 'Yes') {
        if (data['q142Answer'] == 'Yes') return 'CERTAIN';
        return 'PROBABLE';
      }
      return 'POSSIBLE';
    }

    if (data['q15Answer'] == 'Yes' || data['q16Answer'] == 'Yes') {
      return 'CONDITIONAL';
    }

    return 'UNKNOWN';
  }
    static String generateGastroReport(List<dynamic> giList) {

   if (giList.isEmpty) {
    return '''
GASTROINTESTINAL SYSTEM SUMMARY
==============================
Status: NEGATIVE
No GI symptoms reported.
''';
  }
  final StringBuffer r = StringBuffer();

  r.writeln('GASTROINTESTINAL SYSTEM REPORT');
  r.writeln('==============================');

  for (var item in giList) {

    final symptom = item['symptom'] ?? '';
    final severity = item['severity'] ?? 'unknown';
    final duration = item['duration_weeks'];
    // 🔹 severity mapping
    String grade = "GRADE UNKNOWN";
    if (severity == "mild") grade = "GRADE 1";
    if (severity == "moderate") grade = "GRADE 2";
    if (severity == "severe") grade = "GRADE 3";

    // 🔹 causality (simple logic for now)
    String causality = "UNKNOWN";

    if (symptom.toLowerCase().contains("after medication")) {
      causality = "POSSIBLE";
    }
    if (symptom.toLowerCase().contains("improved")) {
      causality = "PROBABLE";
    }
    if (symptom.toLowerCase().contains("returned")) {
      causality = "CERTAIN";
    }

    r.writeln('Symptom: $symptom');
    r.writeln('Status: POSITIVE');
    r.writeln('------------------------');
    r.writeln('Severity: $grade');
    r.writeln('Duration: ${duration ?? "N/A"} weeks');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  }

  return r.toString();
}

    

   static Map<String, String> buildGastroMap(List<dynamic> giList) {

    final Map<String, String> gi = {};

    for (var item in giList) {
      final symptom = (item['symptom'] ?? '').toLowerCase();
      final severity = item['severity'] ?? '';
      final duration = item['duration_weeks'];

      print("🔹 GI Symptom: $symptom");

      if (symptom.contains("nausea")) {
        gi["q2Answer"] = "Yes";

        if (symptom.startsWith("nausea")) {
          if (severity == "mild") gi["q21Answer"] = "GRADE 1";
          if (severity == "moderate") gi["q21Answer"] = "GRADE 2";
          if (severity == "severe") gi["q21Answer"] = "GRADE 3";

          gi["q22Weeks"] = duration?.toString() ?? "";
        }

        if (symptom.contains("after medication")) gi["q23Answer"] = "Yes";
        if (symptom.contains("pre-existing")) gi["q24Answer"] = "Yes";
        if (symptom.contains("improved")) gi["q25Answer"] = "Yes";
        if (symptom.contains("returned")) gi["q26Answer"] = "Yes";
        if (symptom.contains("diet")) gi["q27Answer"] = "Yes";
        if (symptom.contains("other")) gi["q28Answer"] = "Yes";
      }
    }

    print("✅ FINAL GI MAP: $gi");
    return gi;
  }
  // ===============================
  // 🔹 FULL REPORT
  // ===============================
  String generateFullReport({
    required Map<String, dynamic> reportData,
  }) {

    print("🔥 FULL reportData: $reportData");
    print("🔥 SYSTEMS: ${reportData['systems']}");

    final StringBuffer r = StringBuffer();

   
    // ===============================
    // REPORTER
    // ===============================
    if (reportData.containsKey('reporter')) {
      final rep = reportData['reporter'];
      r.writeln(centerText('REPORTER DETAILS'));
      r.writeln('Reporter name: ${rep['name'] ?? ""}');
      r.writeln('Role: ${rep['role'] ?? ""}');
      r.writeln('Hospital name: ${rep['hospital_address'] ?? ""}');
      r.writeln('State: ${rep['state'] ?? ""}');
      r.writeln('');
    }

    // ===============================
    // PATIENT
    // ===============================
    if (reportData.containsKey('patient')) {
      final p = reportData['patient'];
      r.writeln(centerText('PATIENT DETAILS'));
      
      r.writeln('Patient name: ${p['name'] ?? ""}');
      r.writeln('Patient ID: ${p['p_id'] ?? ""}');
      r.writeln('Nikshay ID: ${p['nik_id'] ?? ""}');
      r.writeln('Gender: ${p['gender'] ?? ""}');
      r.writeln('State: ${p['state'] ?? ""}');
      r.writeln('');
    }

    // ===============================
    // TREATMENT
    // ===============================
    if (reportData.containsKey('treatment')) {
      final t = reportData['treatment'];
      r.writeln(centerText('TREATMENT DETAILS'));
     
      r.writeln('Age (years): ${t['age_years'] ?? ""}');
      r.writeln('Height (cm): ${t['height_cm'] ?? ""}');
      r.writeln('Weight (kg): ${t['weight_kg'] ?? ""}');
      if (t['tb_start_date'] != null && t['tb_start_date'].toString().isNotEmpty) {
       r.writeln('Date of TB treatment initiation: ${t['tb_start_date']}');
       }
      r.writeln('Treatment type: ${t['treatment_name'] ?? ""}');
      r.writeln('');
    }

    // ===============================
    // DRUG DATA
    // ===============================
    if (reportData.containsKey('drug_details')) {
      final d = reportData['drug_details'];
      r.writeln(centerText('DRUG DATA'));
      
      r.writeln('Drug regimen: ${d['drug_regimen'] ?? ""}');
      r.writeln('Time since combination taken: ${d['time_since_value'] ?? ""} ${d['time_since_unit'] ?? ""}');
      if (d['is_fdc'] != null && d['is_fdc'].toString().isNotEmpty) {
      r.writeln('Are you taking FDC? : ${d['is_fdc']}');
    }
      r.writeln('Brand name: ${d['brand_name'] ?? ""}');
      r.writeln('Batch number: ${d['batch_number'] ?? ""}');
      r.writeln('Dose description: ${d['dose_description'] ?? ""}');
      r.writeln('Tablet frequency: ${d['tablet_frequency'] ?? ""}');
      r.writeln('All drugs oral? : ${d['oral_only'] ?? ""}');
      r.writeln('');
    }

    // ===============================
    // ADR
   { // ===============================
   r.writeln('');
    }

    // ===============================
    // SYSTEMS
    // ===============================
    final systems = reportData['systems'] ?? {};

    print("🔥 SYSTEM KEYS: ${systems.keys}");

   if (systems.containsKey('Respiratory')) {

  final List<dynamic> respList = systems['Respiratory'];

  Map<String, String> resp = {};

  for (var item in respList) {
    final symptom = item['symptom'] ?? '';
    final severity = item['severity'] ?? '';
    final duration = item['duration_weeks'];

    print("🔹 Symptom: $symptom");

    // MAIN symptom
    if (symptom == "Shortness of breath") {
      resp["q1Answer"] = "Yes";

      // severity mapping
      if (severity == "mild") {
        resp["q11Answer"] =
            "Mild - I can perform my usual daily activities";
      } else if (severity == "moderate") {
        resp["q11Answer"] =
            "Moderate - It interferes with my daily activities";
      } else if (severity == "severe") {
        resp["q11Answer"] =
            "Severe - I have difficulty performing routine activities";
      }

      // duration mapping
      resp["q12Weeks"] = duration?.toString() ?? "";
    }

    if (symptom.toLowerCase().contains("after medication")) {
  resp["q14Answer"] = "Yes";
}
    if (symptom.toLowerCase().contains("improved")) {
  resp["q141Answer"] = "Yes";
}

if (symptom.toLowerCase().contains("returned")) {
  resp["q142Answer"] = "Yes";
}
  }

  // defaults (VERY IMPORTANT)
  resp["q13Answer"] ??= "No";
  resp["q15Answer"] ??= "No";
  resp["q16Answer"] ??= "No";

  print("✅ FINAL RESP MAP: $resp");

  r.writeln(generateRespiratoryReport(resp));
  r.writeln('');
}
 if (systems.containsKey('Gastrointestinal')) {

      final List<dynamic> giList = systems['Gastrointestinal'] ?? [];

      final gastroList = systems['Gastrointestinal'] ?? [];
      r.writeln(generateGastroReport(gastroList));
      r.writeln('');
    }

    return r.toString();
    
  }
  
}