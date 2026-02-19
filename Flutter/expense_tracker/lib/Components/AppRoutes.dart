import 'package:expense_tracker/Pages/HomeScreen.dart';
import 'package:expense_tracker/Pages/MainScreen.dart';
import 'package:expense_tracker/Pages/SplashScreen.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static final splash = '/Splash';
  static final home = '/Home';
  static final main = '/Main';

  final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: main, page: () => MainScreen()),
  ];
}
