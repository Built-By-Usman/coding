import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/chat/chat_controller.dart';
import '../../widgets/chats/custom_chat_card.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instead of abstract class, just create the controller directly
    final controller = Get.put(ChatScreenController());

    // Put controller in GetX for state management
    Get.put(controller);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.goToContactScreen(),
        child: const Icon(Icons.chat),
      ),
      body: Obx(() {
        // Show loading indicator while fetching
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.chats.length,
          itemBuilder: (context, index) {
            final chat = controller.chats[index];

            return CustomChatCard(
              chatModel: chat,
              onTap: () => controller.goToDetailScreen(chat),

              // Inject profile widget if available
              profileWidget: chat.profilePicture != null &&
                  chat.profilePicture!.isNotEmpty
                  ? CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(chat.profilePicture!),
              )
                  : null,
            );
          },
        );
      }),
    );
  }
}