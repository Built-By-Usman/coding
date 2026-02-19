import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/colors.dart';
import '../../../../controllers/home/teacher/teacherStudentsController.dart';
import '../../../../widgets/teacherStudentsListView.dart';

class TeacherStudents extends StatelessWidget {
  final String teacherId;
  final String teacherName;
  final String classId;
  final String className;
  final String subjectId;
  final String subjectName;

  const TeacherStudents({
    super.key,
    required this.teacherId,
    required this.teacherName,
    required this.classId,
    required this.className,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    final TeacherStudentsController studentsController = Get.put(
      TeacherStudentsController(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (studentsController.teacherStudents.isEmpty) {
        studentsController.fetchTeacherClasses(
          context,
          teacherId,
          classId,
          subjectId,
        );
      }
    });

    return Scaffold(
      backgroundColor: background,
      body: Obx(() {
        if (studentsController.teacherStudents.isEmpty) {
          return const Center(child: Text("No Student found."));
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
                        'Sir $teacherName – $subjectName ($className)',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage Students',
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
                      controller: studentsController.teacherStudentController,
                      decoration: InputDecoration(
                        hint: Text(
                          'Search by Student Roll No',
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
                    itemCount:
                        studentsController.filteredTeacherStudents.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4,
                        ),
                    itemBuilder: (context, index) {
                      final teacherStudent =
                          studentsController.filteredTeacherStudents[index];
                      return TeacherStudentsListView(
                        name: teacherStudent.name,
                        rollNo: teacherStudent.rollNo,
                        icon: const Icon(Icons.person),
                        onTap: () {},
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
