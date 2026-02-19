import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/app_route.dart';

class HomeScreenController extends GetxController {
  // Tabs
  final List<String> tabs = ["chats", "status", "calls"];

  // Screens for TabBarView
  final List<Widget> tabBarViews = const [
    // ChatScreen(),
    // StatusScreen(),
  ];

  // Pop-up menu items
  final List<String> popMenuItems = [
    "New group",
    "New boradcast",
    "Whatsapp Web",
    "Stared messages",
    "Settings",
  ];

  // Selected pop-up menu
  String popUpMenu = "New group";

  // Dummy data for later use
  // List<ChatModel> chats = [];
  // ChatModel? sender;

  // Update selected menu
  void selectPopMenu(String? value) {
    if (value != null) {
      popUpMenu = value;
      update(); // optional to update UI if needed
    }
  }

  // Navigate to camera screen
  void goToCameraScreen() {
    Get.toNamed(AppRoute.login);
  }
}