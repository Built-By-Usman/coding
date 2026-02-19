import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/constant/app_route.dart';
import '../../services/ApiClient.dart';

class LoginController extends GetxController {
  final ApiClient apiClient = ApiClient();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Observables
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var name = ''.obs;
  var isLoading = false.obs;
  var isOtpSent = false.obs;
  var otp = ''.obs;
  var isEmailValid = false.obs;
  var isFormValid = false.obs;

  // Controllers
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();



  // Email validation
  bool validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

// Validate phone (simple check: length >= 10 digits)
  bool validatePhone(String value) {
    return value.replaceAll(RegExp(r'\D'), '').length >= 10;
  }

// Update form validity whenever a field changes
  void updateFormValidity() {
    isFormValid.value =
        name.value.trim().isNotEmpty &&
            isEmailValid.value &&
            validatePhone(phoneNumber.value);
  }

  Future<void> sendOtp() async {
    if (!isFormValid.value) return; // Ensure name, email, and phone are valid

    print("Sending OTP to ${emailController.text.trim()}");
    isLoading.value = true;

    try {
      final response = await apiClient.dio.post(
        '/auth/request_otp',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone_number': phoneController.text.trim(),
        },
      );

      final data = response.data;
      final detailMessage = data['detail'] ?? "OTP sent successfully";

      Get.snackbar('Success', detailMessage);
      isOtpSent.value = true; // Show OTP input field

    } on DioException catch (e) {
      String errorMessage = "Unknown Error";

      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['detail'] ?? errorMessage;
      }

      Get.snackbar(
        'Error ${e.response?.statusCode ?? ''}',
        errorMessage,
      );

    } finally {
      isLoading.value = false;
    }
  }
  void submitLogin() {
    print(
      'Phone: ${phoneNumber.value}, Email: ${email.value}, Name: ${name.value}',
    );
    login(
      emailController.text.trim(),
      otp.value
    );
  }


  /// Login API call
  Future<void> login(String email, String otp) async {
    if (otp.isEmpty || email.isEmpty) {
      Get.snackbar('Error', 'OTP and email are required');
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiClient.dio.post(
        '/auth/verify_otp',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'email': email,  // <-- FIXED: send email, not name
          'otp': otp,
        },
      );

      final body = response.data;
      final token = body['access_token'] ?? body['token'];

      if (token != null) {
        // Save token securely
        await storage.write(key: 'token', value: token);

        // Save user info locally
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('is_logged_in', true);
        prefs.setInt('id', body['id'] ?? 0);
        prefs.setString('name', body['name'] ?? '');
        prefs.setString('email', body['email'] ?? email);

        // Navigate to Home
        // Get.to(AppRoute.home, arguments: {
        //   "chat": chatList, // your List<ChatModel>
        //   "sender": 'usman', // your ChatModel
        // });
       // your chat list
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.snackbar('Error', 'Token missing from server response');
      }
    } on DioException catch (e) {
      String errorMessage = "Unknown error occurred";
      final data = e.response?.data;

      if (data is Map && data.containsKey('detail')) {
        errorMessage = data['detail'];
      } else if (data is String) {
        errorMessage = data;
      }

      Get.snackbar(
        "Error ${e.response?.statusCode ?? ''}",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
