// lib/widgets/custom_input_decoration.dart
import 'package:flutter/material.dart';

class CustomInputDecoration {
  final String label;
  final String hint;
  final Widget? prefixIcon;

  CustomInputDecoration(this.label, this.hint, [this.prefixIcon]);

  InputDecoration customInputDecoration() {
    return InputDecoration(
      label: Text(label),
      hintText: hint,
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
