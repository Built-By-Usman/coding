import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home/homeSideBar.dart';
import '../../widgets/sidebar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    sideBarController controller = Get.put(sideBarController());

    return Scaffold(
      body: Row(
        children: [
          const Expanded(flex: 2, child: Sidebar()),
          Expanded(
            flex: 10,
            child: Obx(() {
              return controller.sidePages[controller.index.value];
            }),
          ),
        ],
      ),
    );
  }
}
