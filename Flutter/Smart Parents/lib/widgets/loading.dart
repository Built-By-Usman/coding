import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dot1, _dot2, _dot3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..repeat();

    _dot1 = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.3, curve: Curves.easeInOut)),
    );
    _dot2 = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.5, curve: Curves.easeInOut)),
    );
    _dot3 = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.7, curve: Curves.easeInOut)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(animation: _controller, builder: (_, __) => Transform.translate(offset: Offset(0, _dot1.value), child: Dot())),
        SizedBox(width: 4),
        AnimatedBuilder(animation: _controller, builder: (_, __) => Transform.translate(offset: Offset(0, _dot2.value), child: Dot())),
        SizedBox(width: 4),
        AnimatedBuilder(animation: _controller, builder: (_, __) => Transform.translate(offset: Offset(0, _dot3.value), child: Dot())),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.grey[600], shape: BoxShape.circle));
  }
}
