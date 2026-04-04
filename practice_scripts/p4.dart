import 'dart:io';

String report() {
  // 1. Name
  stdout.write('Enter name: ');
  String? name = stdin.readLineSync();
  if (name == null || name.trim().isEmpty) return "Name required.";

  // 2. Age
  stdout.write('Enter age: ');
  String? ageInput = stdin.readLineSync();
  if (ageInput == null || ageInput.trim().isEmpty) return "Age required.";
  int? age = int.tryParse(ageInput);
  if (age == null) return "Invalid age entry.";

  // 3. Blood Pressure
  stdout.write('Enter systolic (top): ');
  String? sInput = stdin.readLineSync();
  stdout.write('Enter diastolic (bottom): ');
  String? dInput = stdin.readLineSync();

  if (sInput == null || dInput == null) return "BP values required.";

  try {
    int sys = int.parse(sInput);
    int dia = int.parse(dInput);
    String status;

    if (sys < 90 || dia < 60) {
      status = "Hypotension";
    } else if (sys >= 140 || dia >= 90) {
      status = "Hypertension";
    } else {
      status = "Normal BP";
    }

    // Return the final collective report
    return "\n--- Medical Report ---\nPatient: $name\nAge: $age\nStatus: $status";
  } catch (e) {
    return "Invalid entry.";
  }
}

void main() {
  String result = report();
  print(result);
}
