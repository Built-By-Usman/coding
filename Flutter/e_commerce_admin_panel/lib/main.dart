import 'package:e_commerce_admin_panel/components/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Enable persistent login for Web
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  // Check if user is already logged in
  User? user = FirebaseAuth.instance.currentUser;

  // Set initial route based on user login
  String initialRoute = user != null ? '/home' : '/login';

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: allPages,
    ),
  );
}
