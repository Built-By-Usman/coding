import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin_panel/components/AppColors.dart';
import 'package:food_delivery_app_admin_panel/controllers/HomeScreenController.dart';
import 'package:food_delivery_app_admin_panel/widgets/MyText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../widgets/Loading.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: AppColors().primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 60,
                      left: MediaQuery.of(context).size.width * 0.1,
                      child: MyText(
                        align: TextAlign.center,
                        text: 'Order food you love with Food',
                        size: 30,
                        color: AppColors().white,
                        weight: FontWeight.bold,
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset('assets/images/admin_banner_top.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/images/admin_banner_bottom_left.png',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/admin_banner_bottom_right.png',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset(
                        'assets/images/admin_banner_female.png',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              MyText(
                text: 'Categories',
                size: 20,
                color: AppColors().black,
                weight: FontWeight.bold,
              ),

              SizedBox(height: 10),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // 👈 makes it horizontal
                    itemCount: controller.categoryList.length,
                    itemBuilder: (context, index) {
                      var item = controller.categoryList[index];
                      return GestureDetector(
                        onTap: (){
                          controller.showUpdateCategoryDialog(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors().lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              item.categoryName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors().black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Loading();
                  }

                  if (controller.itemList.isEmpty) {
                    return Center(
                      child: MyText(
                        text: "No items found",
                        size: 16,
                        color: Colors.grey,
                        weight: FontWeight.bold,
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: controller.itemList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600
                          ? 5
                          : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: MediaQuery.of(context).size.width > 600
                          ? 0.8
                          : 0.6,
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.itemList[index];
                      return GestureDetector(
                        onTap: () {
                          controller.showUpdateItemDialog(index);
                        },
                        child: Card(
                          color: AppColors().white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    // ✅ make image scale dynamically
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.width >
                                              600
                                          ? 160
                                          : 130,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: item.itemImage.isEmpty
                                          ? const Icon(
                                              Icons.broken_image,
                                              size: 50,
                                              color: Colors.grey,
                                            )
                                          : Image.network(
                                              controller.getSignedUrl(
                                                item.itemImage,
                                              ),
                                              fit: BoxFit.fill,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                    color: Colors.red,
                                                  ),
                                              loadingBuilder:
                                                  (
                                                    context,
                                                    child,
                                                    loadingProgress,
                                                  ) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child: Lottie.asset(
                                                        'assets/lottie/loading.json',
                                                        width: 100,
                                                        height: 80,
                                                      ),
                                                    );
                                                  },
                                            ),
                                    ),
                                    const SizedBox(height: 10),
                                    MyText(
                                      align: TextAlign.center,
                                      text: item.itemName,
                                      size: 15,
                                      color: AppColors().black,
                                      weight: FontWeight.w800,
                                    ),
                                    const SizedBox(height: 5),
                                    MyText(
                                      align: TextAlign.center,
                                      text: item.itemDescription,
                                      size: 12,
                                      color: AppColors().grey,
                                      weight: FontWeight.w500,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 3,
                                  child: MyText(
                                    text: '\$${item.itemSizes.first.price}',
                                    size: 18,
                                    color: AppColors().black,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
