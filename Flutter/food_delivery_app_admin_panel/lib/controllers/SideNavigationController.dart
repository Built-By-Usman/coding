import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app_admin_panel/pages/AddScreen.dart';
import 'package:food_delivery_app_admin_panel/pages/HomeScreen.dart';
import 'package:food_delivery_app_admin_panel/pages/Orders.dart';

class SideNavigationController extends GetxController {
  RxInt index = 0.obs;

  // Titles for navigation
  final titles = ["Home", "Add", "Orders"];

  // Icons for navigation
  final icons = [
    Icons.home,
    Icons.add,
    Icons.shopping_cart,
  ];

  // Pages
  final pages = [
    HomeScreen(),
    AddScreen(),
    OrdersScreen(),
  ];
}