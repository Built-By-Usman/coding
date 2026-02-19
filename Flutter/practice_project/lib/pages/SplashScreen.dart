import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/components/AppColors.dart';
import 'package:practice_project/controller/SplashScreenController.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetxController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightBlue, AppColors.darkBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Travel',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                SvgPicture.asset('assets/icons/logo.svg'),
              ],
            ),
            SizedBox(height: 10,),
            Text(
              'Find Your Dream \nDestination With Us',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.lightWhite,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
