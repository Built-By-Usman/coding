class MessageApiModel {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final String mediaUrl;
  final DateTime timestamp;

  MessageApiModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.mediaUrl,
    required this.timestamp,
  });

  factory MessageApiModel.fromJson(Map<String, dynamic> json) {
    return MessageApiModel(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      content: json['content'],
      mediaUrl: json['media_url'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}