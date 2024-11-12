class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
    required double total,
  });

  double get total => price * quantity;

  // Factory method to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(), // Convert to String here
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      total: json['total'] ?? 0,
    );
  }

  // Adding the copyWith method
  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total,
    );
  }
}
