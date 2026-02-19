import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final VoidCallback? method;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const MyText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.weight,
    this.method,
    this.align,
    this.maxLines,
    this.overflow
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: method,
      child: Text(
        overflow: overflow,
        maxLines: maxLines,
        textAlign: align,
        text,
        style: TextStyle(fontSize: size, color: color, fontWeight: weight),
      ),
    );
  }
}
