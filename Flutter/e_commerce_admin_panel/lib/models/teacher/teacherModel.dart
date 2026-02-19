class TeacherModel {
  final String id;
  final String name;

  TeacherModel({required this.id, required this.name});

  factory TeacherModel.fromMap(String id, Map<String, dynamic> data) {
    return TeacherModel(
      id: id,
      name: data['Teacher Name'] ?? '',
    );
  }
}
