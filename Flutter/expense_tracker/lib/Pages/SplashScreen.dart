import 'package:expense_tracker/Components/AppColors.dart';
import 'package:expense_tracker/Controller/SplashScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            colors: [AppColors.gradientColor,AppColors.background],
            radius: 0.5,
          ),
        ),
      ),
    );
  }
}
