class CategoryModel {
  final String? categoryId;
  String categoryName;
  final String? categoryIcon;
  final int? categoryOrders;
  final DateTime? categoryCreatedAt;

  CategoryModel({
    this.categoryId,
    required this.categoryName,
    this.categoryIcon,
    this.categoryOrders,
    this.categoryCreatedAt,
  });

  // Convert from Sup abase row
  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
      categoryId: data['id']?.toString(),
      categoryName: data['category_name'] ?? '',
      categoryIcon: data['category_icon'],
      categoryOrders: data['category_orders'],
      categoryCreatedAt: data['category_created_at'] != null
          ? DateTime.tryParse(data['category_created_at'])
          : null,
    );
  }

  // Convert to Sup abase row
  Map<String, dynamic> toMap() {
    return {
      'category_name': categoryName,
      'category_icon': categoryIcon,
      'category_orders': categoryOrders,
      'category_created_at': categoryCreatedAt?.toIso8601String(),
    };
  }
}
