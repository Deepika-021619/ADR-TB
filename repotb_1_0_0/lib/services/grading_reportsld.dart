class GradingReportSLD {

  // =========================================================
  // SEVERITY MAPPER
  // =========================================================

  static Map<String, dynamic> mapSeverity(String severity) {

    switch (severity.toLowerCase()) {

      case 'asymptomatic':
        return {
          'grade': 0,
          'label': 'Grade 0 (Asymptomatic)',
        };

      case 'mild':
        return {
          'grade': 1,
          'label': 'Grade 1 (Mild)',
        };

      case 'moderate':
        return {
          'grade': 2,
          'label': 'Grade 2 (Moderate)',
        };

      case 'severe':
        return {
          'grade': 3,
          'label': 'Grade 3 (Severe)',
        };

      case 'life threatening':
        return {
          'grade': 4,
          'label': 'Grade 4 (Life-threatening)',
        };

      case 'death':
        return {
          'grade': 5,
          'label': 'Grade 5 (Death)',
        };

      default:
        return {
          'grade': -1,
          'label': 'Unknown',
        };
    }
  }

  // =========================================================
  // CAUSALITY ENGINE
  // =========================================================

static String calculateCausality({

  required bool afterMedication,

  required bool improvedAfterStopping,

  required bool returnedAfterRestart,

  required bool existedBefore,
}) {

  // ===================================
  // CERTAIN
  // ===================================

  if (

      afterMedication &&

      improvedAfterStopping &&

      returnedAfterRestart

  ) {

    return "Certain";
  }

  // ===================================
  // PROBABLE
  // ===================================

  if (

      afterMedication &&

      improvedAfterStopping

  ) {

    return "Probable";
  }

  // ===================================
  // POSSIBLE
  // ===================================

  if (afterMedication) {

    return "Possible";
  }

  // ===================================
  // UNLIKELY
  // ===================================

  if (existedBefore) {

    return "Unlikely";
  }

  // ===================================
  // CONDITIONAL
  // ===================================

  return "Conditional";
}

  // =========================================================
  // CARDIOVASCULAR REPORT
  // =========================================================

  static List<Map<String, dynamic>> generateCardioReport(
      List<dynamic> symptoms) {

    List<Map<String, dynamic>> findings = [];

    // =====================================================
    // PRIMARY CARDIO SYMPTOMS
    // =====================================================

    List<String> primarySymptoms = [
      'Palpitations',
      'Syncope',
      'QT prolongation',
    ];

    // =====================================================
    // LOOP THROUGH PRIMARY SYMPTOMS
    // =====================================================

    for (String symptom in primarySymptoms) {

      // ---------------------------------------------------
      // FIND MAIN SYMPTOM ROW
      // ---------------------------------------------------

      dynamic symptomRow;

      try {

        symptomRow = symptoms.firstWhere(
          (row) =>
              row['symptom_name']
                  .toString()
                  .trim()
                  .toLowerCase() ==
              symptom.toLowerCase(),
        );

      } catch (e) {

        // symptom not found
        continue;
      }

      // ---------------------------------------------------
      // DETECT CAUSALITY FLAGS
      // ---------------------------------------------------

      bool afterMedication = symptoms.any(
        (row) =>
            row['symptom_name']
                .toString()
                .toLowerCase()
                .contains(
                    '${symptom.toLowerCase()} after medication'),
      );

    bool improvedAfterStopping = symptoms.any(
  (row) {

    final name = row['symptom_name']
        .toString()
        .toLowerCase();

    if (symptom == 'QT prolongation') {
      return name.contains(
          'qt improved after stopping');
    }

    return name.contains(
        '${symptom.toLowerCase()} improved after stopping');
  },
);

bool returnedAfterRestart = symptoms.any(
  (row) {

    final name = row['symptom_name']
        .toString()
        .toLowerCase();

    if (symptom == 'QT prolongation') {
      return name.contains(
          'qt prolongation returned after restart');
    }

    return name.contains(
        '${symptom.toLowerCase()} returned after restart');
  },
);

      bool existedBefore = symptoms.any(
        (row) =>
            row['symptom_name']
                .toString()
                .toLowerCase()
                .contains(
                    '${symptom.toLowerCase()} before'),
      );

      // ---------------------------------------------------
      // CALCULATE SEVERITY
      // ---------------------------------------------------

      final severityData =
          mapSeverity(
              symptomRow['severity']
                  .toString());

      // ---------------------------------------------------
      // CALCULATE CAUSALITY
      // ---------------------------------------------------

      final causality = calculateCausality(
        afterMedication: afterMedication,
        improvedAfterStopping: improvedAfterStopping,
        returnedAfterRestart: returnedAfterRestart,
        existedBefore: existedBefore,
      );

      // ---------------------------------------------------
      // FINAL FINDING
      // ---------------------------------------------------

     findings.add({

  'system': 'Cardiovascular',

  'symptom': symptom,

  'severity': severityData['label'],

  'grade': severityData['grade'],

  'causality': causality,

  'associatedSymptoms': symptoms
      .where((row) {

        final name = row['symptom_name']
            .toString();

        return

            name != symptom

            &&

            !name.contains('after medication')

            &&

            !name.contains('improved after stopping')

            &&

            !name.contains('returned after restart')

            &&

            !name.contains('before therapy');
      })

      .map((e) => e['symptom_name'])

      .toList(),
});
    }
    print(findings);
    return findings;
  }
  // =========================================================
// CENTRAL NERVOUS SYSTEM REPORT
// =========================================================

static List<Map<String, dynamic>>
        generateCNSReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Peripheral neuropathy',

    'Vertigo',

    'Seizures',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // ==========================
    // CAUSALITY FLAGS
    // ==========================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} after medication',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(
  '${symptom.toLowerCase()} improved after stopping',
),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(
  '${symptom.toLowerCase()} returned after restart',
),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(
  '${symptom.toLowerCase()} before treatment',
),
    );

    // ==========================
    // SEVERITY
    // ==========================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // ==========================
    // CAUSALITY
    // ==========================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // ==========================
    // FINAL OUTPUT
    // ==========================

    findings.add({

      'system':
          'Central Nervous System',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'grade':
          severityData['grade'],

      'causality':
          causality,
    });
  }

  return findings;
}
  // =========================================================
// PSYCHIATRIC REPORT
// =========================================================

static List<Map<String, dynamic>>
generatePsychiatricReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Anxiety',

    'Depression',

    'Suicidal ideation',

    'Psychosis',

    'Insomnia',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // =====================================
    // CAUSALITY FLAGS
    // =====================================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} after medication',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} improved after stopping',
          ),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} returned after restart',
          ),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} before treatment',
          ),
    );

    // =====================================
    // SEVERITY
    // =====================================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // =====================================
    // CAUSALITY
    // =====================================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // =====================================
    // FINAL OUTPUT
    // =====================================

    findings.add({

      'system':
          'Psychiatric',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'grade':
          severityData['grade'],

      'causality':
          causality,
    });
  }

  return findings;
}
  // =========================================================
// AUDITORY REPORT
// =========================================================

static List<Map<String, dynamic>>
generateAuditoryReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Hearing loss',

    'Tinnitus',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // =====================================
    // CAUSALITY FLAGS
    // =====================================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} after medication',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} improved after stopping',
          ),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} returned after restart',
          ),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} before treatment',
          ),
    );

    // =====================================
    // SEVERITY
    // =====================================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // =====================================
    // CAUSALITY
    // =====================================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // =====================================
    // FINAL OUTPUT
    // =====================================

    findings.add({

      'system':
          'Auditory',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'grade':
          severityData['grade'],

      'causality':
          causality,
    });
  }

  return findings;
}
// =========================================================
// OCULAR REPORT
// =========================================================

static List<Map<String, dynamic>>
generateOcularReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Vision loss',

    'Color vision defect',

    'Visual field defect',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // =====================================
    // CAUSALITY FLAGS
    // =====================================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} after medication',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} improved after stopping',
          ),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} returned after restart',
          ),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} before treatment',
          ),
    );

    // =====================================
    // SEVERITY
    // =====================================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // =====================================
    // CAUSALITY
    // =====================================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // =====================================
    // FINAL OUTPUT
    // =====================================

    findings.add({

      'system':
          'Ocular',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'grade':
          severityData['grade'],

      'causality':
          causality,
    });
  }

  return findings;
}
// =========================================================
// GASTROINTESTINAL REPORT
// =========================================================

static List<Map<String, dynamic>>
generateGIReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Nausea',

    'Vomiting',

    'Abdominal pain',

    'Constipation',

    'Diarrhea',

    'Gastritis',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // ==========================
    // CAUSALITY FLAGS
    // ==========================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            '${symptom.toLowerCase()} after medication',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'improved after stopping',
          ),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'restarted after rechallenge',
          ),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'before treatment',
          ),
    );

    // ==========================
    // SEVERITY
    // ==========================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // ==========================
    // CAUSALITY
    // ==========================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // ==========================
    // FINAL OUTPUT
    // ==========================

    findings.add({

      'system':
          'Gastrointestinal',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'causality':
          causality,
    });
  }

  return findings;
}
  // =========================================================
// MUSCULOSKELETAL REPORT
// =========================================================

static List<Map<String, dynamic>>
generateMusculoskeletalReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Tendon pain',

    'Generalized muscle pain',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // ==========================
    // CAUSALITY FLAGS
    // ==========================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            symptom == 'Tendon pain'

            ? 'tendon pain after anti-tb therapy'

            : 'muscle pain after anti-tb therapy',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'improved after stopping',
          ),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'restarted after rechallenge',
          ),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'before therapy',
          ),
    );

    // ==========================
    // SEVERITY
    // ==========================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // ==========================
    // CAUSALITY
    // ==========================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // ==========================
    // FINAL OUTPUT
    // ==========================

    findings.add({

      'system':
          'Musculoskeletal',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'causality':
          causality,
    });
  }

  return findings;
}
// =========================================================
// DERMATOLOGICAL REPORT
// =========================================================

static List<Map<String, dynamic>>
generateDermatologicalReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  List<String> primarySymptoms = [

    'Skin discoloration',

    'Severe skin rash',
  ];

  for (String symptom
      in primarySymptoms) {

    dynamic symptomRow;

    try {

      symptomRow = symptoms.firstWhere(

        (row) => row['symptom_name']
            .toString()
            .trim()
            .toLowerCase() ==

            symptom.toLowerCase(),
      );

    } catch (e) {

      continue;
    }

    // ==========================
    // CAUSALITY FLAGS
    // ==========================

    bool afterMedication =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            symptom == 'Skin discoloration'

            ? 'skin discoloration after tb therapy'

            : 'skin rash after tb therapy',
          ),
    );

    bool improvedAfterStopping =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'improved after stopping',
          ),
    );

    bool returnedAfterRestart =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'restarted after rechallenge',
          ),
    );

    bool existedBefore =
        symptoms.any(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(

            'before therapy',
          ),
    );

    // ==========================
    // SEVERITY
    // ==========================

    final severityData =
        mapSeverity(

      symptomRow['severity']
          .toString(),
    );

    // ==========================
    // CAUSALITY
    // ==========================

    final causality =
        calculateCausality(

      afterMedication:
          afterMedication,

      improvedAfterStopping:
          improvedAfterStopping,

      returnedAfterRestart:
          returnedAfterRestart,

      existedBefore:
          existedBefore,
    );

    // ==========================
    // EXTRA DIAGNOSIS
    // ==========================

    String diagnosis = '';

    if (symptom == 'Severe skin rash') {

      try {

        final diagnosisRow =
            symptoms.firstWhere(

          (row) => row['symptom_name']
              .toString()
              .contains(
                  'Skin rash diagnosis'),
        );

        diagnosis =
            diagnosisRow['symptom_name']
                .toString()
                .replaceAll(
                  'Skin rash diagnosis - ',
                  '',
                );

      } catch (e) {
        diagnosis = '';
      }
    }

    // ==========================
    // FINAL OUTPUT
    // ==========================

    findings.add({

      'system':
          'Dermatological',

      'symptom':
          symptom,

      'severity':
          severityData['label'],

      'causality':
          causality,

      'diagnosis':
          diagnosis,
    });
  }

  return findings;
}
// =========================================================
// ENDOCRINE REPORT
// =========================================================

static List<Map<String, dynamic>>
generateEndocrineReport(
    List<dynamic> symptoms) {

  List<Map<String, dynamic>> findings = [];

  dynamic thyroidRow;

  try {

    thyroidRow = symptoms.firstWhere(

      (row) => row['symptom_name']
          .toString()
          .toLowerCase()
          .contains(
              'thyroid disorder symptoms'),
    );

  } catch (e) {

    return findings;
  }

  // =====================================================
  // CAUSALITY FLAGS
  // =====================================================

  bool afterTherapy =
      symptoms.any(

    (row) => row['symptom_name']
        .toString()
        .toLowerCase()
        .contains(
            'symptoms after anti-tb therapy'),
  );

  bool existedBefore =
      symptoms.any(

    (row) => row['symptom_name']
        .toString()
        .toLowerCase()
        .contains(
            'previous thyroid disease before therapy'),
  );

  bool tshDone =
      symptoms.any(

    (row) => row['symptom_name']
        .toString()
        .toLowerCase()
        .contains(
            'tsh test performed'),
  );

  // =====================================================
  // THYPRO SCORE
  // =====================================================

  int score = 0;

  for (var row in symptoms) {

    final name =
        row['symptom_name']
            .toString();

    // 23.2
    if (name.contains(
        'Delayed cycles')) {
      score += 1;
    }

    if (name.contains(
        'Missed periods')) {
      score += 2;
    }

    if (name.contains(
        'Heavy bleeding')) {
      score += 3;
    }

    // 23.3
    if (name.contains(
        'Less than 2 kg')) {
      score += 1;
    }

    if (name.contains(
        '2–5 kg')) {
      score += 2;
    }

    if (name.contains(
        'More than 5 kg')) {
      score += 3;
    }

    // 23.4
    if (name.contains(
        'Less than 1 month')) {
      score += 1;
    }

    if (name.contains(
        '1–3 months')) {
      score += 2;
    }

    if (name.contains(
        'More than 3 months')) {
      score += 3;
    }

    // 23.5
    if (name.contains(
        'Occasionally')) {
      score += 1;
    }

    if (name.contains(
        'Frequently')) {
      score += 2;
    }

    if (name.contains(
        'Almost always')) {
      score += 3;
    }
  }

  // =====================================================
  // THYPRO INTERPRETATION
  // =====================================================

  String thyproInterpretation =
      'No or minimal symptoms';

  if (score >= 3 &&
      score <= 5) {

    thyproInterpretation =
        'Mild hypothyroid symptoms';
  }

  else if (score >= 6 &&
      score <= 8) {

    thyproInterpretation =
        'Moderate symptoms';
  }

  else if (score >= 9) {

    thyproInterpretation =
        'Severe symptom burden';
  }

  // =====================================================
  // CAUSALITY
  // =====================================================

  String causality = 'NEGATIVE';

  if (existedBefore) {

    causality = 'UNLIKELY';
  }

  else if (afterTherapy &&
      !tshDone) {

    causality = 'Possible';
  }

  // =====================================================
  // TSH STATUS
  // =====================================================

  String tshStatus = '';

  for (var row in symptoms) {

    final name =
        row['symptom_name']
            .toString();

    if (name.contains(
        'TSH mildly elevated')) {

      tshStatus =
          'SUBCLINICAL';
    }

    if (name.contains(
        'TSH elevated more than 10')) {

      tshStatus =
          'OVERT HYPOTHYROIDISM';
    }

    if (name.contains(
        'diagnosed with hypothyroidism')) {

      tshStatus =
          'CONFIRMED';
    }
  }

  // =====================================================
  // SEVERITY
  // =====================================================

  final severityData =
      mapSeverity(

    thyroidRow['severity']
        .toString(),
  );

  // =====================================================
  // FINAL OUTPUT
  // =====================================================

  findings.add({

    'system':
        'Endocrine',

    'symptom':
        'Thyroid disorder symptoms',

    'severity':
        '${severityData['label']} '
        '(THYPRO Score: $score)',

    'causality':
        tshStatus.isNotEmpty

        ? '$causality / $tshStatus'

        : causality,

  });

  findings.add({

    'system':
        'Endocrine',

    'symptom':
        'THYPRO Interpretation',

    'severity':
        thyproInterpretation,

    'causality':
        '-',
  });

  return findings;
}
// =========================================================
// INVESTIGATIONS SLD REPORT
// =========================================================

static List<Map<String, dynamic>>
generateInvestigationsReport(
    Map<String, dynamic> inv) {

  List<Map<String, dynamic>> findings = [];

  // =====================================================
  // 28. HEMOGLOBIN
  // =====================================================

  if (inv['hgb_done'] == 'Yes') {

    final hgb =
        (inv['hgb_value'] ?? 0).toDouble();

    String severity = 'Grade 0';

    if (hgb < 6.5) {
      severity = 'Grade 4';
    } else if (hgb < 8) {
      severity = 'Grade 3';
    } else if (hgb < 10) {
      severity = 'Grade 2';
    } else if (hgb <
        (inv['hgb_lln'] ?? 0)) {
      severity = 'Grade 1';
    }

    findings.add({

      'system': 'Hematological',

      'symptom':
          'Anemia / Low Hemoglobin',

      'severity': severity,

      'causality': 'Lab Confirmed',
    });
  }

  // =====================================================
  // 29. PLATELETS
  // =====================================================

  if (inv['platelet_done'] == 'Yes') {

    final platelet =
        (inv['platelet_value'] ?? 0).toDouble();

    final lln =
        (inv['platelet_lln'] ?? 0).toDouble();

    String severity = 'Grade 0';

    if (platelet < 25000) {
      severity = 'Grade 4';
    } else if (platelet < 50000) {
      severity = 'Grade 3';
    } else if (platelet < 75000) {
      severity = 'Grade 2';
    } else if (platelet < lln) {
      severity = 'Grade 1';
    }

    findings.add({

      'system': 'Hematological',

      'symptom':
          'Thrombocytopenia',

      'severity': severity,

      'causality': 'Lab Confirmed',
    });
  }

  // =====================================================
  // 30. ANC
  // =====================================================

  if (inv['anc_done'] == 'Yes') {

    final anc =
        (inv['anc_value'] ?? 0).toDouble();

    String severity = 'Grade 0';

    if (anc < 500) {
      severity = 'Grade 4';
    } else if (anc < 1000) {
      severity = 'Grade 3';
    } else if (anc < 1500) {
      severity = 'Grade 2';
    } else if (anc <
        (inv['anc_lln'] ?? 0)) {
      severity = 'Grade 1';
    }

    if (severity == 'Grade 4' &&
        inv['neutropenic_fever'] == 'Yes') {

      severity =
          'Grade 4 - Febrile Neutropenia';
    }

    findings.add({

      'system': 'Hematological',

      'symptom': 'Neutropenia',

      'severity': severity,

      'causality': 'Lab Confirmed',
    });
  }

  // =====================================================
  // 31. LACTIC ACIDOSIS
  // =====================================================

  if (inv['lactate_acidosis_done'] == 'Yes') {

    String severity = 'Grade 0';

    final lactate =
        (inv['serum_lactate'] ?? 0).toDouble();

    final lactateULN =
        (inv['serum_lactate_uln'] ?? 1).toDouble();

    final ratio =
        lactate / lactateULN;

    if (ratio > 5) {
      severity = 'Grade 4';
    } else if (ratio > 3) {
      severity = 'Grade 3';
    } else if (ratio > 2) {
      severity = 'Grade 2';
    } else if (ratio > 1) {
      severity = 'Grade 1';
    }

    String suspicion = '';

    final symptoms =
        (inv['lactate_symptoms'] ?? '')
            .toString();

    if (
        symptoms.contains('Severe fatigue or weakness') &&
        symptoms.contains('Rapid or deep breathing') &&
        symptoms.contains('Confusion / altered sensorium')
    ) {

      suspicion =
          'High suspicion of lactic acidosis';

    } else if (

        symptoms.contains('Nausea') ||
        symptoms.contains('Vomiting') ||
        symptoms.contains('Abdominal pain') ||
        symptoms.contains('Muscle pain') ||
        symptoms.contains('Dizziness')

    ) {

      suspicion =
          'Moderate suspicion';
    }

    String causality = 'Possible';

    if (inv['linezolid_related'] == 'Yes' &&
        inv['improved_after_stop'] == 'Yes') {

      causality = 'Probable';
    }

    if (inv['linezolid_related'] == 'Yes' &&
        inv['improved_after_stop'] == 'Yes' &&
        inv['recurred_after_restart'] == 'Yes') {

      causality = 'Certain';
    }

    findings.add({

      'system': 'Metabolic',

      'symptom':
          'Lactic Acidosis $suspicion',

      'severity': severity,

      'causality': causality,
    });
  }

  // =====================================================
  // 32. HYPERURICEMIA
  // =====================================================

  if (inv['uric_acid_done'] == 'Yes') {

    final value =
        (inv['uric_acid_value'] ?? 0).toDouble();

    final uln =
        (inv['uric_acid_uln'] ?? 1).toDouble();

    final ratio = value / uln;

    String severity = 'Grade 0';

    if (ratio > 2) {
      severity = 'Grade 3';
    } else if (ratio > 1.5) {
      severity = 'Grade 2';
    } else if (ratio > 1) {
      severity = 'Grade 1';
    }

    findings.add({

      'system': 'Metabolic',

      'symptom': 'Hyperuricemia',

      'severity': severity,

      'causality': 'Lab Confirmed',
    });
  }

  // =====================================================
  // 33. RENAL TOXICITY
  // =====================================================

  if (inv['creatinine_done'] == 'Yes') {

    final value =
        (inv['creatinine_value'] ?? 0).toDouble();

    final uln =
        (inv['creatinine_uln'] ?? 1).toDouble();

    final ratio = value / uln;

    String severity = 'Grade 0';

    if (ratio > 6) {
      severity = 'Grade 4';
    } else if (ratio > 3) {
      severity = 'Grade 3';
    } else if (ratio > 1.5) {
      severity = 'Grade 2';
    } else if (ratio > 1) {
      severity = 'Grade 1';
    }

    findings.add({

      'system': 'Renal',

      'symptom': 'Renal Toxicity',

      'severity': severity,

      'causality': 'Lab Confirmed',
    });
  }

  return findings;
}
static List<Map<String, dynamic>>
generateGeneralSymptomsReport(
    Map<String, dynamic> general) {

  List<Map<String, dynamic>> findings = [];

  // =====================================
  // HELPER
  // =====================================

  void addFinding({

    required String symptom,
    required String? severity,
    required String? afterStart,
    required String? before,
    required String? improved,
    required String? reappeared,
    bool conditional = false,
  }) {

    String causality = 'Possible';

    if (before == 'Yes') {

      causality = 'Unlikely';

    } else if (
        afterStart == 'Yes' &&
        improved == 'Yes' &&
        reappeared == 'Yes') {

      causality = 'Certain';

    } else if (
        afterStart == 'Yes' &&
        improved == 'Yes') {

      causality = 'Probable';

    } else if (afterStart == 'Yes') {

      causality = 'Possible';
    }

    if (conditional) {
      causality = '$causality (Conditional)';
    }

    findings.add({

      'system': 'General Symptoms',

      'symptom': symptom,

      'severity': severity ?? '',

      'causality': causality,
    });
  }

  // =====================================
  // FATIGUE
  // =====================================

  if (general['fatigue_present'] == 'Yes') {

    bool conditional =
        general['fatigue_lifestyle'] == 'Yes';

    addFinding(

      symptom: 'Fatigue / Weakness',

      severity: general['fatigue_severity'],

      afterStart: general['fatigue_after_start'],

      before: general['fatigue_before'],

      improved: general['fatigue_improved'],

      reappeared: general['fatigue_reappeared'],

      conditional: conditional,
    );
  }

  // =====================================
  // WEIGHT LOSS
  // =====================================

  if (general['weight_loss_present'] == 'Yes') {

    final beforeWeight =
        double.tryParse(
          general['weight_before']
              ?.toString() ??
              '',
        ) ??
        0;

    final currentWeight =
        double.tryParse(
          general['current_weight']
              ?.toString() ??
              '',
        ) ??
        0;

    double percentLoss = 0;

    if (beforeWeight > 0) {

      percentLoss =
          ((beforeWeight - currentWeight) /
                  beforeWeight) *
              100;
    }

    String severity = 'Grade 1';

    if (percentLoss >= 20) {

      severity = 'Grade 3';

    } else if (percentLoss >= 10) {

      severity = 'Grade 2';
    }

    findings.add({

      'system': 'General Symptoms',

      'symptom': 'Weight Loss',

      'severity':
          '$severity (${percentLoss.toStringAsFixed(1)}%)',

      'causality': 'Possible',
    });
  }

  // =====================================
  // FEVER
  // =====================================

  if (general['fever_present'] == 'Yes') {

    addFinding(

      symptom: 'Fever',

      severity: general['fever_severity'],

      afterStart: general['fever_after_start'],

      before: general['fever_before'],

      improved: general['fever_improved'],

      reappeared: general['fever_reappeared'],
    );
  }

  // =====================================
  // JOINT PAIN
  // =====================================

  if (general['joint_pain_present'] == 'Yes') {

    addFinding(

      symptom: 'Joint Pain',

      severity: general['joint_pain_severity'],

      afterStart: general['joint_after_start'],

      before: general['joint_before'],

      improved: general['joint_improved'],

      reappeared: general['joint_reappeared'],
    );
  }

  // =====================================
  // HEADACHE
  // =====================================

  if (general['headache_present'] == 'Yes') {

    addFinding(

      symptom: 'Headache',

      severity: general['headache_severity'],

      afterStart: general['headache_after_start'],

      before: general['headache_before'],

      improved: general['headache_improved'],

      reappeared: general['headache_reappeared'],
    );
  }

  // =====================================
  // ITCHING
  // =====================================

  if (general['itching_present'] == 'Yes') {

    addFinding(

      symptom: 'Itching',

      severity: general['itching_severity'],

      afterStart: general['itching_after_start'],

      before: general['itching_before'],

      improved: general['itching_improved'],

      reappeared: general['itching_reappeared'],
    );
  }

  return findings;
}
static List<Map<String, dynamic>>
generateOtherSideEffectsReport(
    Map<String, dynamic> other) {

  List<Map<String, dynamic>> findings = [];

  void addIfYes({

    required String? answer,
    required String symptom,
    String severity = 'Reported',
    String causality = 'Possible ADR',
  }) {

    if (answer == 'Yes') {

      findings.add({

        'system': 'Other Side Effects',

        'symptom': symptom,

        'severity': severity,

        'causality': causality,
      });
    }
  }

  addIfYes(
    answer: other['injection_site_reaction'],
    symptom:
        'Pain/swelling at injection site',
  );

  addIfYes(
    answer:
        other['severe_allergic_reaction'],
    symptom:
        'Severe allergic reaction',
  );

  addIfYes(
    answer: other['anaphylaxis'],
    symptom: 'Anaphylactic shock',
    severity: 'Severe',
  );

  addIfYes(
    answer: other['proteinuria'],
    symptom: 'Proteinuria',
  );

  addIfYes(
    answer: other['sle'],
    symptom:
        'Drug induced lupus erythematosus',
  );

  addIfYes(
    answer: other['dress_syndrome'],
    symptom:
        'Drug Reaction with Eosinophilia and Systemic Symptoms',
    severity: 'Severe',
  );

  addIfYes(
    answer: other['tremors'],
    symptom: 'Tremors',
  );

  addIfYes(
    answer: other['gum_inflammation'],
    symptom: 'Gingivitis',
  );

  addIfYes(
    answer: other['taste_change'],
    symptom: 'Dysgeusia',
  );

  addIfYes(
    answer: other['excess_salivation'],
    symptom: 'Excess salivation',
  );

  addIfYes(
    answer: other['stomatitis'],
    symptom: 'Stomatitis',
  );

  addIfYes(
    answer: other['pellagra'],
    symptom:
        'Possible pellagra under evaluation',
  );

  addIfYes(
    answer: other['increased_inr'],
    symptom:
        'Possible coagulopathy under evaluation',
  );

  addIfYes(
    answer: other['gynecomastia'],
    symptom:
        'Possible gynecomastia under evaluation',
  );

  addIfYes(
    answer: other['bloating'],
    symptom: 'Bloating',
  );

  addIfYes(
    answer: other['loss_of_appetite'],
    symptom: 'Loss of appetite',
  );

  addIfYes(
    answer: other['memory_changes'],
    symptom:
        'Possible cognitive impairment',
  );

  addIfYes(
    answer: other['leg_swelling'],
    symptom:
        'Possible pedal edema',
  );

  // OTHER SYMPTOMS

  if ((other['other_symptoms'] ?? '')
      .toString()
      .trim()
      .isNotEmpty) {

    findings.add({

      'system': 'Other Side Effects',

      'symptom':
          other['other_symptoms'],

      'severity': 'Reported',

      'causality': 'Possible ADR',
    });
  }

  return findings;
}
}