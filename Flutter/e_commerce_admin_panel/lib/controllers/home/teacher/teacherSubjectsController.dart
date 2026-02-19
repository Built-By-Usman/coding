import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/showDialog.dart';
import '../../../components/snackBar.dart';
import '../../../models/teacher/teacherSubjectsModel.dart';

class TeacherSubjectsController extends GetxController {
  final TextEditingController subjectController =
      TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<TeacherSubjectsModel> teacherSubjects =
      <TeacherSubjectsModel>[].obs;
  final RxList<TeacherSubjectsModel> filteredTeacherSubjects =
      <TeacherSubjectsModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    subjectController.addListener(_onSearchChanged);
  }

  void fetchTeacherClasses(BuildContext context, teacherId, classId) async {
    try {
      isLoading.value = true;
      showLoadingDialog(context);
      final snapshot = await firestore
          .collection('Teachers')
          .doc(teacherId)
          .collection('Classes')
          .doc(classId)
          .collection('Subjects')
          .orderBy('Time Stamp')
          .get();

      if (snapshot.docs.isEmpty) {
        showSnackBar('No Data', 'No Subject found in the database.');
        teacherSubjects.clear();
        filteredTeacherSubjects.clear();
      } else {
        final loadedTeacherSubjects = snapshot.docs
            .map((doc) => TeacherSubjectsModel.fromMap(doc.id, doc.data()))
            .toList();
        teacherSubjects.value = loadedTeacherSubjects;
        filteredTeacherSubjects.value = loadedTeacherSubjects;
      }
    } catch (ex) {
      showSnackBar(
        'Error',
        'Failed to fetch teacher Subjects.\n${ex.toString()}',
      );
    } finally {
      isLoading.value = false;
      Navigator.pop(context);
    }
  }

  void _onSearchChanged() {
    final query = subjectController.text.toLowerCase();
    if (query.isEmpty) {
      filteredTeacherSubjects.value = teacherSubjects;
    } else {
      filteredTeacherSubjects.value = teacherSubjects
          .where(
            (teacherSubjects) =>
                teacherSubjects.name.toLowerCase().contains(query),
          )
          .toList();
    }
  }
}
