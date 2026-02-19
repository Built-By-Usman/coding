import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_panel/components/showDialog.dart';
import 'package:e_commerce_admin_panel/components/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/teacher/teacherModel.dart';

class TeacherController extends GetxController {
  final TextEditingController teacherSearchController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<TeacherModel> teachers = <TeacherModel>[].obs;
  final RxList<TeacherModel> filteredTeachers = <TeacherModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    teacherSearchController.addListener(_onSearchChanged);
  }

  void fetchTeachers(BuildContext context) async {
    try {
      isLoading.value = true;
      showLoadingDialog(context);
      final snapshot = await firestore.collection('Teachers').get();

      if (snapshot.docs.isEmpty) {
        showSnackBar('No Data', 'No teachers found in the database.');
        teachers.clear();
        filteredTeachers.clear();
      } else {
        final loadedTeachers = snapshot.docs
            .map((doc) => TeacherModel.fromMap(doc.id, doc.data()))
            .toList();
        teachers.value = loadedTeachers;
        filteredTeachers.value = loadedTeachers;
      }
    } catch (ex) {
      showSnackBar('Error', 'Failed to fetch teachers.\n${ex.toString()}');
    } finally {
      isLoading.value = false;
      Navigator.pop(context);
    }
  }

  void _onSearchChanged() {
    final query = teacherSearchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredTeachers.value = teachers;
    } else {
      filteredTeachers.value = teachers
          .where((teacher) =>
          teacher.name.toLowerCase().contains(query))
          .toList();
    }
  }

  @override
  void onClose() {
    teacherSearchController.dispose();
    super.onClose();
  }
}

