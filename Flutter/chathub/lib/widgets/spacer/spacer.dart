import 'package:flutter/material.dart';
import '../../core/constant/app_size.dart';

class HorizontalSpacer extends StatelessWidget {
  final double value;
  const HorizontalSpacer(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: AppSize.defaultSize! * value);
  }
}

class VerticalSpacer extends StatelessWidget {
  final double value;
  const VerticalSpacer(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: AppSize.defaultSize! * value);
  }
}