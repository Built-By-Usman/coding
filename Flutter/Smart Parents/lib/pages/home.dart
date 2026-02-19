import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/geminiController.dart';
import '../widgets/introCardWidget.dart';

class GeminiScreen extends StatelessWidget {
  final controller = Get.put(GeminiController());

  void _launchURL() async {
    final url = Uri.parse('https://www.devmuhammadosman.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Smart Parents',
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.messages.isEmpty) {
                  return IntroCardWidget(onLinkTap: _launchURL);
                } else {
                  return const SizedBox.shrink();
                }
              }),
              Expanded(child: MessageListWidget(controller: controller)),
              MessageInputWidget(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
