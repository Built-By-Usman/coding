import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/components/AppRoutes.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'poppins'
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    )
  );
}
