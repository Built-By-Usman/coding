class UserModel {
  final String? userId;
  final String userName;
  final String userEmail;
  final DateTime? createdAt;
  final String? userPhone;
  final String? address;

  UserModel({
    this.userId,
    required this.userName,
    required this.userEmail,
    this.createdAt,
    this.userPhone,
    this.address,
  });

  /// Convert Supabase row (Map) → UserModel
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['id']?.toString(),
      userName: data['name'] ?? '',
      userEmail: data['email'] ?? '',
      userPhone: data['phone'] ?? '',
      address: data['address'] ?? '',
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'name': userName,
      'email': userEmail,
      'phone': userPhone,
      'address': address,
    };
  }
}
