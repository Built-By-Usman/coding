import 'package:flutter/material.dart';

import '../components/AppColors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback method;

  const MainButton({super.key, required this.text, required this.method});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: GestureDetector(
        onTap: method,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors().primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
                color: AppColors().white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
