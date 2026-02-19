import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  const MyText({super.key, required this.text, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontFamily: 'karla',
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
