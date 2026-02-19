class TeacherStudentsModel {
  final String id;
  final String name;
  final String rollNo;

  TeacherStudentsModel({required this.id, required this.name,required this.rollNo});

  factory TeacherStudentsModel.fromMap(String id, Map<String, dynamic> data) {
    return TeacherStudentsModel(
      id: id,
      name: data['Name'] ?? '',
      rollNo: data['Roll No'] ?? '',
    );
  }
}