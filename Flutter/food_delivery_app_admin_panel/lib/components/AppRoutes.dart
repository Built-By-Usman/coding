import 'package:food_delivery_app_admin_panel/pages/HomeScreen.dart';
import 'package:food_delivery_app_admin_panel/pages/SideNavigation.dart';
import 'package:get/get.dart';

var appRoutes = [
  GetPage(name: '/HomeScreen', page: () => HomeScreen()),
  GetPage(name: '/SideNavigation', page: () => SideNavigation()),
];
