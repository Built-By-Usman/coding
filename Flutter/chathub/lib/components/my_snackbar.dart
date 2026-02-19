import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
    );
  }
}
