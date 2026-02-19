class ItemSize {
  final String size;
  final double price;

  ItemSize({required this.size, required this.price});

  factory ItemSize.fromMap(Map<String, dynamic> data) {
    return ItemSize(
      size: data['size'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'price': price,
    };
  }
}