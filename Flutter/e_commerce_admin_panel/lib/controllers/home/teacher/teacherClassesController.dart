import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/showDialog.dart';
import '../../../components/snackBar.dart';
import '../../../models/teacher/teacherClassesModel.dart';

class TeacherClassesController extends GetxController {
  final TextEditingController teacherClassSearchController =
      TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<TeacherClassesModel> teacherClasses =
      <TeacherClassesModel>[].obs;
  final RxList<TeacherClassesModel> filteredTeacherClasses =
      <TeacherClassesModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    teacherClassSearchController.addListener(_onSearchChanged);
  }

  void fetchTeacherClasses(BuildContext context, String id) async {
    try {
      isLoading.value = true;
      showLoadingDialog(context);

      final snapshot = await firestore
          .collection('Teachers')
          .doc(id)
          .collection('Classes')
          .orderBy('Time Stamp')
          .get();

      if (snapshot.docs.isEmpty) {
        showSnackBar('No Data', 'No Classes found in the database.');
        teacherClasses.clear();
        filteredTeacherClasses.clear();
      } else {
        final loadedClasses = snapshot.docs
            .map((doc) => TeacherClassesModel.fromMap(doc.id, doc.data()))
            .toList();

        teacherClasses.value = loadedClasses;
        filteredTeacherClasses.value = loadedClasses;
      }
    } catch (ex) {
      showSnackBar(
        'Error',
        'Failed to fetch teacher Classes.\n${ex.toString()}',
      );
    } finally {
      isLoading.value = false;
      Navigator.pop(context);
    }
  }

  void _onSearchChanged() {
    final query = teacherClassSearchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredTeacherClasses.value = teacherClasses;
    } else {
      filteredTeacherClasses.value = teacherClasses
          .where((cls) => cls.name.toLowerCase().contains(query))
          .toList();
    }
  }

  @override
  void onClose() {
    teacherClassSearchController.dispose();
    super.onClose();
  }
}
