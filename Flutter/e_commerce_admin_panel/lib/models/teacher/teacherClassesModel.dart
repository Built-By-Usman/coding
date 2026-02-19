class TeacherClassesModel {
  final String id;
  final String name;

  TeacherClassesModel({required this.id, required this.name});

  factory TeacherClassesModel.fromMap(String id, Map<String, dynamic> data) {
    return TeacherClassesModel(
      id: id,
      name: data['Class Name'] ?? '',
    );
  }
}