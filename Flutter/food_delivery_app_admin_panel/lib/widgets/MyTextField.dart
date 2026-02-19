import 'package:flutter/material.dart';

import '../components/AppColors.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final Color color;
  final bool filled;
  final double radius;
  final TextEditingController textEditingController;
  final bool isPassword;

  const MyTextField({
    super.key,
    required this.hint,
    required this.color,
    required this.filled,
    required this.radius,
    required this.textEditingController,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: textEditingController,
      cursorColor: AppColors().black,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: color,
        filled: filled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
