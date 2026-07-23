import 'package:flutter/material.dart';

Widget requiredLabel(String text) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
      ),
      children: const [
        TextSpan(
          text: " *",
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
}