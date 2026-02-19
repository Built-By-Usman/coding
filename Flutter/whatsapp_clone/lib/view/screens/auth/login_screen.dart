import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:whatsapp_clone/core/constant/app_color.dart';
import 'package:whatsapp_clone/controllers/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          children: [
            const Text(
              "Welcome to ChatHub",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColor.second,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Enter your phone number and email to continue.",
              style: TextStyle(fontSize: 16, color: AppColor.blueGrey),
            ),
            const SizedBox(height: 40),

            // Name input
            TextField(
              controller: controller.nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'John Doe',
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
                controller.name.value = value;
                controller.updateFormValidity();
              },
            ),
            const SizedBox(height: 20),

            // Phone input
            IntlPhoneField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
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
              initialCountryCode: 'PK',
              onChanged: (phone) {
                controller.phoneNumber.value = phone.completeNumber;
                controller.updateFormValidity();
              },
            ),
            const SizedBox(height: 10),

            // Email + Send Code row
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'you@example.com',
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
                        controller.email.value = value;
                        controller.isEmailValid.value = controller.validateEmail(value);
                        controller.updateFormValidity(); // update isFormValid
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.isFormValid.value
                        ? () => controller.sendOtp()
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isFormValid.value
                          ? AppColor.primary
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Send Code",
                      style: TextStyle(color: AppColor.white),
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
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
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
                      ? () => controller.submitLogin()
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
