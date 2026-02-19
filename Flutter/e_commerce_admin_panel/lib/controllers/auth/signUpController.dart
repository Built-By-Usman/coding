import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_panel/components/showDialog.dart';
import 'package:e_commerce_admin_panel/components/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs;

  void onSignUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showSnackBar("Validation Error", "All fields are required.");
      return;
    }

    final result = await createAccount(name, email, password);
    if (result == "Success") {
      showSnackBar("Account Created",'Please Verify your email');
      Get.toNamed('/login');
    } else {
      showSnackBar("Error", result);
    }
  }

  Future<String> createAccount(
      String name,
      String email,
      String password,
      ) async {
    try {
      isLoading.value = true;
      showLoadingDialog(Get.context!);

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user in Firestore
      await firestore.collection('Hod').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "This email is already registered.";
      } else if (e.code == 'weak-password') {
        return "The password is too weak.";
      } else if (e.code == 'invalid-email') {
        return "Invalid email format.";
      }
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
