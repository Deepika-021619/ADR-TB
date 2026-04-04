import 'dart:io';

String checkHeartRate() {
  print("Enter patient heart rate (bpm): ");
  String? input = stdin.readLineSync();
  
  if (input == null || input.trim().isEmpty) {
    return " Heart rate required";
  }
  
  try {
    double heartRate = double.parse(input.trim());
    
    // Range check FIRST
    if (heartRate < 40 || heartRate > 200) {
      return " Unrealistic heart rate (40-200 bpm)";
    }
    
    // Diagnosis in order
    if (heartRate < 60) {
      return "Bradycardia (Low)";
    } else if (heartRate > 120) {
      return "Dangerous - Emergency";
    } else if (heartRate >= 100) {
      return "Tachycardia (High)";
    } else {
      return "Normal";
    }
  } catch (e) {
    return " Enter valid number (40-200)";
  }
}

void main() {
  String result = checkHeartRate();
  print("Diagnosis: " + result);
}
