import 'package:get/get.dart';

class CartModel {
  final String? cartId;
  final String itemId;
  final String userId;
  final String itemName;
  final RxInt quantity;
  final String size;
  final double price;
  final RxDouble totalPrice;
  final String itemImage;

  CartModel({
    this.cartId,
    required this.itemId,
    required this.userId,
    required this.itemName,
    required int quantity,
    required this.size,
    required this.price,
    required double totalPrice,
    required this.itemImage,
  })  : quantity = quantity.obs,
        totalPrice = totalPrice.obs;

  factory CartModel.fromMap(Map<String, dynamic> data) {
    final quantity = data['quantity'] ?? 0;
    final price = (data['price'] as num?)?.toDouble() ?? 0.0;

    return CartModel(
      cartId: data['id']?.toString(),
      itemId: data['item_id'] ?? '',
      userId: data['user_id'] ?? '',
      itemName: data['item_name'] ?? '',
      quantity: quantity,
      size: data['size'] ?? '',
      price: price,
      totalPrice: price * quantity, // ✅ always calculated locally
      itemImage: data['item_image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'user_id': userId,
      'item_name': itemName,
      'quantity': quantity.value,
      'size': size,
      'price': price,
      'item_image': itemImage,
    };
  }
}