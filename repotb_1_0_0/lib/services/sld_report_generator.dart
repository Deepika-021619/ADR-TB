import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'report_api.dart';
import 'grading_reportsld.dart';
import 'package:flutter/services.dart';

class SLDReportGenerator {

 static Future<Uint8List> generateReport({

  required String reportId,

  required Map<String, dynamic> reportData,

  required List<Map<String, dynamic>> cardioReport,

}) async {

  final logoBytes =
      await rootBundle.load(
          'assets/images/logo.png');

  final logoImage = pw.MemoryImage(
    logoBytes.buffer.asUint8List(),
  );
    
 
    final pdf = pw.Document();
     print(cardioReport);
     final cnsReport =

    GradingReportSLD
        .generateCNSReport(

            reportData['systems'] ?? [],
        );
      final psychiatricReport =
    GradingReportSLD.generatePsychiatricReport(
        reportData['systems'] ?? []);

        final auditoryReport =

    GradingReportSLD
        .generateAuditoryReport(
          reportData['systems'] ?? []);

    final ocularReport =

    GradingReportSLD
        .generateOcularReport(
           reportData['systems'] ?? []);
          
    final gastrointestinal =
    GradingReportSLD
        .generateGIReport(
            reportData['systems'] ?? []);

    final musculoskeletal =
    GradingReportSLD
        .generateMusculoskeletalReport(
            reportData['systems'] ?? []);
      
    final dermatological =
    GradingReportSLD
        .generateDermatologicalReport(
            reportData['systems'] ?? []);

    final endocrine =
    GradingReportSLD
        .generateEndocrineReport(
            reportData['systems'] ?? []);

    
           

      

    pdf.addPage(

      pw.MultiPage(

        pageFormat: PdfPageFormat.a4,

        margin: const pw.EdgeInsets.all(24),

        build: (context) => [

          // =====================================================
          // HEADER
          // =====================================================

          pw.Row(

  mainAxisAlignment:
      pw.MainAxisAlignment.spaceBetween,

  crossAxisAlignment:
      pw.CrossAxisAlignment.start,

  children: [

    // LEFT LOGO
    pw.Container(

      height: 100,

      width: 100,

      child: pw.Image(logoImage),
    ),

    // RIGHT TITLE
    pw.Column(

      crossAxisAlignment:
          pw.CrossAxisAlignment.end,

      children: [

        pw.Text(

          'ADR TB REPORT',

          style: pw.TextStyle(

            fontSize: 20,

            fontWeight:
                pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 5),

        pw.Text(

          'Report ID: ${reportData['report_id']}',

          style: pw.TextStyle(

            fontSize: 11,

            fontWeight:
                pw.FontWeight.bold,

            color: PdfColors.blue900,
          ),
        ),

        pw.Text(

          'Created: ${reportData['created_at']}',

          style: const pw.TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    ),
  ],
),

          pw.SizedBox(height: 30),

          // =====================================================
          // REPORTER + PATIENT DETAILS
          // =====================================================

          pw.Row(

            crossAxisAlignment:
                pw.CrossAxisAlignment.start,

            children: [

              pw.Expanded(

                child: _buildSection(

                  title: 'Reporter Details',

                 content: [

  'Reporter Name: ${reportData['reporter']?['name'] ?? ''}',

  'Role: ${reportData['reporter']?['role'] ?? ''}',

  'Hospital Name: ${reportData['reporter']?['hospital_address'] ?? ''}',

  'State: ${reportData['reporter']?['state'] ?? ''}',
],
                ),
              ),

              pw.SizedBox(width: 15),

              pw.Expanded(

                child: _buildSection(

                  title: 'Patient Details',

                  content: [
                    'Nikshay ID: ${reportData['patient']?['nik_id'] ?? ''}',
'Patient ID: ${reportData['patient']?['p_id'] ?? ''}',
'Patient Name: ${reportData['patient']?['name'] ?? ''}',
'Gender: ${reportData['patient']?['gender'] ?? ''}',
'State: ${reportData['patient']?['state'] ?? ''}',
                  ],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 20),

          // =====================================================
          // TREATMENT + DRUG DETAILS
          // =====================================================

          pw.Row(

            crossAxisAlignment:
                pw.CrossAxisAlignment.start,

            children: [

              pw.Expanded(

                child: _buildSection(

                  title: 'Treatment Details',

                  content: [

  'Age: ${reportData['treatment']['age_years'] ?? ''}',

  'Height (cm): ${reportData['treatment']['height_cm'] ?? ''}',

  'Weight (kg): ${reportData['treatment']['weight_kg'] ?? ''}',

  'Treatment type: ${reportData['treatment']['treatment_name'] ?? ''}',
],
                ),
              ),

              pw.SizedBox(width: 15),

              pw.Expanded(

                child: _buildSection(

                  title: 'Drug Details',

                  content: [

  'Drug Regimen: ${reportData['drug_details']['drug_regimen'] ?? ''}',

  'Time since drug taken: '
      '${reportData['drug_details']['time_since_value'] ?? ''} '
      '${reportData['drug_details']['time_since_unit'] ?? ''}',

  'Brand Name: ${reportData['drug_details']['brand_name'] ?? ''}',

  'Batch Number: ${reportData['drug_details']['batch_number'] ?? ''}',

  'Oral Only: ${reportData['drug_details']['oral_only'] ?? ''}',
],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 25),

          // =====================================================
          // CARDIOVASCULAR SYSTEM
          // =====================================================
          

          _buildSystemTable(

            title: 'SYSTEM REPORT',

            rows: [

    ...cardioReport,

    ...cnsReport,
    ...psychiatricReport,
     ...auditoryReport,
     ...ocularReport,
      ...gastrointestinal,
      ...musculoskeletal,
      ...dermatological,
      ...endocrine,
      ...GradingReportSLD.generateInvestigationsReport(
      reportData['investigations'] ?? {},
      ),
      ...GradingReportSLD.generateGeneralSymptomsReport(
    reportData['general'] ?? {},
),
      ...GradingReportSLD.generateOtherSideEffectsReport(
    reportData['other_side_effects'] ?? {},
),
  ],
),

          pw.SizedBox(height: 25),

          // =====================================================
          // FOOTER
          // =====================================================

          pw.Align(

            alignment: pw.Alignment.centerRight,

            child: pw.Text(

  'Time Taken: '
  '${reportData['completion_time'] ?? 'N/A'}',

  style: pw.TextStyle(

    fontSize: 11,

    fontWeight:
        pw.FontWeight.bold,
  ),
),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  // =========================================================
  // SECTION BUILDER
  // =========================================================

  static pw.Widget _buildSection({

    required String title,

    required List<String> content,
  }) {

    return pw.Container(

      padding: const pw.EdgeInsets.all(10),

      decoration: pw.BoxDecoration(

        border: pw.Border.all(
          color: PdfColors.black,
        ),
      ),

      child: pw.Column(

        crossAxisAlignment:
            pw.CrossAxisAlignment.start,

        children: [

          pw.Text(

            title,

            style: pw.TextStyle(

              fontWeight: pw.FontWeight.bold,

              fontSize: 14,
            ),
          ),

          pw.SizedBox(height: 10),

          ...content.map(

            (item) => pw.Padding(

              padding: const pw.EdgeInsets.only(
                bottom: 5,
              ),

              child: pw.Text(
                item,
                style: const pw.TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SYSTEM TABLE
  // =========================================================

  static pw.Widget _buildSystemTable({

    required String title,

    required List<Map<String, dynamic>> rows,
  }) {

    return pw.Column(

      crossAxisAlignment:
          pw.CrossAxisAlignment.start,

      children: [

        pw.Text(

          title,

          style: pw.TextStyle(

            fontSize: 15,

            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 10),

        pw.Table(

          border: pw.TableBorder.all(),

           columnWidths: {

           0: const pw.FlexColumnWidth(2.2),
          1: const pw.FlexColumnWidth(3.5),
          2: const pw.FlexColumnWidth(2.3),
          3: const pw.FlexColumnWidth(2),
           },

          children: [

            // =================================================
            // HEADER ROW
            // =================================================

            pw.TableRow(

              decoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),

              children: [
                _tableCell(
                 'System',
                    isHeader: true,
                  ),

                _tableCell(
                  'Symptom Name',
                  isHeader: true,
                ),

                _tableCell(
                  'Severity',
                  isHeader: true,
                ),

                _tableCell(
                  'Causality',
                  isHeader: true,
                ),
                 
              ],
            ),

            // =================================================
            // DATA ROWS
            // =================================================

            ...rows.map(

              (row) => pw.TableRow(

                children: [
                  _tableCell(
                    row['system'],
                  ),

                 _tableCell(

  row['diagnosis'] != null &&
  row['diagnosis']
      .toString()
      .isNotEmpty

  ? '${row['symptom']} (${row['diagnosis']})'

  : row['symptom'],
),

                  _tableCell(
                    row['severity'],
                  ),

                  _tableCell(
                    row['causality'],
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================
  // TABLE CELL
  // =========================================================

  static pw.Widget _tableCell(

    String text, {

    bool isHeader = false,
  }) {

    return pw.Padding(

      padding: const pw.EdgeInsets.all(8),

      child: pw.Text(

        text,

        style: pw.TextStyle(

          fontSize: 11,

          fontWeight:
              isHeader
                  ? pw.FontWeight.bold
                  : null,
        ),
      ),
    );
  }
}