import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/geminiController.dart';

class IntroCardWidget extends StatelessWidget {
  final VoidCallback onLinkTap;

  const IntroCardWidget({Key? key, required this.onLinkTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Parenting Advice Assistant',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'poppins',
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Get practical parenting tips and child development advice tailored to your journey as a parent.',
            style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onLinkTap,
            child: const Text(
              'By Muhammd Usman →',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'poppins',
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageListWidget extends StatelessWidget {
  final GeminiController controller;

  const MessageListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final msg = controller.messages[index];
          return Container(
            margin: const EdgeInsets.all(8),
            alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: msg.isUser ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(msg.text),
            ),
          );
        },
      );
    });
  }
}

class MessageInputWidget extends StatelessWidget {
  final GeminiController controller;

  const MessageInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.controller,
              decoration: InputDecoration(
                hintText: 'Ask anything about children',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Obx(
                () => controller.isLoading
                ? const CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 4.0,
            )
                : IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: controller.getGeminiResponse,
            ),
          ),
        ],
      ),
    );
  }
}
