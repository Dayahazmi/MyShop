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
    );
  }
}
