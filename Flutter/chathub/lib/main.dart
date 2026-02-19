import 'package:ChatHub/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constant/app_color.dart';
import 'core/constant/app_route.dart';
import 'core/constant/app_size.dart';
import 'core/constant/app_string.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return GetMaterialApp(
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica',
        primaryColor: AppColor.second,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColor.second,
          foregroundColor: AppColor.white,
        ),
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColor.white,
          labelColor: AppColor.white,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          unselectedLabelColor: AppColor.white.withOpacity(0.5),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          color: AppColor.primary,
          foregroundColor: AppColor.white,
        ),
        useMaterial3: true,
      ),
      getPages: routes,
      initialRoute: AppRoute.splash,
    );
  }
}
