import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AppColors.dart';

class Utils {
  void mySnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors().primary,
      colorText: AppColors().white,
      duration: Duration(seconds: 2),
    );
  }
}
