import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/showDialog.dart';
import '../../../components/snackBar.dart';
import '../../../models/teacher/teacherStudentsModel.dart';

class TeacherStudentsController extends GetxController {
  final TextEditingController teacherStudentController =
      TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<TeacherStudentsModel> teacherStudents =
      <TeacherStudentsModel>[].obs;
  final RxList<TeacherStudentsModel> filteredTeacherStudents =
      <TeacherStudentsModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    teacherStudentController.addListener(_onSearchChanged);
  }

  void fetchTeacherClasses(
    BuildContext context,
    teacherId,
    classId,
    subjectId,
  ) async {
    try {
      isLoading.value = true;
      showLoadingDialog(context);
      final snapshot = await firestore
          .collection('Teachers')
          .doc(teacherId)
          .collection('Classes')
          .doc(classId)
          .collection('Subjects')
          .doc(subjectId)
          .collection('Students')
          .orderBy('Time Stamp')
          .get();

      if (snapshot.docs.isEmpty) {
        showSnackBar('No Data', 'No Student found in the database.');
        teacherStudents.clear();
        filteredTeacherStudents.clear();
      } else {
        final loadedTeacherStudents = snapshot.docs
            .map((doc) => TeacherStudentsModel.fromMap(doc.id, doc.data()))
            .toList();
        teacherStudents.value=loadedTeacherStudents;
        filteredTeacherStudents.value=loadedTeacherStudents;
      }
    } catch (ex) {
      showSnackBar('Error', 'Failed to fetch Students.\n${ex.toString()}');
    } finally {
      isLoading.value = false;
      Navigator.pop(context);
    }
  }

  void _onSearchChanged() {
    var query = teacherStudentController.text.toLowerCase();
    if (query.isEmpty) {
      filteredTeacherStudents.value = teacherStudents;
    } else {
      filteredTeacherStudents.value = teacherStudents
          .where(
            (teacherStudents) =>
                teacherStudents.rollNo.toLowerCase().contains(query),
          )
          .toList();
    }
  }
}
