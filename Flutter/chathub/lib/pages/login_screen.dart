import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import '../core/constant/app_color.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../core/constant/app_string.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          children: [
            const Text(
              "Welcome to ${AppString.appName}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColor.second,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter your phone number to continue.",
              style: TextStyle(fontSize: 16, color: AppColor.blueGrey),
            ),
            const SizedBox(height: 40),

            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex:7,
                    child: IntlPhoneField(
                      cursorColor: AppColor.primary,
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        label: Text(
                          'Phone Number',
                          style: TextStyle(color: AppColor.primary),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.primary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: AppColor.primary),
                        ),
                      ),
                      initialCountryCode: 'PK',
                      onChanged: (phone) {
                        controller.phoneNumber.value = phone.completeNumber;
                        controller.isFormValid.value = controller.validatePhone(
                          phone.completeNumber,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ✅ IMPORTANT PART
                  Flexible(
                    flex:3,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: controller.isFormValid.value
                            ? () => controller.sendOtp()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isFormValid.value
                              ? AppColor.primary
                              : Colors.grey,
                        ),
                        child: const Text(
                          "Send Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColor.white,fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // OTP input
            Obx(
              () => controller.isOtpSent.value
                  ? TextField(
                      cursorColor: AppColor.primary,
                      maxLength: 6,
                      controller: controller.otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          'Enter OTP',
                          style: TextStyle(color: AppColor.primary),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColor.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColor.primary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColor.primary),
                        ),
                      ),
                      onChanged: (value) {
                        controller.otp.value = value;
                      },
                    )
                  : const SizedBox(),
            ),

            const SizedBox(height: 30),

            // Login button
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.otp.value.length == 6
                        ? AppColor.primary
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: controller.otp.value.length == 6
                      ? () => controller.verifyOtp()
                      : null,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "By tapping 'Login', you accept our Terms of Service and Privacy Policy.",
              style: TextStyle(fontSize: 12, color: AppColor.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
