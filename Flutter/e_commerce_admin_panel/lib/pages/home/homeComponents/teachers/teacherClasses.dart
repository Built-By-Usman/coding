import 'package:e_commerce_admin_panel/config/colors.dart';
import 'package:e_commerce_admin_panel/controllers/home/teacher/teacherClassesController.dart';
import 'package:e_commerce_admin_panel/pages/home/homeComponents/teachers/teacherSubjects.dart';
import 'package:e_commerce_admin_panel/widgets/teacherListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherClasses extends StatelessWidget {
  final String teacherId;
  final String teacherName;

  const TeacherClasses({
    super.key,
    required this.teacherId,
    required this.teacherName,
  });

  @override
  Widget build(BuildContext context) {
    final TeacherClassesController classesController = Get.put(
      TeacherClassesController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (classesController.teacherClasses.isEmpty) {
        classesController.fetchTeacherClasses(context, teacherId);
      }
    });

    return Scaffold(
      backgroundColor: background,
      body: Obx(() {
        if (classesController.teacherClasses.isEmpty) {
          return const Center(child: Text("No Class found."));
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sir $teacherName Classes',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Manage Classes',
                        style: TextStyle(
                          fontSize: 16,
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
                      controller:
                          classesController.teacherClassSearchController,
                      decoration: InputDecoration(
                        hint: Text(
                          'Search by Class Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
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
                    itemCount: classesController.filteredTeacherClasses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4,
                        ),
                    itemBuilder: (context, index) {
                      final teacherClasses =
                          classesController.filteredTeacherClasses[index];
                      return TeacherListView(
                        name: teacherClasses.name,
                        icon: const Icon(Icons.person),
                        onTap: () {
                          Get.to(
                            () => TeacherSubjects(
                              teacherId: teacherId,
                              teacherName:teacherName,
                              classId: teacherClasses.id,
                              className:teacherClasses.name
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
