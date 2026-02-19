import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/chat_model.dart';
import '../../model/message_api_model.dart';
import '../../model/message_model.dart';
import '../../services/ApiClient.dart';


class ChatDetailScreenController extends GetxController {
  final ApiClient api = ApiClient();

  late ChatModel chat;
  late int myId;
  String selectedPopMenu = "Gallery"; // default selection
  final bottomSheetItems = [
    {"text": "Gallery", "icon": Icons.image, "color": Colors.purple, "function": () {}},
    {"text": "File", "icon": Icons.insert_drive_file, "color": Colors.blue, "function": () {}},
    {"text": "Location", "icon": Icons.location_on, "color": Colors.green, "function": () {}},
    {"text": "Contact", "icon": Icons.person, "color": Colors.orange, "function": () {}},
  ];
  List<String> get popMenuItems =>
      bottomSheetItems.map((item) => item["text"] as String).toList();

  final focusNode = FocusNode();
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  final List<MessageModel> messages = [];

  bool isEmojiShow = false;
  bool isSend = false;

  late io.Socket socket;
  void back() {
    Get.back();
  }



  @override
  void onInit() {
    chat = Get.arguments["chat"];

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isEmojiShow = false;
        update();
      }
    });

    _initialize();
    super.onInit();
  }
  void selectPopMenu(String value) {
    selectedPopMenu = value;
    update();
  }
  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    myId = prefs.getInt('id') ?? 0;

    await fetchMessages();
    _connectSocket();
  }

  Future<void> fetchMessages() async {
    try {
      final receiver =
      chat.user1Id == myId ? chat.user2Id : chat.user1Id;

      final res = await api.dio.get('/chat/$myId/$receiver');

      messages.clear();

      for (final json in res.data) {
        final apiMsg = MessageApiModel.fromJson(json);

        messages.add(MessageModel(
          message: apiMsg.content,
          date: apiMsg.timestamp,
          type: apiMsg.senderId == myId
              ? MessageType.sender
              : MessageType.receiver,
        ));
      }

      update();
      _scrollBottom();
    } on DioException catch (e) {
      Get.snackbar("Error", e.message ?? "Fetch failed");
    }
  }

  void _connectSocket() {
    socket = io.io(
      "https://chat-hub-backend-a7y4.onrender.com",
      {
        "transports": ['websocket'],
        "autoConnect": true,
      },
    );

    socket.onConnect((_) {
      socket.emit("login", myId);
    });

    socket.on("msg", (data) {
      _addMessage(data["message"], MessageType.receiver);
    });
  }

  void sendMessage() async {
    if (!isSend) return;

    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final receiverId = chat.user1Id == myId ? chat.user2Id : chat.user1Id;

    // 1️⃣ Add locally for instant UI update
    _addMessage(text, MessageType.sender);

    // 2️⃣ Emit through socket (optional)
    socket.emit("msg", {
      "message": text,
      "sender": myId,
      "destination": chat.id,
    });

    // 3️⃣ Send via HTTP API
    try {
      final res = await api.dio.post('/chat/', data: {
        "sender_id": myId,
        "receiver_id": receiverId,
        "content": text,
        "media_url": ""
      });
      print("Message sent via HTTP API: ${res.data}");
    } on DioException catch (e) {
      Get.snackbar("Error", e.message ?? "Failed to send message via HTTP");
    }

    messageController.clear();
    isSend = false;
    update();

    _scrollBottom();
  }
  void _addMessage(String msg, MessageType type) {
    messages.add(
      MessageModel(
        message: msg,
        type: type,
        date: DateTime.now(),
      ),
    );
    update();
  }

  void changeInput(String v) {
    isSend = v.trim().isNotEmpty;
    update();
  }

  void toggleEmoji() {
    focusNode.unfocus();
    isEmojiShow = !isEmojiShow;
    update();
  }

  void onEmojiSelected(Category? _, Emoji? emoji) {
    if (emoji == null) return;
    messageController.text += emoji.emoji;
    changeInput(messageController.text);
  }

  Future<bool> onWillPop() async {
    if (isEmojiShow) {
      isEmojiShow = false;
      update();
      return false;
    }
    return true;
  }

  void _scrollBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    socket.dispose();
    focusNode.dispose();
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}