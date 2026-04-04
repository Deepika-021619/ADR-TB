import 'package:flutter/material.dart';

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
  // LFT (29) - EACH ON SEPARATE LINE ✅
  String? q29Answer;
  String? q291AST;
  String? q291ASTUpper;
  String? q291ASTBase;
  String? q291ALT;
  String? q291ALTUpper;
  String? q291ALTBase;
  String? q291ALP;
  String? q291ALPUpper;
  String? q291ALPBase;
  String? q291TBili;
  String? q291TBiliUpper;
  String? q291TBiliBase;
  String? q291DBili;
  String? q291DBiliUpper;
  String? q291DBiliBase;

  // Hemoglobin (30)
  String? q30Answer;
  String? q301Hgb;
  String? q301HgbLLN;
  String? q301HgbBase;

  // Platelets (31)
  String? q31Answer;
  String? q311Platelets;
  String? q311PlateletsLLN;
  String? q311PlateletsBase;

  // Uric Acid (32)
  String? q32Answer;
  String? q321UricAcid;
  String? q321UricAcidULN;
  String? q321UricAcidBase;

  bool get showLFT => q29Answer == 'Yes';
  bool get showHgb => q30Answer == 'Yes';
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
              if (showLFT) ...[
                const SizedBox(height: 20),
                Text(
                  "29.1. LFT Results Entry (Please enter the most recent lab values)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                const SizedBox(height: 20),
                _buildLabTriple(
                  "AST (SGOT)",
                  q291AST,
                  q291ASTUpper,
                  q291ASTBase,
                  (v1, v2, v3) {
                    setState(() {
                      q291AST = v1;
                      q291ASTUpper = v2;
                      q291ASTBase = v3;
                    });
                  },
                ),
                _buildLabTriple(
                  "ALT (SGPT)",
                  q291ALT,
                  q291ALTUpper,
                  q291ALTBase,
                  (v1, v2, v3) {
                    setState(() {
                      q291ALT = v1;
                      q291ALTUpper = v2;
                      q291ALTBase = v3;
                    });
                  },
                ),
                _buildLabTriple(
                  "Alkaline Phosphatase (ALP)",
                  q291ALP,
                  q291ALPUpper,
                  q291ALPBase,
                  (v1, v2, v3) {
                    setState(() {
                      q291ALP = v1;
                      q291ALPUpper = v2;
                      q291ALPBase = v3;
                    });
                  },
                ),
                _buildLabTriple(
                  "Total Bilirubin",
                  q291TBili,
                  q291TBiliUpper,
                  q291TBiliBase,
                  (v1, v2, v3) {
                    setState(() {
                      q291TBili = v1;
                      q291TBiliUpper = v2;
                      q291TBiliBase = v3;
                    });
                  },
                ),
                _buildLabTriple(
                  "Direct Bilirubin",
                  q291DBili,
                  q291DBiliUpper,
                  q291DBiliBase,
                  (v1, v2, v3) {
                    setState(() {
                      q291DBili = v1;
                      q291DBiliUpper = v2;
                      q291DBiliBase = v3;
                    });
                  },
                ),
              ],

              // 30. HEMOGLOBIN
              const SizedBox(height: 30),
              _buildRadioQuestion(
                number: "30",
                question: "Did you get your hemoglobin (Hgb) tested recently?",
                options: ['Yes', 'No'],
                value: q30Answer,
                onChanged: (val) => setState(() => q30Answer = val),
              ),
              if (showHgb) ...[
                const SizedBox(height: 20),
                Text(
                  "30.1 Please enter your most recent hemoglobin (Hgb) values:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                const SizedBox(height: 20),
                _buildLabTriple(
                  "Hgb",
                  q301Hgb,
                  q301HgbLLN,
                  q301HgbBase,
                  (v1, v2, v3) {
                    setState(() {
                      q301Hgb = v1;
                      q301HgbLLN = v2;
                      q301HgbBase = v3;
                    });
                  },
                  lln: true,
                ),
              ],

              // 31. PLATELETS
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
                Text(
                  "31.1 Please enter your most recent lab values of platelet count:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                const SizedBox(height: 20),
                _buildLabTriple(
                  "Platelet count",
                  q311Platelets,
                  q311PlateletsLLN,
                  q311PlateletsBase,
                  (v1, v2, v3) {
                    setState(() {
                      q311Platelets = v1;
                      q311PlateletsLLN = v2;
                      q311PlateletsBase = v3;
                    });
                  },
                  lln: true,
                ),
              ],

              // 32. URIC ACID
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
                Text(
                  "32.1 Please enter your most recent lab values of Serum uric acid",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
                const SizedBox(height: 20),
                _buildLabTriple(
                  "Serum uric acid",
                  q321UricAcid,
                  q321UricAcidULN,
                  q321UricAcidBase,
                  (v1, v2, v3) {
                    setState(() {
                      q321UricAcid = v1;
                      q321UricAcidULN = v2;
                      q321UricAcidBase = v3;
                    });
                  },
                ),
              ],
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        label: const Text('Save & Complete Report', style: TextStyle(fontWeight: FontWeight.bold)),
        heroTag: "save_investigations_complete",
        onPressed: _isComplete()
            ? () {
                _saveInvestigations();
                widget.onSaveAndComplete();
              }
            : null,
      ),
    );
  }

  Widget _buildRadioQuestion({
    required String number,
    required String question,
    required List<String> options,
    required String? value,
    required Function(String) onChanged,
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
            ...options.map((option) => RadioListTile<String>(
                  title: Text(option, style: const TextStyle(fontSize: 14)),
                  value: option,
                  groupValue: value,
                  onChanged: (val) => onChanged(val ?? ''),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildLabTriple(
    String label,
    String? value,
    String? limit,
    String? baseline,
    Function(String?, String?, String?) onChanged, {
    bool lln = false,
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
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildNumericField("Current", value, onChanged, 0)),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNumericField(
                    lln ? "LLN" : "Upper Limit",
                    limit,
                    onChanged,
                    1,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNumericField(
                    "Baseline (optional)",
                    baseline,
                    onChanged,
                    2,
                    optional: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericField(
    String label,
    String? value,
    Function(String?, String?, String?) onChanged,
    int index, {
    bool optional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        TextFormField(
          keyboardType: TextInputType.number,
          initialValue: value ?? '',
          onChanged: (val) {
            String? v1, v2, v3;
            if (index == 0) v1 = val.isEmpty ? null : val;
            if (index == 1) v2 = val.isEmpty ? null : val;
            if (index == 2) v3 = val.isEmpty ? null : val;
            onChanged(v1, v2, v3);
          },
          decoration: InputDecoration(
            hintText: optional ? "Optional" : "Enter value",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  bool _isComplete() {
    if (q29Answer == null || q30Answer == null || q31Answer == null || q32Answer == null) {
      return false;
    }
    
    if (showLFT) {
      if (q291AST == null || q291ALT == null || q291ALP == null ||
          q291TBili == null || q291DBili == null) return false;
    }
    
    if (showHgb && (q301Hgb == null || q301HgbLLN == null)) return false;
    
    if (showPlatelets && (q311Platelets == null || q311PlateletsLLN == null)) return false;
    
    if (showUricAcid && (q321UricAcid == null || q321UricAcidULN == null)) return false;
    
    return true;
  }

  void _saveInvestigations() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Investigations data saved! Report Complete!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    // TODO: Save to backend API
  }
}
