import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:expense_tracker/Components/AppColors.dart';
import 'package:expense_tracker/Controller/MainScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.grey.withOpacity(0.4),
        child: Icon(Icons.add, color: AppColors.primary),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.grey,
          icons: controller.iconList,
          activeIndex: controller.index.value,
          onTap: (index) {
            controller.changeScreen(index);
          },
        ),
      ),
    );
  }
}
