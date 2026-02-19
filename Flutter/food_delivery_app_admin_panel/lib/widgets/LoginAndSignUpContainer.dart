import 'package:flutter/cupertino.dart';

import '../components/AppColors.dart';

class LoginAndSignUpContainer extends StatelessWidget {
  final Widget widget;
  LoginAndSignUpContainer({super.key, required this.widget});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors().white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: widget,
    );
  }
}
