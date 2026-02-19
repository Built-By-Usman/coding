import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_setup_controller.dart';
import '../core/constant/app_color.dart';

class ProfileSetup extends StatelessWidget {
  ProfileSetup({super.key});

  final controller = Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('Setup Profile', style: TextStyle(color: AppColor.white)),
      ),
      body: SafeArea(
        child: Obx(
              () =>
          controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: AppColor.primary))
              : SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Stack(
                alignment: Alignment.bottomRight,
        
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColor.blueGrey,
                    backgroundImage: controller.imageFile.value != null
                        ? FileImage(controller.imageFile.value!)
                        : null,
                    child: controller.imageFile.value == null
                        ? Icon(
                      Icons.person,
                      size: 80,
                      color: AppColor.white,
                    )
                        : null,
                  ),
                  Positioned(
                    right: -3,
                    bottom: -7,
                    child: IconButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      icon: Icon(Icons.camera_alt,color: AppColor.grey1,size: 27,),
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 40),
        
              TextField(
                cursorColor: AppColor.primary,
                decoration: InputDecoration(
                  label: Text(
                    'Your Name',
                    style: TextStyle(color: AppColor.primary),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColor.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.primary,
                    ),
                  ),
                ),
                onChanged: (val) => controller.name.value = val,
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: controller.name.value != ''
                          ? AppColor.primary
                          : AppColor.grey,
        
                      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                          ),
                          onPressed: controller.name.value != ''
                  ? () => controller.saveProfile()
                  : null,
                          child: const Text(
                "Save Profile",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
                          ),
                        ),
              ),
          ],
        ),
            ),)
            ,
            ),
      )
    ,
    );
  }
}
