import 'package:e_commerce_admin_panel/config/colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? inputType;
  final bool obsecure;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.inputType,
    this.obsecure = false, // Optional default
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType, // ✅ Set input type
      obscureText: obsecure,   // ✅ Set obscureText
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: grey,
          fontSize: 12,
          fontFamily: 'karla',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}
