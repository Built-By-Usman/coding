import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String phoneNumber;
  final String? name;
  final String? photoUrl;
  final bool? isActive;

  final Timestamp? createdAt;

  UserModel({
    required this.userId,
    required this.phoneNumber,
    this.name,
    this.photoUrl,
    this.createdAt,
    this.isActive
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'phone_number': phoneNumber,
      'name': name,
      'photo_url': photoUrl,
      'is_active':true,
      'created_at': FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      photoUrl: map['photo_url'],
      name: map['name'],
      phoneNumber: map['phone_number'],
      isActive: map['is_active'],
      createdAt: map['created_at'],
    );
  }
}
