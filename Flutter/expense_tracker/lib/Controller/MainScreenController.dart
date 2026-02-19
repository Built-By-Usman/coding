import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  RxInt index = 0.obs;


  final iconList=<IconData>[
    Icons.home,
    Icons.bar_chart,
    Icons.account_balance_wallet,
    Icons.person

  ];

  void changeScreen(int newIndex){
    index.value = newIndex;
  }



}