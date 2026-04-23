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
//Status: POSITIVE
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
  // ===============================
// 🔹 GI CAUSALITY
// ===============================
static String calculateGICausality(Map<String, String> g) {

  if (g["before"] == "Yes") return "UNLIKELY";

  if (g["after"] == "Yes") {
    if (g["improved"] == "Yes") {
      if (g["returned"] == "Yes") return "CERTAIN";
      return "PROBABLE";
    }
    return "POSSIBLE";
  }

  if (g["diet"] == "Yes" || g["other"] == "Yes") {
    return "CONDITIONAL";
  }

  return "UNKNOWN";
}
//CNS CAUSALITY
 static String calculateCNSCausality(Map<String, String> g) {

  if (g["before"] == "Yes") return "UNLIKELY";

  if (g["after"] == "Yes") {
    if (g["improved"] == "Yes") {
      if (g["returned"] == "Yes") return "CERTAIN";
      return "PROBABLE";
    }
    return "POSSIBLE";
  }

  if (g["condition"] == "Yes" || g["trigger"] == "Yes") {
    return "CONDITIONAL";
  }

  return "UNKNOWN";
}
// OCULAR CAUSALITY
static String calculateOcularCausality(Map<String, String> g) {

  // ❌ UNLIKELY (pre-existing condition)
  if (g["before"] == "Yes") return "UNLIKELY";

  // ✅ POSSIBLE / PROBABLE / CERTAIN
  if (g["after"] == "Yes") {

    if (g["improved"] == "Yes") {

      if (g["returned"] == "Yes") {
        return "CERTAIN";
      }

      return "PROBABLE";
    }

    return "POSSIBLE";
  }

  // ⚠️ CONDITIONAL (other explanations)
  if (g["condition"] == "Yes" || g["trigger"] == "Yes") {
    return "CONDITIONAL";
  }

  return "UNKNOWN";
}
  static String generateCNSReport(List<dynamic> list) {

  if (list.isEmpty) {
    return '''
CENTRAL NERVOUS SYSTEM SUMMARY
==============================
Status: NEGATIVE
No CNS symptoms reported.
''';
  }

  final grouped = buildCNSGroups(list);

  final StringBuffer r = StringBuffer();

  r.writeln('CENTRAL NERVOUS SYSTEM REPORT');
  r.writeln('==============================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final duration = data["duration"] ?? "";
    final causality = calculateCNSCausality(data);

    r.writeln('Symptom: ${_capitalize(symptom)}');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('Duration: ${duration.isEmpty ? "N/A" : "$duration weeks"}');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  });

  return r.toString();
}
//generate ocular report
static String generateOcularReport(List<dynamic> list) {

  if (list.isEmpty) {
    return '''
OCULAR INVOLVEMENT SUMMARY
=========================
Status: NEGATIVE
No ocular symptoms reported.
''';
  }

  final grouped = buildOcularGroups(list);

  final StringBuffer r = StringBuffer();

  r.writeln('OCULAR INVOLVEMENT REPORT');
  r.writeln('=========================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final duration = data["duration"] ?? "";
    final causality = calculateOcularCausality(data);

    r.writeln('Symptom: ${_capitalize(symptom)}');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('Duration: ${duration.isEmpty ? "N/A" : "$duration weeks"}');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  });

  return r.toString();
}
  // ===============================
// 🔹 STRING HELPER
// ===============================
static String _capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}
   static Map<String, Map<String, String>> buildGastroGroups(List<dynamic> giList) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in giList) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';
    final duration = item['duration_weeks'];

    String base = "";

    if (raw.contains("nausea")) base = "nausea";
    else if (raw.contains("vomiting")) base = "vomiting";
    else if (raw.contains("abdominal")) base = "abdominal pain";
    else if (raw.contains("constipation")) base = "constipation";
    else if (raw.contains("diarrhea")) base = "diarrhea";
    else if (raw.contains("gastritis")) base = "gastritis";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

   
    // ✅ ONLY exact match (main symptom)
if (raw == base || raw == "$base symptoms") {

  if (severity == "mild") g["severity"] = "GRADE 1";
  if (severity == "moderate") g["severity"] = "GRADE 2";
  if (severity == "severe") g["severity"] = "GRADE 3";
  if (severity == "life-threatening") g["severity"] = "GRADE 4";

  if (duration != null) {
    g["duration"] = duration.toString();
  }
}

    // ✅ causality flags
    if (raw.contains("after medication")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
    if (raw.contains("diet")) g["diet"] = "Yes";
    if (raw.contains("other")) g["other"] = "Yes";
  }

  print("✅ GROUPED GI: $grouped");
  return grouped;
}
  static Map<String, Map<String, String>> buildCNSGroups(List<dynamic> list) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';
    final duration = item['duration_weeks'];

    String base = "";

    if (raw.contains("numbness")) base = "numbness";
    else if (raw.contains("headache")) base = "headache";
    else if (raw.contains("seizure")) base = "seizure";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // MAIN symptom only
  if (
  (base == "numbness" &&
    (raw.startsWith("numbness/") || raw == "numbness")) ||

  (base == "headache" &&
    (raw == "headache" || raw == "headaches")) ||

  (base == "seizure" &&
    (raw == "seizure" || raw == "seizures"))
) {
  if (severity == "mild") g["severity"] = "GRADE 1";
  if (severity == "moderate") g["severity"] = "GRADE 2";
  if (severity == "severe") g["severity"] = "GRADE 3";
  if (severity == "life-threatening") g["severity"] = "GRADE 4";

  if (duration != null) {
    g["duration"] = duration.toString();
  }
}


    // causality flags
    if (raw.contains("after medication")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
    if (raw.contains("diabetes")) g["condition"] = "Yes";
    if (raw.contains("injury")) g["trigger"] = "Yes";
  }

  print("✅ GROUPED CNS: $grouped");
  return grouped;
}

static Map<String, Map<String, String>> buildOcularGroups(List<dynamic> list) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';
    final duration = item['duration_weeks'];

    String base = "";

    if (raw.contains("blurring") || raw.contains("vision")) base = "blurring vision";
    else if (raw.contains("color")) base = "color vision";
    else if (raw.contains("patchy")) base = "patchy vision";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // ✅ MAIN symptom ONLY (very important)
    if (
      (base == "blurring vision" && raw.contains("blurring")) ||
      (base == "color vision" && raw.contains("color")) ||
      (base == "patchy vision" && raw.contains("patchy"))
    ) {

      // severity mapping
      if (severity == "mild") g["severity"] = "GRADE 1";
      if (severity == "moderate") g["severity"] = "GRADE 2";
      if (severity == "severe") g["severity"] = "GRADE 3";

      // duration (optional for ocular)
      if (duration != null) {
        g["duration"] = duration.toString();
      }
    }

    // ✅ causality flags
    if (raw.contains("after medication")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("recurred") || raw.contains("returned")) g["returned"] = "Yes";
    if (raw.contains("eye condition")) g["condition"] = "Yes";
    if (raw.contains("strain") || raw.contains("light")) g["trigger"] = "Yes";
  }

  print("✅ GROUPED OCULAR: $grouped");
  return grouped;
}

   static String generateGastroReport(List<dynamic> giList) {

  if (giList.isEmpty) {
    return '''
GASTROINTESTINAL SYSTEM SUMMARY
==============================
//Status: NEGATIVE
No GI symptoms reported.
''';
  }

  final grouped = buildGastroGroups(giList);

  final StringBuffer r = StringBuffer();

  r.writeln('GASTROINTESTINAL SYSTEM REPORT');
  r.writeln('==============================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final duration = data["duration"] ?? "";
    final causality = calculateGICausality(data);

    r.writeln('Symptom: ${_capitalize(symptom)}');
   // r.writeln('Status: POSITIVE');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('Duration: ${duration.isEmpty ? "N/A" : "$duration weeks"}');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  });

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

      final giList = systems['Gastrointestinal'] ?? [];
      r.writeln(generateGastroReport(giList));
      r.writeln('');
    }
    if (systems.containsKey('Centralnervous')) {

  final List<dynamic> cnsList = systems['Centralnervous'] ?? [];

  r.writeln(generateCNSReport(cnsList));
  r.writeln('');
}
   if (systems.containsKey('Ocular')) {

  final List<dynamic> ocularList = systems['Ocular'] ?? [];

  r.writeln(generateOcularReport(ocularList));
  r.writeln('');
} 
return r.toString();
  }
  
}