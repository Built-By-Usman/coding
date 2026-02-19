class ChatModel {
  final int id;

  // Backend IDs needed for logic
  final int user1Id;
  final int user2Id;

  // UI fields
  final String name;
  final String time;
  final String message;
  final String? profilePicture;

  ChatModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.name,
    required this.time,
    required this.message,
    required this.profilePicture,
  });

  factory ChatModel.fromApi(Map<String, dynamic> json, int myId) {
    final u1 = json['user1_id'];
    final u2 = json['user2_id'];
    final otherUserId = u1 == myId ? u2 : u1;

    return ChatModel(
      id: json['id'],
      user1Id: u1,
      user2Id: u2,
      name: "User $otherUserId",
      time: _formatTime(json['last_message_time']),
      message: json['last_message'] ?? '',
      profilePicture: json['profile_picture'],
    );
  }

  static String _formatTime(String iso) {
    final dt = DateTime.parse(iso).toLocal();
    return "${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
  }
}