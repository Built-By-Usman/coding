class TeacherSubjectsModel {
  final String id;
  final String name;

  TeacherSubjectsModel({required this.id, required this.name});

  factory TeacherSubjectsModel.fromMap(String id, Map<String, dynamic> data) {
    return TeacherSubjectsModel(
      id: id,
      name: data['Subject Name'] ?? '',
    );
  }
}