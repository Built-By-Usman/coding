import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BackArrow extends StatelessWidget {
  final Color color;
  final Color arrowColor;

  const BackArrow({super.key, required this.color, required this.arrowColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Icon(Icons.arrow_back, color: arrowColor)),
      ),
    );
  }
}
