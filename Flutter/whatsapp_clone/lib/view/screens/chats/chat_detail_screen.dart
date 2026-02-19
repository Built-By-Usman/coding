import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/core/constant/app_color.dart';
import 'package:whatsapp_clone/core/constant/app_image.dart';
import 'package:whatsapp_clone/core/constant/app_size.dart';

import '../../../controllers/chat/chat_detail_controller.dart';
import '../../../model/message_model.dart';
import '../../widgets/chats/chat detail/components/custom_appbar.dart';
import '../../widgets/chats/chat detail/components/message_chat.dart';
import '../../../widgets/emoji/custom_emoji.dart';
import '../../widgets/chats/message_input.dart';
import '../../../widgets/spacer/spacer.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(ChatDetailScreenController());

    return Scaffold(
      backgroundColor: AppColor.blueGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppSize.screenHeight! * 0.07),
        child: CustomAppBar(controller: controller), // pass controller
      ),
      body: Container(
        width: AppSize.screenWidth,
        height: AppSize.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: WillPopScope(
          onWillPop: controller.onWillPop,
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<ChatDetailScreenController>(
                  builder: (c) => ListView.builder(
                    controller: c.scrollController,
                    itemCount: c.messages.length + 1,
                    itemBuilder: (_, index) {
                      if (index == c.messages.length) return const VerticalSpacer(7);

                      final msg = c.messages[index];
                      return MessageChat(
                        isSender: msg.type == MessageType.sender,
                        message: msg.message,
                        date: msg.date,
                      );
                    },
                  ),
                ),
              ),

              // Input and Emoji section
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 10),
                            child: const MessageInput(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 3, right: 3, bottom: 10),
                          child: GetBuilder<ChatDetailScreenController>(
                            builder: (c) => CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColor.second,
                              child: IconButton(
                                icon: Icon(c.isSend ? Icons.send : Icons.mic, color: AppColor.white),
                                onPressed: c.sendMessage,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    GetBuilder<ChatDetailScreenController>(
                      builder: (c) => c.isEmojiShow
                          ? CustomEmoji(onEmojiSelected: c.onEmojiSelected)
                          : const SizedBox(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}