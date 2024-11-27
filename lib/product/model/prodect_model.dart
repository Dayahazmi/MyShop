class Product {
  final String id;
  final String title;
  final String description;
  final String category;
  final String brand;
  final double price;
  int quantity;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
    required double total,
    required this.category,
    required this.brand,
    required this.images,
  });

  double get total => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'brand': brand,
      'price': price,
      'quantity': quantity,
      'total': total,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      category: json['category'] ?? 'No category',
      brand: json['brand'] ?? 'No brand',
      total: (json['total'] ?? 0).toDouble(),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
