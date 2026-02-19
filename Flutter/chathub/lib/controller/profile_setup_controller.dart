import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:ChatHub/components/my_snackbar.dart';
import 'package:ChatHub/core/constant/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupController extends GetxController{
  final nameController = TextEditingController();
  var name=''.obs;
  var isLoading= false.obs;
  var imageFile = Rx<File?>(null);

  final picker = ImagePicker();
  final FirebaseFirestore db = FirebaseFirestore.instance;



  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);

      // Check if file is larger than 5 MB
      if (file.lengthSync() > 5 * 1024 * 1024) {
        MySnackBar.showSnackBar('Error', 'File size cannot exceed 5 MB');
        return; // Do not pick the file
      }

      // Decode image
      img.Image? image = img.decodeImage(file.readAsBytesSync());
      if (image == null) return;

      // Resize if file is larger than 3 MB
      if (file.lengthSync() > 3 * 1024 * 1024) {
        image = img.copyResize(image, width: 800); // reduce width, height scales automatically
      }

      // Compress image
      final compressedBytes = img.encodeJpg(image, quality: 85); // 85% quality

      // Overwrite original file with compressed version
      final compressedFile = File(file.path)..writeAsBytesSync(compressedBytes);

      imageFile.value = compressedFile;
    }
  }



  Future<void> saveProfile()async{
    if(name.value.isEmpty){
      MySnackBar.showSnackBar('Error', 'Please Enter a Name');
      return;
    }
    isLoading.value=true;

    String? photoUrl;

    if(imageFile.value!=null){

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg');
      await storageRef.putFile(imageFile.value!);

      photoUrl = await storageRef.getDownloadURL();

    }

    await db.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'name':name.value,
      'photo_url':photoUrl,
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name.value);
    preferences.setString('photo_url', photoUrl!);
    preferences.setBool('is_logged_in', true);
    isLoading.value=false;
    Get.offAllNamed(AppRoute.home);

  }

}