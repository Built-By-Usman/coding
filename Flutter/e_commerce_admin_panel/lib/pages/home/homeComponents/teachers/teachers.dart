import 'package:e_commerce_admin_panel/config/colors.dart';
import 'package:e_commerce_admin_panel/pages/home/homeComponents/teachers/teacherClasses.dart';
import 'package:e_commerce_admin_panel/widgets/teacherListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/home/teacher/teacherController.dart';

class Teachers extends StatelessWidget {
  const Teachers({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherController controller = Get.put(TeacherController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.teachers.isEmpty) {
        controller.fetchTeachers(context);
      }
    });

    return Scaffold(
      backgroundColor: background,
      body: Obx(() {
        if (controller.teachers.isEmpty) {
          return const Center(child: Text("No teachers found."));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search bar at the top right
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Teachers',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Manage Your Teachers',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  // Search Bar
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: controller.teacherSearchController,
                      decoration: InputDecoration(
                        hint: Text(
                          'Search by Teacher Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: grey,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),

              // 🧑‍🏫 Teachers Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GridView.builder(
                    itemCount: controller.filteredTeachers.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 4,
                    ),
                    itemBuilder: (context, index) {
                      final teacher = controller.filteredTeachers[index];
                      return TeacherListView(
                        name: teacher.name,
                        icon: const Icon(Icons.person),
                        onTap: () {
                          Get.to(() => TeacherClasses(teacherId: teacher.id,teacherName:teacher.name));
                        },
                      );
                    },
                  )

                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
