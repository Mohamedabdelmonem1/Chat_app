import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.scure = false,
      required this.hint,
      required this.onChanged});

  final String hint;
  Function(String) onChanged;
  bool? scure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: scure!,
      validator: (value) {
        if (value!.isEmpty) {
          return "field is required";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          ))),
    );
  }
}
