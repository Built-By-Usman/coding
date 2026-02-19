import 'package:get/get.dart';
import 'package:practice_project/components/AppRoutes.dart';

class SplashScreenController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2),(){
      Get.toNamed(AppRoutes.homeScreen);
    });
  }

}