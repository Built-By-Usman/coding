import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartparents/components/routes.dart';

void main()  {

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: allPages,
    ),
  );
}
