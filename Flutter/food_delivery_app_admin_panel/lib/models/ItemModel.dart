import 'ItemSize.dart';

class ItemModel {
  final String? itemId;
  final String itemName;
  final String itemImage;
  final String itemDescription;
  final String itemCategory;
  final bool itemIsAvailable;
  final DateTime? itemCreatedAt;
  final List<ItemSize> itemSizes;

  ItemModel({
    this.itemId,
    required this.itemName,
    required this.itemImage,
    required this.itemDescription,
    required this.itemCategory,
    required this.itemIsAvailable,
    this.itemCreatedAt,
    this.itemSizes = const [],
  });

  factory ItemModel.fromMap(Map<String, dynamic> data) {
    return ItemModel(
      itemId: data['id']?.toString(),
      itemName: data['item_name'] ?? '',
      itemImage: data['item_image'] ?? '',
      itemDescription: data['item_description'] ?? '',
      itemCategory: data['item_category'] ?? '',
      itemIsAvailable: data['item_is_available'] ?? false,
      itemCreatedAt: data['item_created_at'] != null
          ? DateTime.tryParse(data['item_created_at'])
          : null,
      itemSizes:
          (data['item_sizes'] as List<dynamic>?)
              ?.map((e) => ItemSize.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_name': itemName,
      'item_image': itemImage,
      'item_description': itemDescription,
      'item_category': itemCategory,
      'item_is_available': itemIsAvailable,
      'item_sizes': itemSizes.map((e) => e.toMap()).toList(),
    };
  }
}
