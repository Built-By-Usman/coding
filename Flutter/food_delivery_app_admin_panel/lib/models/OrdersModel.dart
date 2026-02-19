import 'package:get/get.dart';

class OrderItemModel {
  final String itemId;
  final String itemName;
  final int quantity;
  final double price;
  final double totalPrice;
  final String size;
  String itemImage;

  OrderItemModel({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.size,
    required this.itemImage,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> data) {
    return OrderItemModel(
      itemId: data['item_id'] ?? '',
      itemName: data['item_name'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (data['total_price'] as num?)?.toDouble() ?? 0.0,
      size: data['size'] ?? '',
      itemImage: data['item_image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      'quantity': quantity,
      'price': price,
      'total_price': totalPrice,
      'size': size,
      'item_image': itemImage,
    };
  }
}

class OrderModel {
  final String? orderId;
  final String userId;
  final double totalPrice;
  final List<OrderItemModel> items;
  final String status;
  final DateTime createdAt;

  OrderModel({
    this.orderId,
    required this.userId,
    required this.totalPrice,
    required this.items,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['id']?.toString(),
      userId: data['user_id'] ?? '',
      totalPrice: (data['total_price'] as num?)?.toDouble() ?? 0.0,
      status: data['status'] ?? 'pending',
      createdAt: DateTime.tryParse(data['created_at'] ?? '') ?? DateTime.now(),
      items: (data['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'total_price': totalPrice,
      'items': items.map((e) => e.toMap()).toList(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}