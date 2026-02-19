import 'package:e_commerce_admin_panel/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String subTitle) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'karla',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    backgroundColor: primaryColor,
    messageText: Text(
      subTitle,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'karla',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
