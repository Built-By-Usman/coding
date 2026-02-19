import 'package:flutter/material.dart';
import '../../../../../controllers/chat/chat_detail_controller.dart';
import '../../../../../core/constant/app_color.dart';
import '../../../../../core/constant/app_size.dart';

class CustomAppBar extends StatelessWidget {
  final ChatDetailScreenController controller;
  const CustomAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        PopupMenuButton<String>(
          onSelected: controller.selectPopMenu,
          itemBuilder: (context) => [
            ...List.generate(
              controller.popMenuItems.length,
                  (index) => PopupMenuItem<String>(
                value: controller.popMenuItems[index],
                child: Text(controller.popMenuItems[index]),
              ),
            )
          ],
        )
      ],
      leadingWidth: AppSize.screenWidth! / 6,
      leading: InkWell(
        onTap: controller.back,
        child: const Row(children: [
          Icon(Icons.arrow_back, size: 24),
          CircleAvatar(
            backgroundColor: AppColor.blueGrey,
            child: Icon(Icons.person, size: 30, color: AppColor.white),
          )
        ]),
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.chat.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("Last seen today at 14:28",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}