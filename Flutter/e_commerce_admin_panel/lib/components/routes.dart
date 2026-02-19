import 'package:e_commerce_admin_panel/pages/home/home.dart';
import 'package:e_commerce_admin_panel/pages/auth/login.dart';
import 'package:e_commerce_admin_panel/pages/auth/signUp.dart';
import 'package:get/get.dart';

List<GetPage> allPages = [
  GetPage(name: '/', page: () => Home()),
  GetPage(name: '/signUp', page: () => SignUp()),
  GetPage(name: '/login', page: ()=>Login())
];
