import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'systems_api.dart';
import '../services/grading_report.dart';
import 'package:printing/printing.dart';
import '../services/report_api.dart';


class InvestigationsScreen extends StatefulWidget {
  final String reportId;
  final VoidCallback onSaveAndComplete;
  
  const InvestigationsScreen({
    super.key,
    required this.reportId,
    required this.onSaveAndComplete,
  });

  @override
  State<InvestigationsScreen> createState() => _InvestigationsScreenState();
}

class _InvestigationsScreenState extends State<InvestigationsScreen> {
  // 29. LFTs
  String? q29Answer;
  String? q291AstValue;
  String? q291AstUpperLimit;
  String? q291AstBaseline;
  String? q291AltValue;
  String? q291AltUpperLimit;
  String? q291AltBaseline;
  String? q291AlpValue;
  String? q291AlpUpperLimit;
  String? q291AlpBaseline;
  String? q291TotalBilirubinValue;
  String? q291TotalBilirubinUpperLimit;
  String? q291TotalBilirubinBaseline;
  String? q291DirectBilirubinValue;
  String? q291DirectBilirubinUpperLimit;
  String? q291DirectBilirubinBaseline;

  // 30. Hemoglobin
  String? q30Answer;
  String? q301HgbValue;
  String? q301HgbLowerLimit;
  String? q301HgbBaseline;

  // 31. Platelets
  String? q31Answer;
  String? q311PlateletValue;
  String? q311PlateletLowerLimit;
  String? q311PlateletBaseline;

  // 32. Uric Acid
  String? q32Answer;
  String? q321UricAcidValue;
  String? q321UricAcidUpperLimit;
  String? q321UricAcidBaseline;

  bool get showLFTs => q29Answer == 'Yes';
  bool get showHemoglobin => q30Answer == 'Yes';
  bool get showPlatelets => q31Answer == 'Yes';
  bool get showUricAcid => q32Answer == 'Yes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 29. LFTs
              _buildRadioQuestion(
                number: "29",
                question: "Did you get your liver function tests (LFTs) done recently?",
                options: ['Yes', 'No'],
                value: q29Answer,
                onChanged: (val) => setState(() => q29Answer = val),
              ),
              if (showLFTs) ...[
                const SizedBox(height: 20),
                Text("If Yes, Please continue:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildLFTSection(),
              ],

              // 30. Hemoglobin
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "30",
                question: "Did you get your hemoglobin (Hgb) tested recently?",
                options: ['Yes', 'No'],
                value: q30Answer,
                onChanged: (val) => setState(() => q30Answer = val),
              ),
              if (showHemoglobin) ...[
                const SizedBox(height: 20),
                Text("30.1 Please enter your most recent hemoglobin (Hgb) values:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(
                  number: "Hgb", 
                  question: "Hgb", 
                  value: q301HgbValue, 
                  onChanged: (val) => setState(() => q301HgbValue = val), 
                  hint: "g/dL or mmol/L or g/L"
                ),
                _buildNumericQuestion(
                  number: "LLN", 
                  question: "Lower limit of normal (LLN)", 
                  value: q301HgbLowerLimit, 
                  onChanged: (val) => setState(() => q301HgbLowerLimit = val), 
                  hint: "Enter value"
                ),
                _buildNumericQuestion(
                  number: "Baseline", 
                  question: "Baseline Hgb (if available)", 
                  value: q301HgbBaseline, 
                  onChanged: (val) => setState(() => q301HgbBaseline = val), 
                  hint: "Optional"
                ),
              ],

              // 31. Platelets
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "31",
                question: "Have you had your platelet count checked recently or experienced any unusual bleeding/bruising since starting the medication? (Thrombocytopenic purpura)",
                options: ['Yes', 'No'],
                value: q31Answer,
                onChanged: (val) => setState(() => q31Answer = val),
              ),
              if (showPlatelets) ...[
                const SizedBox(height: 20),
                Text("31.1 Please enter your most recent lab values of platelet count:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(
                  number: "Platelet count", 
                  question: "Platelet count", 
                  value: q311PlateletValue, 
                  onChanged: (val) => setState(() => q311PlateletValue = val), 
                  hint: "/µL"
                ),
                _buildNumericQuestion(
                  number: "LLN", 
                  question: "Lower limit of normal (LLN)", 
                  value: q311PlateletLowerLimit, 
                  onChanged: (val) => setState(() => q311PlateletLowerLimit = val), 
                  hint: "/µL"
                ),
                _buildNumericQuestion(
                  number: "Baseline", 
                  question: "Baseline platelet count (if available)", 
                  value: q311PlateletBaseline, 
                  onChanged: (val) => setState(() => q311PlateletBaseline = val), 
                  hint: "Optional"
                ),
              ],

              // 32. Uric Acid
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "32",
                question: "Have you had your serum uric acid tested recently? (Hyperuricemia)",
                options: ['Yes', 'No'],
                value: q32Answer,
                onChanged: (val) => setState(() => q32Answer = val),
              ),
              if (showUricAcid) ...[
                const SizedBox(height: 20),
                Text("32.1 Please enter your most recent lab values of Serum uric acid:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                const SizedBox(height: 20),
                _buildNumericQuestion(
                  number: "Serum uric acid", 
                  question: "Serum uric acid", 
                  value: q321UricAcidValue, 
                  onChanged: (val) => setState(() => q321UricAcidValue = val), 
                  hint: "mg/dL or µmol/L"
                ),
                _buildNumericQuestion(
                  number: "ULN", 
                  question: "Upper limit of normal (ULN)", 
                  value: q321UricAcidUpperLimit, 
                  onChanged: (val) => setState(() => q321UricAcidUpperLimit = val), 
                  hint: "mg/dL or µmol/L"
                ),
                _buildNumericQuestion(
                  number: "Baseline", 
                  question: "Baseline uric acid (if available)", 
                  value: q321UricAcidBaseline, 
                  onChanged: (val) => setState(() => q321UricAcidBaseline = val), 
                  hint: "Optional"
                ),
              ],

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        label: const Text('Create Report & Download', style: TextStyle(fontWeight: FontWeight.bold)),
        heroTag: "create_report_download",
        onPressed: _isComplete() ? _finalSubmitAndReport : null,
      ),
    );
  }

  Widget _buildLFTSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("29.1 LFT Results Entry (Please enter the most recent lab values)", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // AST
            _buildLFTRow(
              "AST (SGOT)", 
              q291AstValue, (val) => setState(() => q291AstValue = val),
              q291AstUpperLimit, (val) => setState(() => q291AstUpperLimit = val),
              q291AstBaseline, (val) => setState(() => q291AstBaseline = val), 
              "U/L"
            ),
            const SizedBox(height: 20),
            
            // ALT
            _buildLFTRow(
              "ALT (SGPT)", 
              q291AltValue, (val) => setState(() => q291AltValue = val),
              q291AltUpperLimit, (val) => setState(() => q291AltUpperLimit = val),
              q291AltBaseline, (val) => setState(() => q291AltBaseline = val), 
              "U/L"
            ),
            const SizedBox(height: 20),
            
            // ALP
            _buildLFTRow(
              "Alkaline Phosphatase (ALP)", 
              q291AlpValue, (val) => setState(() => q291AlpValue = val),
              q291AlpUpperLimit, (val) => setState(() => q291AlpUpperLimit = val),
              q291AlpBaseline, (val) => setState(() => q291AlpBaseline = val), 
              "U/L"
            ),
            const SizedBox(height: 20),
            
            // Total Bilirubin
            _buildLFTRow(
              "Total Bilirubin", 
              q291TotalBilirubinValue, (val) => setState(() => q291TotalBilirubinValue = val),
              q291TotalBilirubinUpperLimit, (val) => setState(() => q291TotalBilirubinUpperLimit = val),
              q291TotalBilirubinBaseline, (val) => setState(() => q291TotalBilirubinBaseline = val), 
              "mg/dL or µmol/L"
            ),
            const SizedBox(height: 20),
            
            // Direct Bilirubin
            _buildLFTRow(
              "Direct Bilirubin", 
              q291DirectBilirubinValue, (val) => setState(() => q291DirectBilirubinValue = val),
              q291DirectBilirubinUpperLimit, (val) => setState(() => q291DirectBilirubinUpperLimit = val),
              q291DirectBilirubinBaseline, (val) => setState(() => q291DirectBilirubinBaseline = val), 
              "mg/dL or µmol/L"
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLFTRow(String label, String? value, Function(String?) onValueChanged,
      String? upperLimit, Function(String?) onUpperLimitChanged,
      String? baseline, Function(String?) onBaselineChanged, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(flex: 3, child: _buildSmallNumericField("Value", value, onValueChanged, unit)),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: _buildSmallNumericField("Upper limit", upperLimit, onUpperLimitChanged, unit)),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: _buildSmallNumericField("Baseline", baseline, onBaselineChanged, "Optional")),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallNumericField(String label, String? value, Function(String?) onChanged, String hint) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[700])),
          const SizedBox(height: 4),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            initialValue: value,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioQuestion({
    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number. $question", 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...options.map((option) => RadioListTile<String>(
              title: Text(option, style: const TextStyle(fontSize: 14)),
              value: option,
              groupValue: value,
              onChanged: onChanged,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericQuestion({
    required String number,
    required String question,
    required String? value,
    required Function(String?) onChanged,
    String hint = "Enter number",
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$number. $question",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              initialValue: value,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Validation logic
  bool _isComplete() {
    if (showLFTs) {
      final lftFilled = [
        q291AstValue,
        q291AltValue,
        q291AlpValue,
        q291TotalBilirubinValue,
        q291DirectBilirubinValue,
      ].where((v) => v?.isNotEmpty == true).isNotEmpty;
      if (!lftFilled) return false;
    }

    if (showHemoglobin && q301HgbValue?.isNotEmpty != true) return false;
    if (showPlatelets && q311PlateletValue?.isNotEmpty != true) return false;
    if (showUricAcid && q321UricAcidValue?.isNotEmpty != true) return false;

    return q29Answer != null &&
        q30Answer != null &&
        q31Answer != null &&
        q32Answer != null;
  }

  // Save investigations data
  Future<bool> _saveInvestigationsAndComplete() async {
    final requestBody = {
      'report_id': widget.reportId,
      'lft_done': q29Answer == 'Yes' ? 'Yes' : 'No',
      'ast_value': double.tryParse(q291AstValue ?? '') ?? 0.0,
      'ast_uln': double.tryParse(q291AstUpperLimit ?? '') ?? 0.0,
      'ast_baseline': double.tryParse(q291AstBaseline ?? '') ?? 0.0,
      'alt_value': double.tryParse(q291AltValue ?? '') ?? 0.0,
      'alt_uln': double.tryParse(q291AltUpperLimit ?? '') ?? 0.0,
      'alt_baseline': double.tryParse(q291AltBaseline ?? '') ?? 0.0,
      'alp_value': double.tryParse(q291AlpValue ?? '') ?? 0.0,
      'alp_uln': double.tryParse(q291AlpUpperLimit ?? '') ?? 0.0,
      'alp_baseline': double.tryParse(q291AlpBaseline ?? '') ?? 0.0,
      'bilirubin_total': double.tryParse(q291TotalBilirubinValue ?? '') ?? 0.0,
      'bilirubin_total_uln': double.tryParse(q291TotalBilirubinUpperLimit ?? '') ?? 0.0,
      'bilirubin_total_baseline': double.tryParse(q291TotalBilirubinBaseline ?? '') ?? 0.0,
      'bilirubin_direct': double.tryParse(q291DirectBilirubinValue ?? '') ?? 0.0,
      'bilirubin_direct_uln': double.tryParse(q291DirectBilirubinUpperLimit ?? '') ?? 0.0,
      'bilirubin_direct_baseline': double.tryParse(q291DirectBilirubinBaseline ?? '') ?? 0.0,
      'hgb_done': q30Answer == 'Yes' ? 'Yes' : 'No',
      'hgb_value': double.tryParse(q301HgbValue ?? '') ?? 0.0,
      'hgb_lln': double.tryParse(q301HgbLowerLimit ?? '') ?? 0.0,
      'hgb_baseline': double.tryParse(q301HgbBaseline ?? '') ?? 0.0,
      'platelet_done': q31Answer == 'Yes' ? 'Yes' : 'No',
      'platelet_value': double.tryParse(q311PlateletValue ?? '') ?? 0.0,
      'platelet_lln': double.tryParse(q311PlateletLowerLimit ?? '') ?? 0.0,
      'platelet_baseline': double.tryParse(q311PlateletBaseline ?? '') ?? 0.0,
      'uric_acid_done': q32Answer == 'Yes' ? 'Yes' : 'No',
      'uric_acid_value': double.tryParse(q321UricAcidValue ?? '') ?? 0.0,
      'uric_acid_uln': double.tryParse(q321UricAcidUpperLimit ?? '') ?? 0.0,
      'uric_acid_baseline': double.tryParse(q321UricAcidBaseline ?? '') ?? 0.0,
    };

    try {
      final success = await SystemsApi.saveInvestigations(requestBody);
      return success;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving investigations: $e')),
        );
      }
      return false;
    }
  }

    Future<void> _finalSubmitAndReport() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // ✅ STEP 1: Save investigations
      final saveSuccess = await _saveInvestigationsAndComplete();

      if (!saveSuccess) {
        if (mounted) Navigator.pop(context);
        return;
      }

      // ✅ STEP 2: Fetch FULL report
      final reportData = await ReportApi.getFullReport(widget.reportId);

      print("🔥 FULL REPORT DATA: $reportData");

      // ✅ STEP 3: Generate FINAL report
      final fullReport =
          GradingReportGenerator().generateFullReport(
            reportData: reportData,
          );

      // ✅ STEP 4: Show report
      if (mounted) {
        Navigator.pop(context);
        _showFinalReportDialog(fullReport);
      }

    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Report failed: $e')),
        );
      }
    }
  }

  // ===============================
  // SHOW REPORT
  // ===============================
  void _showFinalReportDialog(String report) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          '🏥 COMPLETE TB ADR REPORT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(child: SelectableText(report)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            onPressed: () => _downloadReportPdf(report),
            icon: const Icon(Icons.download),
            label: const Text('Download PDF'),
          ),
        ],
      ),
    );
  }

  // ===============================
  // PDF DOWNLOAD
  // ===============================
  Future<void> _downloadReportPdf(String reportText) async {
  final pdf = pw.Document();

  // 🔹 Load logo
  final logo = await imageFromAssetBundle('assets/images/logo.png');

  final now = DateTime.now();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),

      build: (pw.Context context) => [

        // ===============================
        // 🔷 HEADER
        // ===============================
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(logo, width: 150, height: 150),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'TB ADR REPORT',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                ),
                pw.Text(
                  'Generated on: ${now.toLocal().toString().split('.')[0]}',
                  style: pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 10),
        pw.Divider(),

        pw.SizedBox(height: 10),

        // ===============================
        // 🔷 BODY (structured)
        // ===============================
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: _buildStyledReport(reportText),
        ),
      ],
    ),
  );

  await Printing.layoutPdf(
    name: 'TB_ADR_Report_${widget.reportId}.pdf',
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
List<pw.Widget> _buildStyledReport(String reportText) {
  final lines = reportText.split('\n');

  List<pw.Widget> widgets = [];

  for (var line in lines) {
    if (line.trim().isEmpty) continue;

    // 🔷 Section Headers
    if (line.contains('DETAILS') ||
        line.contains('REPORT') ||
        line.contains('DATA')) {
      widgets.add(
        pw.Container(
          margin: const pw.EdgeInsets.only(top: 10, bottom: 5),
          padding: const pw.EdgeInsets.all(8),
          color: PdfColors.blue100,
          child: pw.Text(
            line,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
        ),
      );
      continue;
    }

    // 🔴 Highlight respiratory block
    if (line.contains('Severity') ||
        line.contains('Causality') ||
        line.contains('Duration') ||
        line.contains('Status')) {
      widgets.add(
        pw.Text(
          line,
          style: pw.TextStyle(
            fontSize: 11,
            color: PdfColors.red,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      );
      continue;
    }

    // 🔹 Normal text
    widgets.add(
      pw.Text(
        line,
        style: const pw.TextStyle(fontSize: 11),
      ),
    );
  }

  return widgets;
}



  
    }
  