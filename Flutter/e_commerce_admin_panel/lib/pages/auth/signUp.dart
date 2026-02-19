import 'package:e_commerce_admin_panel/config/colors.dart';
import 'package:e_commerce_admin_panel/controllers/auth/signUpController.dart';
import 'package:e_commerce_admin_panel/widgets/elevatedButton.dart';
import 'package:e_commerce_admin_panel/widgets/text.dart';
import 'package:e_commerce_admin_panel/widgets/textField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final SignUpController controller = Get.put(SignUpController());

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
                    MyText(text: 'Create Account', size: 30, color: black),
                    MyText(
                      text:
                          'Create Account to enjoy all the services without any ads for free!',
                      size: 12,
                      color: grey,
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: controller.nameController,
                      label: 'Name',
                      inputType: TextInputType.text,
                      obsecure: false,
                    ),
                    SizedBox(height: 20),
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
                      text: "Sign Up",
                      onPressed: () {
                        controller.onSignUp();
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
                          TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: 'Login',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed('/login');
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
