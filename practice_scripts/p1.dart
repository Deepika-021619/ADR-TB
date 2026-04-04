import 'dart:io';

String checkTemperature() {
  print("Enter patient temperature (°F): ");
  String? input = stdin.readLineSync();
  
  // CHECK FOR EMPTY INPUT
  if (input == null || input.trim().isEmpty) {
    return "❌ Temperature information required";
  }
  
  // Convert to number
  try {
    double temp = double.parse(input);
    
    if (temp > 100.4) {
      return "🔥 High Fever - Urgent Care Needed";
    } else if (temp > 99.5) {
      return "🌡️ Mild Fever - Monitor Closely";
    } else {
      return "✅ Normal Temperature";
    }
  } catch (e) {
    return "❌ Invalid number entered. Please use format like 98.6";
  }
}

void main() {
  print("=== ADR Patient Temperature Check ===");
  String result = checkTemperature();
  print("Diagnosis: " + result);
}
