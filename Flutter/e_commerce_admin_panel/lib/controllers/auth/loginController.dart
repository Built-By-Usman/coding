import 'package:e_commerce_admin_panel/components/showDialog.dart';
import 'package:e_commerce_admin_panel/components/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final RxBool isLoading = false.obs;

  void onLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackBar("Validation Error", "All fields are required.");
      return;
    }

    final result = await signIn(email, password);
    if (result == "Success") {
      showSnackBar("Success", "Logged in successfully.");
      Get.toNamed('/');
    } else {
      showSnackBar("Error", result);
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      showLoadingDialog(Get.context!);

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      if (!userCredential.user!.emailVerified) {
        await auth.signOut(); // prevent access
        return "Please verify your email before logging in.";
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    } catch (e) {
      return "Something went wrong";
    } finally {
      isLoading.value = false;
      Get.back();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
