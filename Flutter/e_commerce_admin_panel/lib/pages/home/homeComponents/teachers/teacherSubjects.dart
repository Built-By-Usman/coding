import 'package:e_commerce_admin_panel/pages/home/homeComponents/teachers/teacherStudents.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/colors.dart';
import '../../../../controllers/home/teacher/teacherSubjectsController.dart';
import '../../../../widgets/teacherListView.dart';

class TeacherSubjects extends StatelessWidget {
  final String teacherId;
  final String teacherName;
  final String classId;
  final String className;

  const TeacherSubjects({
    super.key,
    required this.teacherId,
    required this.teacherName,
    required this.classId,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    final TeacherSubjectsController subjectsController = Get.put(
      TeacherSubjectsController(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (subjectsController.teacherSubjects.isEmpty) {
        subjectsController.fetchTeacherClasses(context, teacherId, classId);
      }
    });

    return Scaffold(
      backgroundColor: background,
      body: Obx(() {
        if (subjectsController.teacherSubjects.isEmpty) {
          return const Center(child: Text("No Subject found."));
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
                       'Sir $teacherName – $className Subjects',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage Subjects for Sir $teacherName',
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
                      controller: subjectsController.subjectController,
                      decoration: InputDecoration(
                        hint: Text(
                          'Search by Subject Name',
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

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GridView.builder(
                    itemCount: subjectsController.filteredTeacherSubjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4,
                        ),
                    itemBuilder: (context, index) {
                      final teacherSubject =
                          subjectsController.filteredTeacherSubjects[index];
                      return TeacherListView(
                        name: teacherSubject.name,
                        icon: const Icon(Icons.person),
                        onTap: () {
                          Get.to(
                            () => TeacherStudents(
                              teacherId: teacherId,
                              teacherName:teacherName,
                              classId: classId,
                              className:className,
                              subjectId: teacherSubject.id,
                              subjectName:teacherSubject.name
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
