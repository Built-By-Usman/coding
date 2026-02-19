enum MessageType { sender, receiver }

class MessageModel {
  final String message;
  final MessageType type;
  final DateTime date;

  MessageModel({
    required this.message,
    required this.type,
    required this.date,
  });
}