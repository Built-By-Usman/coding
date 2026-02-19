import 'package:e_commerce_admin_panel/config/colors.dart';
import 'package:e_commerce_admin_panel/controllers/auth/loginController.dart';
import 'package:e_commerce_admin_panel/widgets/elevatedButton.dart';
import 'package:e_commerce_admin_panel/widgets/text.dart';
import 'package:e_commerce_admin_panel/widgets/textField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/shape1.png',
              width: 300,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/shape2.png',
              width: 300,
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              shadowColor: grey,
              color: white,
              child: Container(
                width: 450,
                height: 450,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(text: 'Welcome Back', size: 30, color: black),
                    MyText(
                      text:
                          'Login to enjoy all the services without any ads for free!',
                      size: 12,
                      color: grey,
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: controller.emailController,
                      label: 'Email',
                      inputType: TextInputType.emailAddress,
                      obsecure: false,
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                      controller: controller.passwordController,
                      label: 'Password',
                      inputType: TextInputType.text,
                      obsecure: true,
                    ),
                    SizedBox(height: 30),
                    MyElevatedButton(
                      text: "Login",
                      onPressed: () {
                        controller.onLogin();
                      },
                    ),
                    SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: black,
                          fontFamily: 'karla',
                        ),
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Sign Up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed('/signUp');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
