import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin_panel/pages/SideNavigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'components/AppRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zkyttylzkfwbsauxwksx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpreXR0eWx6a2Z3YnNhdXh3a3N4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY2NjAyNjMsImV4cCI6MjA3MjIzNjI2M30.EdcJpFHwi3OuXxtJwpLQxa9V_-Wyp2ZwQqq6wUzUeks',
  );
  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      debugShowCheckedModeBanner: false,
      home: SideNavigation(),
      getPages: appRoutes,
    ),
  );
}
