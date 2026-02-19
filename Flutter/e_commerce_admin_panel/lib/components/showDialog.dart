import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset(
              'assets/animations/loading.json',
              repeat: true,
            ),
          ),
        ),
      );
    },
  );
}
