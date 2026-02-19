import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin_panel/components/AppColors.dart';
import 'package:food_delivery_app_admin_panel/components/Utils.dart';
import 'package:food_delivery_app_admin_panel/models/CategoryModel.dart';
import 'package:food_delivery_app_admin_panel/models/ItemModel.dart';
import 'package:food_delivery_app_admin_panel/widgets/MyText.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import '../models/ItemSize.dart';
import '../stub_image_picker.dart';

class HomeScreenController extends GetxController {
  var supabase = Supabase.instance.client;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxMap<String, String> signedUrls = <String, String>{}.obs;
  RxBool isLoading = false.obs;
  TextEditingController updateCategoryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchItems();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      var response = await supabase.from('categories').select();

      categoryList.value = (response as List<dynamic>)
          .map((item) => CategoryModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Utils().mySnackBar('Error', 'An unknown error occur');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchItems() async {
    isLoading.value = true;
    try {
      var response = await supabase.from('items').select();
      itemList.value = (response as List<dynamic>)
          .map((item) => ItemModel.fromMap(item as Map<String, dynamic>))
          .toList();

      for (var item in itemList) {
        if (item.itemImage.isNotEmpty) {
          final url = supabase.storage
              .from('pictures')
              .getPublicUrl('item/${item.itemImage}');

          signedUrls[item.itemImage] = url;
        }
      }
    } catch (e) {
      Utils().mySnackBar('Error', 'An unknown error occur');
    } finally {
      isLoading.value = false;
    }
  }

  String getSignedUrl(String fileName) {
    return signedUrls[fileName] ?? '';
  }

  Future<void> showUpdateCategoryDialog(int index) async {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors().white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: MyText(
          text: 'Update Category',
          size: 20,
          color: AppColors().black,
          weight: FontWeight.bold,
        ),
        content: TextField(
          controller: updateCategoryController
            ..text = categoryList[index].categoryName,
          cursorColor: AppColors().black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().black),
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: MyText(
              text: 'Cancel',
              size: 16,
              color: AppColors().black,
              weight: FontWeight.w400,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors().primary,
            ),
            onPressed: () async {
              String newName = updateCategoryController.text.trim();

              if (newName.isNotEmpty &&
                  newName != categoryList[index].categoryName) {
                Get.back();
                isLoading.value = true;

                try {
                  // ✅ Await the update query
                  await supabase
                      .from('categories')
                      .update({'category_name': newName})
                      .eq('id', categoryList[index].categoryId!);

                  // ✅ Update local list so UI refreshes
                  categoryList[index].categoryName = newName;
                  Utils().mySnackBar(
                    'Success',
                    'Category name updated successfully',
                  );
                } catch (e) {
                  Utils().mySnackBar('Error', 'Update failed: $e');
                } finally {
                  isLoading.value = false;
                }
              } else {
                Utils().mySnackBar('Error', 'Enter new or valid name');
              }
            },
            child: MyText(
              text: 'Update',
              size: 16,
              color: AppColors().white,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }


  Future<void> showUpdateItemDialog(int index) async {
    final item = itemList[index];

    final nameController = TextEditingController(text: item.itemName);
    final descriptionController = TextEditingController(text: item.itemDescription);

    // Sizes
    RxList<ItemSize> sizes = item.itemSizes.obs;

    // Categories
    RxList<String> categories = <String>[].obs;
    RxString selectedCategory = item.itemCategory.obs;

    // Existing image
    final String existingImageUrl =
    supabase.storage.from('pictures').getPublicUrl('item/${item.itemImage}');
    Rx<Uint8List?> webImage = Rx<Uint8List?>(null);
    RxString uploadedImageUrl = existingImageUrl.obs;

    // Load categories
    Future<void> loadCategories() async {
      try {
        final response = await supabase.from('categories').select('category_name');
        categories.value = List<String>.from(
          response.map((e) => e['category_name']),
        );
      } catch (e, st) {
        debugPrint("Load categories failed: $e\n$st");
        Get.snackbar("Error", "Failed to load categories");
      }
    }

    // Pick image
    Future<void> pickImage() async {
      try {
        if (kIsWeb) {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );
          if (result != null && result.files.single.bytes != null) {
            webImage.value = result.files.single.bytes;
          }
        }
      } catch (e, st) {
        debugPrint("Pick image failed: $e\n$st");
        Get.snackbar("Error", "Image pick failed");
      }
    }

    // Upload new image only if changed
    Future<String> uploadImageIfChanged() async {
      if (kIsWeb && webImage.value != null) {
        try {
          final String fileName = "item_${DateTime.now().millisecondsSinceEpoch}.png";
          await supabase.storage.from('pictures').uploadBinary(
            'item/$fileName',
            webImage.value!,
            fileOptions: const FileOptions(upsert: true),
          );
          return 'item/$fileName';
        } catch (e, st) {
          debugPrint("Image upload failed: $e\n$st");
          Get.snackbar("Error", "Image upload failed");
          return item.itemImage; // fallback to old image
        }
      }
      // No new image selected → keep old one
      return item.itemImage;
    }

    await loadCategories();

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors().white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: MyText(
          text: 'Update Item',
          size: 20,
          color: AppColors().black,
          weight: FontWeight.bold,
        ),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image
                Obx(
                      () => GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors().black.withOpacity(0.1),
                      backgroundImage: webImage.value != null
                          ? MemoryImage(webImage.value!)
                          : uploadedImageUrl.value.isNotEmpty
                          ? NetworkImage(uploadedImageUrl.value)
                          : null,
                      child: (webImage.value == null &&
                          uploadedImageUrl.value.isEmpty)
                          ? Icon(Icons.camera_alt, color: AppColors().black)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                TextField(
                  controller: nameController,
                  cursorColor: AppColors().black,
                  decoration: InputDecoration(
                    labelText: "Item Name",
                    labelStyle: TextStyle(color: AppColors().black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().black),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                TextField(
                  controller: descriptionController,
                  cursorColor: AppColors().black,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: AppColors().black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().black),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Sizes
                Obx(
                      () => Column(
                    children: [
                      ...sizes.asMap().entries.map((entry) {
                        int i = entry.key;
                        ItemSize size = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: TextEditingController(
                                    text: size.size,
                                  ),
                                  cursorColor: AppColors().black,
                                  onChanged: (val) => sizes[i] = ItemSize(
                                    size: val,
                                    price: sizes[i].price,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: "Size",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: TextEditingController(
                                    text: size.price.toString(),
                                  ),
                                  cursorColor: AppColors().black,
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) => sizes[i] = ItemSize(
                                    size: sizes[i].size,
                                    price: double.tryParse(val) ?? 0,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: "Price",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: AppColors().primary),
                                onPressed: () => sizes.removeAt(i),
                              ),
                            ],
                          ),
                        );
                      }),
                      TextButton.icon(
                        onPressed: () => sizes.add(ItemSize(size: "", price: 0)),
                        icon: Icon(Icons.add, color: AppColors().black),
                        label: Text("Add Size", style: TextStyle(color: AppColors().black)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Category
                Obx(
                      () => DropdownButtonFormField<String>(
                    value: selectedCategory.value,
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat, style: TextStyle(color: AppColors().black)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) selectedCategory.value = val;
                    },
                    decoration: const InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                    ),
                    dropdownColor: AppColors().white,
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors().black),
                      ),
                      child: Text("Cancel", style: TextStyle(color: AppColors().black)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().primary,
                      ),
                      onPressed: () async {
                        String newName = nameController.text.trim();
                        String newDesc = descriptionController.text.trim();

                        if (newName.isEmpty || newDesc.isEmpty) {
                          Get.snackbar("Error", "Name and description cannot be empty");
                          return;
                        }

                        try {
                          debugPrint("Starting update for itemId: ${item.itemId}");

                          // ✅ Only upload if new image picked
                          final String finalImagePath = await uploadImageIfChanged();
                          final String finalImageUrl =
                          supabase.storage.from('pictures').getPublicUrl(finalImagePath);

                          await supabase.from('items').update({
                            'item_name': newName,
                            'item_description': newDesc,
                            'item_category': selectedCategory.value,
                            'item_image': finalImagePath,
                            'item_sizes': sizes.map((e) => e.toMap()).toList(),
                          }).eq('id', item.itemId!);

                          // Update local list
                          itemList[index] = ItemModel(
                            itemId: item.itemId,
                            itemName: newName,
                            itemImage: finalImagePath,
                            itemDescription: newDesc,
                            itemCategory: selectedCategory.value,
                            itemIsAvailable: item.itemIsAvailable,
                            itemCreatedAt: item.itemCreatedAt,
                            itemSizes: sizes.toList(),
                          );

                          uploadedImageUrl.value = finalImageUrl;

                          Get.snackbar("Success", "Item updated successfully");
                          Get.back();
                        } catch (e, st) {
                          debugPrint("Update failed: $e\n$st");
                          Get.snackbar("Error", "Failed to update: $e");
                        }
                      },
                      child: Text("Update", style: TextStyle(color: AppColors().white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
