import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

class GeminiController extends GetxController {
  final TextEditingController controller = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxList<Message> messages = <Message>[].obs;

  bool get isLoading => _isLoading.value;

  Future<void> getGeminiResponse() async {
    final apiKey = '';
    final prompt = controller.text.trim();

    if (prompt.isEmpty) return;

    // Add user's message
    messages.add(Message(text: prompt, isUser: true));
    controller.clear();

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey',
    );
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {
              "text": "Act like a parenting expert. Respond briefly (1-6 sentences max)."
                  "\n\nUser: ${prompt}"
            }
          ]
        }
      ]
    });


    try {
      _isLoading.value = true;

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        messages.add(Message(text: text, isUser: false));
      } else {
        messages.add(Message(text: '❌ Error: ${response.body}', isUser: false));
      }
    } catch (e) {
      messages.add(Message(text: '❌ Exception: $e', isUser: false));
    } finally {
      _isLoading.value = false;
    }
  }
}
