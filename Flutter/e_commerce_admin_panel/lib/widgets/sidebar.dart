
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../controllers/home/homeSideBar.dart';
import '../../widgets/sidebarItems.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final sideBarController controller = Get.find<sideBarController>();

    return Obx(() => Container(
      width: 250,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Icon(Icons.show_chart, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Attendify',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: Colors.grey, thickness: 1),
          ),
          const SizedBox(height: 10),

          // Menu Items
          SidebarItem(
            selected: controller.index.value == 0,
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => controller.index.value = 0,
          ),
          SidebarItem(
            selected: controller.index.value == 1,
            icon: Icons.person,
            title: 'All Teachers',
            onTap: () => controller.index.value = 1,
          ),
          SidebarItem(
            selected: controller.index.value == 2,
            icon: Icons.shop,
            title: 'Orders',
            onTap: () => controller.index.value = 2,
          ),
          SidebarItem(
            selected: controller.index.value == 3,
            icon: Icons.point_of_sale,
            title: 'Sales',
            onTap: () => controller.index.value = 3,
          ),
        ],
      ),
    ));
  }
}
