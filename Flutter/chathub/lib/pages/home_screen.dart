import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_string.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.put(HomeScreenController());

    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.appName),
          actions: [
            IconButton(
              onPressed: () => controller.goToCameraScreen(),
              icon: const Icon(Icons.camera_alt_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              onSelected: (value) => controller.selectPopMenu(value),
              itemBuilder: (context) {
                return controller.popMenuItems.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            tabs: controller.tabs.map((tab) {
              return Tab(child: Text(tab.toUpperCase()));
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: controller.tabBarViews,
        ),
      ),
    );
  }
}