import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/AppColors.dart';
import '../controllers/SideNavigationController.dart';

class SideNavigation extends StatelessWidget {
  SideNavigation({Key? key}) : super(key: key);

  final SideNavigationController controller = Get.put(
    SideNavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().white,
      body: Row(
        children: [
          // Sidebar
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors().lightGrey,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/Logo.png'),
                  ),
                  SizedBox(height: 20,),


                  Expanded(child: Obx(() {
                    final selectedIndex = controller.index.value;
                    return ListView.builder(
                      itemCount: controller.pages.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ListTile(
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            minLeadingWidth: 30, // prevents width collapsing
                            leading: Icon(
                              controller.icons[index],
                              color: isSelected
                                  ? AppColors().black
                                  : Colors.black54,
                            ),
                            title: Text(
                              controller.titles[index],
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors().black
                                    : Colors.black54,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            onTap: () => controller.index.value = index,
                          ),
                        );
                      },
                    );
                  }),)
                ],
              )
            ),
          ),

          // Main Content
          Expanded(
            flex: 12,
            child: Obx(() {
              final page = controller.pages[controller.index.value];
              return Container(
                color: AppColors().white,
                child: page,
              );
            }),
          ),
        ],
      ),
    );
  }
}