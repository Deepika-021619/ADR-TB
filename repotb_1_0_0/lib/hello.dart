import 'dart:io';

String greetings() {
  stdout.write("How should i greet you?");
  String? input = stdin.readLineSync();
  if (input == null || input.trim().isEmpty) {
    return "Required input";
  } else {
    return input;
  }
}

void main() {
  String input = greetings();
  print("$input, Buddy! have a nice day.");
}
