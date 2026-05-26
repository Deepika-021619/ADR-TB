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
static String _calculateRespiratoryCausality(
    Map<String, String> data) {

  List<String> results = [];

  // 1.3 → UNLIKELY
  if (data['q13Answer'] == 'Yes') {
    results.add('UNLIKELY');
  }

  // 1.4 → POSSIBLE / PROBABLE / CERTAIN
  if (data['q14Answer'] == 'Yes') {

    // 1.4.1
    if (data['q141Answer'] == 'Yes') {

      // 1.4.2
      if (data['q142Answer'] == 'Yes') {
        results.add('CERTAIN');
      } else {
        results.add('PROBABLE');
      }

    } else {
      results.add('POSSIBLE');
    }
  }

  // 1.5 + 1.6 → CONDITIONAL
  if (data['q15Answer'] == 'Yes' ||
      data['q16Answer'] == 'Yes') {

    results.add('CONDITIONAL');
  }

  if (results.isEmpty) {
    return 'UNKNOWN';
  }

  return results.join(', ');
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

// SKIN CAUSALITY
   static String calculateSkinCausality(Map<String, String> g) {

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
//psychiatric causality
  static String calculatePsychiatricCausality(Map<String, String> g) {

  if (g["before"] == "Yes") return "UNLIKELY";

  if (g["after"] == "Yes") {
    if (g["improved"] == "Yes") {
      if (g["returned"] == "Yes") return "CERTAIN";
      return "PROBABLE";
    }
    return "POSSIBLE";
  }

  return "UNKNOWN";
}
// MUSCULOSKELETAL CAUSALITY
  static String calculateMusculoskeletalCausality(Map<String, String> g) {

  if (g["before"] == "Yes") return "UNLIKELY";

  if (g["after"] == "Yes") {
    if (g["improved"] == "Yes") {
      if (g["returned"] == "Yes") return "CERTAIN";
      return "PROBABLE";
    }
    return "POSSIBLE";
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

  // ✅ ADD THIS BLOCK (CRITICAL FIX)
  if (grouped.isEmpty) {
    return '''
OCULAR INVOLVEMENT SUMMARY
=========================
Status: NEGATIVE
No ocular symptoms reported.
''';
  }

  final StringBuffer r = StringBuffer();

  r.writeln('OCULAR INVOLVEMENT REPORT');
  r.writeln('=========================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final causality = calculateOcularCausality(data);

    r.writeln('Symptom: ${_capitalize(symptom)}');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  });

  return r.toString();
}
// SKIN REPORT
   static String generateSkinReport(List<dynamic> list) {

  if (list.isEmpty) {
    return '''
SKIN AND SUBCUTANEOUS SYSTEM SUMMARY
===================================
Status: NEGATIVE
No skin symptoms reported.
''';
  }

  final grouped = buildSkinGroups(list);

  final StringBuffer r = StringBuffer();

  r.writeln('SKIN AND SUBCUTANEOUS SYSTEM REPORT');
  r.writeln('===================================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final causality = calculateSkinCausality(data);

    r.writeln('Symptom: ${_capitalize(symptom)}');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  });

  return r.toString();
}
// PSYCHIATRIC REPORT
  static String generatePsychiatricReport(List<dynamic> list) {

  if (list.isEmpty) {
    return '''
PSYCHIATRIC DISORDERS SUMMARY
=============================
Status: NEGATIVE
No psychiatric symptoms reported.
''';
  }

  final grouped = buildPsychiatricGroups(list);

  final StringBuffer r = StringBuffer();

  r.writeln('PSYCHIATRIC DISORDERS REPORT');
  r.writeln('============================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final causality = calculatePsychiatricCausality(data);

    r.writeln('Symptom: ${_capitalize(symptom)}');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('Causality: $causality');
    r.writeln('------------------------');
    r.writeln('');
  });

  return r.toString();
}
// MUSCULOSKELETAL REPORT
   static String generateMusculoskeletalReport(List<dynamic> list) {

  if (list.isEmpty) {
    return '''
MUSCULOSKELETAL SYSTEM SUMMARY
==============================
Status: NEGATIVE
No musculoskeletal symptoms reported.
''';
  }

  final grouped = buildMusculoskeletalGroups(list);

  final StringBuffer r = StringBuffer();

  r.writeln('MUSCULOSKELETAL SYSTEM REPORT');
  r.writeln('==============================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final duration = data["duration"] ?? "";
    final causality = calculateMusculoskeletalCausality(data);

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
// GENITOURINARY REPORT
static String generateGenitourinaryReport(List<dynamic> list) {

  if (list.isEmpty) {
    return '''
GENITOURINARY SYSTEM SUMMARY
===========================
Status: NEGATIVE
No genitourinary symptoms reported.
''';
  }

  final grouped = buildGenitourinaryGroups(list);

  final StringBuffer r = StringBuffer();

  r.writeln('GENITOURINARY SYSTEM REPORT');
  r.writeln('===========================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final duration = data["duration"] ?? "";
    final causality = calculateMusculoskeletalCausality(data);

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
// general report
static String generateGeneralReport(Map<String, dynamic> gData) {

  if (gData == null || gData.isEmpty) {
    return '''
GENERAL SYMPTOMS SUMMARY
========================
Status: NEGATIVE
No general symptoms reported.
''';
  }

  final grouped = buildGeneralGroups(gData);

  final StringBuffer r = StringBuffer();

  r.writeln('GENERAL SYMPTOMS REPORT');
  r.writeln('========================');

  grouped.forEach((symptom, data) {

    final severity = data["severity"] ?? "GRADE UNKNOWN";
    final duration = data["duration"] ?? "";
    final causality = calculateGICausality(data); // reuse logic

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
 // INVESTIGATIONS REPORT
 static String generateInvestigationsReport(Map<String, dynamic> data) {

  if (data == null || data.isEmpty) {
    return '''
INVESTIGATIONS SUMMARY
======================
Status: NOT AVAILABLE
''';
  }

  final StringBuffer r = StringBuffer();

  r.writeln('INVESTIGATIONS REPORT');
  r.writeln('======================');

  final grouped = buildInvestigationsGroups(data);

  grouped.forEach((symptom, g) {

    final severity = g["severity"] ?? "GRADE UNKNOWN";

    r.writeln('Symptom: ${_capitalize(symptom)}');
    r.writeln('------------------------');
    r.writeln('Severity: $severity');
    r.writeln('------------------------');
    r.writeln('');
  });

  return r.toString();
}

//general symptoms grouping
static Map<String, Map<String, String>> buildGeneralGroups(Map<String, dynamic> gData) {

  final Map<String, Map<String, String>> grouped = {};

  // =========================
  // 🔸 MALAISE
  // =========================
  if ((gData["malaise_present"] ?? "").toLowerCase() == "yes") {

    final g = <String, String>{};

    if (gData["malaise_severity"] == "mild") g["severity"] = "GRADE 1";
    if (gData["malaise_severity"] == "moderate") g["severity"] = "GRADE 2";
    if (gData["malaise_severity"] == "severe") g["severity"] = "GRADE 3";

    if (gData["malaise_duration_weeks"] != null) {
      g["duration"] = gData["malaise_duration_weeks"].toString();
    }

    if ((gData["malaise_onset"] ?? "").toLowerCase() == "yes") g["after"] = "Yes";
    if ((gData["malaise_pre_existing"] ?? "").toLowerCase() == "yes") g["before"] = "Yes";
    if ((gData["malaise_improved"] ?? "").toLowerCase() == "yes") g["improved"] = "Yes";
    if ((gData["malaise_recurred"] ?? "").toLowerCase() == "yes") g["returned"] = "Yes";

    grouped["malaise"] = g;
  }

  // =========================
  // 🔸 FEVER
  // =========================
  if ((gData["fever_present"] ?? "").toLowerCase() == "yes") {

    final g = <String, String>{};

    if (gData["fever_severity"] == "mild") g["severity"] = "GRADE 1";
    if (gData["fever_severity"] == "moderate") g["severity"] = "GRADE 2";
    if (gData["fever_severity"] == "severe") g["severity"] = "GRADE 3";

    // duration (string → number safe)
    if (gData["fever_duration"] != null) {
      g["duration"] = gData["fever_duration"].toString();
    }

    if ((gData["fever_onset"] ?? "").toLowerCase() == "yes") g["after"] = "Yes";
    if ((gData["fever_pre_existing"] ?? "").toLowerCase() == "yes") g["before"] = "Yes";
    if ((gData["fever_improved"] ?? "").toLowerCase() == "yes") g["improved"] = "Yes";
    if ((gData["fever_recurred"] ?? "").toLowerCase() == "yes") g["returned"] = "Yes";

    grouped["fever"] = g;
  }

  // =========================
  // 🔸 FATIGUE
  // =========================
  if ((gData["fatigue_present"] ?? "").toLowerCase() == "yes") {

    final g = <String, String>{};

    if (gData["fatigue_severity"] == "mild") g["severity"] = "GRADE 1";
    if (gData["fatigue_severity"] == "moderate") g["severity"] = "GRADE 2";
    if (gData["fatigue_severity"] == "severe") g["severity"] = "GRADE 3";

    if (gData["fatigue_duration_weeks"] != null) {
      g["duration"] = gData["fatigue_duration_weeks"].toString();
    }

    if ((gData["fatigue_onset"] ?? "").toLowerCase() == "yes") g["after"] = "Yes";
    if ((gData["fatigue_pre_existing"] ?? "").toLowerCase() == "yes") g["before"] = "Yes";
    if ((gData["fatigue_improved"] ?? "").toLowerCase() == "yes") g["improved"] = "Yes";
    if ((gData["fatigue_recurred"] ?? "").toLowerCase() == "yes") g["returned"] = "Yes";

    // conditional flags
    if ((gData["fatigue_lifestyle"] ?? "").toLowerCase() == "yes") g["condition"] = "Yes";

    grouped["fatigue"] = g;
  }

  // =========================
  // 🔸 ORANGE DISCOLORATION
  // =========================
  if ((gData["discoloration_present"] ?? "").toLowerCase() == "yes") {

    final g = <String, String>{};


    grouped["orange discoloration"] = g;
  }

  print("✅ GROUPED GENERAL: $grouped");
  return grouped;
}
// INVESTIGATIONS GROUPING
   static Map<String, Map<String, String>> buildInvestigationsGroups(Map<String, dynamic> d) {

  final Map<String, Map<String, String>> grouped = {};

  // =========================
  // 🔹 AST
  // =========================
  if (
  d["lft_done"] == "Yes" &&
  d["ast_value"] != null &&
  d["ast_uln"] != null &&
  d["ast_uln"] > 0
) {

    final ratio = d["ast_value"] / d["ast_uln"];

    grouped["AST elevation"] = {
      "severity": _gradeFromRatio(ratio, type: "liver")
    };
  }

  // =========================
  // 🔹 ALT
  // =========================
  if (
  d["lft_done"] == "Yes" &&
  d["alt_value"] != null &&
  d["alt_uln"] != null &&
  d["alt_uln"] > 0
) {

    final ratio = d["alt_value"] / d["alt_uln"];

    grouped["ALT elevation"] = {
      "severity": _gradeFromRatio(ratio, type: "liver")
    };
  }

  // =========================
  // 🔹 BILIRUBIN
  // =========================
 if (
  d["lft_done"] == "Yes" &&
  d["bilirubin_total"] != null &&
  d["bilirubin_total_uln"] != null &&
  d["bilirubin_total_uln"] > 0
) {

    final ratio = d["bilirubin_total"] / d["bilirubin_total_uln"];

    grouped["Bilirubin elevation"] = {
      "severity": _gradeFromRatio(ratio, type: "bilirubin")
    };
  }

  // =========================
  // 🔹 HEMOGLOBIN
  // =========================
  if (
  d["uric_acid_done"] == "Yes" &&
  d["uric_acid_value"] != null &&
  d["uric_acid_uln"] != null &&
  d["uric_acid_uln"] > 0
) {

    final hgb = d["hgb_value"];

    grouped["Hemoglobin decrease"] = {
      "severity": _gradeHemoglobin(hgb)
    };
  }

  // =========================
  // 🔹 PLATELETS
  // =========================
  if (d["platelet_done"] == "Yes" && d["platelet_value"] != null) {

    final plt = d["platelet_value"];

    grouped["Platelet decrease"] = {
      "severity": _gradePlatelets(plt)
    };
  }

  // =========================
  // 🔹 URIC ACID
  // =========================
  if (d["uric_acid_done"] == "Yes" && d["uric_acid_value"] != null && d["uric_acid_uln"] != null) {

    final ratio = d["uric_acid_value"] / d["uric_acid_uln"];

    grouped["Uric acid elevation"] = {
      "severity": _gradeFromRatio(ratio, type: "uric")
    };
  }

  return grouped;
}

  // ===============================
// 🔹 STRING HELPER
// ===============================
static String _capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}
//investigations helper
  static String _gradeFromRatio(double ratio, {required String type}) {

  if (type == "liver") {
    if (ratio > 20) return "GRADE 4";
    if (ratio > 5) return "GRADE 3";
    if (ratio > 3) return "GRADE 2";
    if (ratio > 1) return "GRADE 1";
  }

  if (type == "bilirubin") {
    if (ratio > 10) return "GRADE 4";
    if (ratio > 3) return "GRADE 3";
    if (ratio > 1.5) return "GRADE 2";
    if (ratio > 1) return "GRADE 1";
  }

  if (type == "uric") {
    if (ratio > 3) return "GRADE 4";
    if (ratio > 2) return "GRADE 3";
    if (ratio > 1.5) return "GRADE 2";
    if (ratio > 1) return "GRADE 1";
  }

  return "GRADE UNKNOWN";
}


static String _gradeHemoglobin(double hgb) {
  if (hgb < 6.5) return "GRADE 4";
  if (hgb < 8) return "GRADE 3";
  if (hgb < 10) return "GRADE 2";
  return "GRADE 1";
}


static String _gradePlatelets(double plt) {
  if (plt < 25000) return "GRADE 4";
  if (plt < 50000) return "GRADE 3";
  if (plt < 75000) return "GRADE 2";
  return "GRADE 1";
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
  if (severity == "life threatening") g["severity"] = "GRADE 4";

  if (duration != null) {
    g["duration"] = duration.toString();
  }
}

    // ✅ causality flags
    if (raw.contains("after")) g["after"] = "Yes";
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
  if (severity == "life threatening") g["severity"] = "GRADE 4";

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
  
if (list.isEmpty) return {};

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {
     if ((item['symptom_present'] ?? '').toLowerCase() != 'yes') {
      continue;
    }

    final raw = (item['symptom'] ?? '').toLowerCase().trim();
    final severity = item['severity'] ?? '';
    

    String base = "";

    if (raw.contains("color")) base = "color vision";
    else if (raw.contains("patchy")) base = "patchy vision";
    else if (raw.contains("blurring") || raw.contains("decrease")) base = "blurring vision";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // ✅ MAIN symptom ONLY (very important)
    if (
  (base == "blurring vision" && raw == "blurring/decrease vision") ||

  (base == "color vision" && raw == "color vision change") ||

  (base == "patchy vision" && raw == "patchy vision loss")
) {

  // 🔥 PRIORITY: Grade 0 (must come first)
  if (raw.contains("Grade 0")) {
    g["severity"] = "GRADE 0";
  }

  // 🔹 Normal mapping (only if not Grade 0)
  else {
    if (severity == "mild") g["severity"] = "GRADE 1";
    if (severity == "moderate") g["severity"] = "GRADE 2";
    if (severity == "severe") g["severity"] = "GRADE 3";
    if (severity == "life threatening") g["severity"] = "GRADE 4";
  }
}

    // ✅ causality flags
    if (raw.contains("after medication")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
    if (raw.contains("eye condition")) g["condition"] = "Yes";
    if (raw.contains("strain") || raw.contains("light")) g["trigger"] = "Yes";
  }

  print("✅ GROUPED OCULAR: $grouped");
  return grouped;
}
//skin grouping
   static Map<String, Map<String, String>> buildSkinGroups(List<dynamic> list) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';

    String base = "";

    if (raw.contains("rash")) base = "rash";
    else if (raw.contains("itch")) base = "itching";
    else if (raw.contains("jaundice") || raw.contains("yellow")) base = "jaundice";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // ✅ MAIN symptom ONLY
    if (
      (base == "rash" && raw == "rash") ||
      (base == "itching" && raw == "itching") ||
      (base == "jaundice" && raw == "jaundice")
    ) {
      if (severity == "mild") g["severity"] = "GRADE 1";
      if (severity == "moderate") g["severity"] = "GRADE 2";
      if (severity == "severe") g["severity"] = "GRADE 3";
      if (severity == "life threatening") g["severity"] = "GRADE 4";
    }

    // ✅ causality flags
    if (raw.contains("after")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
    if (raw.contains("allergy")) g["condition"] = "Yes";
    if (raw.contains("trigger")) g["trigger"] = "Yes";
  }

  print("✅ GROUPED SKIN: $grouped");
  return grouped;
}  
  static Map<String, Map<String, String>> buildPsychiatricGroups(List<dynamic> list) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';

    String base = "";

    if (raw.contains("depression")) base = "depression";
    else if (raw.contains("psychosis")) base = "psychosis";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // MAIN symptom
    if (raw == base) {
      if (severity == "mild") g["severity"] = "GRADE 1";
      if (severity == "moderate") g["severity"] = "GRADE 2";
      if (severity == "severe") g["severity"] = "GRADE 3";
      if (severity == "life threatening") g["severity"] = "GRADE 4";
    }

    // causality flags
    if (raw.contains("after")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
  }

  print("✅ GROUPED PSYCHIATRIC: $grouped");
  return grouped;
}
// MUSCULOSKELETAL GROUPING
  static Map<String, Map<String, String>> buildMusculoskeletalGroups(List<dynamic> list) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';
    final duration = item['duration_weeks'];

    String base = "";

    if (raw.contains("joint pain")) base = "joint pain";
    else if (raw.contains("arthritis")) base = "arthritis";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // MAIN symptom
    if (raw == base) {
      if (severity == "mild") g["severity"] = "GRADE 1";
      if (severity == "moderate") g["severity"] = "GRADE 2";
      if (severity == "severe") g["severity"] = "GRADE 3";

      if (duration != null) {
        g["duration"] = duration.toString();
      }
    }

    // causality flags
    if (raw.contains("after")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
  }

  print("✅ GROUPED MSK: $grouped");
  return grouped;
}
  //genitourinary grouping
  static Map<String, Map<String, String>> buildGenitourinaryGroups(List<dynamic> list) {

  final Map<String, Map<String, String>> grouped = {};

  for (var item in list) {

    final raw = (item['symptom'] ?? '').toLowerCase();
    final severity = item['severity'] ?? '';
    final duration = item['duration_weeks'];

    String base = "";

    if (raw.contains("hematuria")) base = "hematuria";
    else if (raw.contains("flank")) base = "flank pain";
    else if (raw.contains("frequency")) base = "urinary frequency";

    if (base.isEmpty) continue;

    grouped.putIfAbsent(base, () => {});
    final g = grouped[base]!;

    // MAIN
    if (raw == base || raw.contains(base)) {
      if (severity == "mild") g["severity"] = "GRADE 1";
      if (severity == "moderate") g["severity"] = "GRADE 2";
      if (severity == "severe") g["severity"] = "GRADE 3";
      if (severity == "life threatening") g["severity"] = "GRADE 4";

      if (duration != null) {
        g["duration"] = duration.toString();
      }
    }

    // causality
    if (raw.contains("after")) g["after"] = "Yes";
    if (raw.contains("pre-existing")) g["before"] = "Yes";
    if (raw.contains("improved")) g["improved"] = "Yes";
    if (raw.contains("returned")) g["returned"] = "Yes";
  }

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
final List<dynamic> systemsList =
    reportData['systems'] ?? [];

Map<String, List<dynamic>> systems = {};

for (var item in systemsList) {

  final systemName = item['system_name'];

  if (systemName == null) continue;

  systems.putIfAbsent(systemName, () => []);

  systems[systemName]!.add({
    'symptom': item['symptom_name'],
    'symptom_present': item['symptom_present'],
    'severity': item['severity'],
    'duration_weeks': item['duration_weeks'],
  });
}

print("🔥 GROUPED SYSTEMS: $systems");

print("🔥 SYSTEMS: $systems");

   if (systems.containsKey('Respiratory')) {

  final List<dynamic> respList =
    systems['Respiratory'] ?? [];

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

  final list = systems['Ocular'] ?? [];

  // ✅ FILTER ONLY REAL SYMPTOMS
  final valid = list.where((item) =>
      (item['symptom_present'] ?? '').toLowerCase() == 'yes'
  ).toList();

  // ✅ ONLY PRINT IF DATA EXISTS
  if (valid.isNotEmpty) {
    r.writeln(generateOcularReport(valid));
    r.writeln('');
  }
}
   if (systems.containsKey('SkinSubcutaneous')) {
  final skinList = systems['SkinSubcutaneous'] ?? [];
  r.writeln(generateSkinReport(skinList));
  r.writeln('');
}
  if (systems.containsKey('Psychiatric')) {

  final List<dynamic> psychList = systems['Psychiatric'] ?? [];

  r.writeln(generatePsychiatricReport(psychList));
  r.writeln('');
}
   if (systems.containsKey('Musculoskeletal')) {
  final list = systems['Musculoskeletal'] ?? [];
  r.writeln(generateMusculoskeletalReport(list));
  r.writeln('');
}
  if (systems.containsKey('Genitourinary')) {
  final list = systems['Genitourinary'] ?? [];
  r.writeln(generateGenitourinaryReport(list));
}
  final g = reportData['general'];

bool hasGeneral =
    g != null &&
    (
      (g['malaise_present']?.toLowerCase() == 'yes') ||
      (g['fever_present']?.toLowerCase() == 'yes') ||
      (g['fatigue_present']?.toLowerCase() == 'yes') ||
      (g['discoloration_present']?.toLowerCase() == 'yes') ||
      ((g['other_symptoms'] ?? '').toString().trim().isNotEmpty)
    );

if (hasGeneral) {
  r.writeln(generateGeneralReport(g));
  r.writeln('');
}
final inv = reportData["investigations"];

bool hasInvestigationData =
    inv != null &&
    (
      inv["lft_done"] == "Yes" ||
      inv["hgb_done"] == "Yes" ||
      inv["platelet_done"] == "Yes" ||
      inv["uric_acid_done"] == "Yes"
    );

if (hasInvestigationData) {
  r.writeln(generateInvestigationsReport(inv));
}


return r.toString();
  }
  
}