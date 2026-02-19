import 'package:get/get.dart';
import 'package:practice_project/pages/DetailScreen.dart';
import 'package:practice_project/pages/SplashScreen.dart';

import '../pages/HomeScreen.dart';

class AppRoutes {
  static const splashScreen='/SplashScreen';
  static const homeScreen='/HomeScreen';
  static const detailScreen='/DetailScreen';
  
  static final routes=[
    GetPage(name: splashScreen, page: ()=>SplashScreen()),
    GetPage(name: homeScreen, page: ()=>HomeScreen()),
    GetPage(name: detailScreen, page: ()=>DetailScreen())
  ];
}