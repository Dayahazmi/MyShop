import 'package:myshop/product/model/address_model.dart';
import 'package:myshop/product/model/prodect_model.dart';

class Order {
  final String id;
  final List<Product> items;
  final Address deliveryAddress;
  final double total;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.items,
    required this.deliveryAddress,
    required this.total,
    required this.orderDate,
  });

  // Convert Order to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((item) => item.toJson()).toList(),
        'deliveryAddress': deliveryAddress.toJson(),
        'total': total,
        'orderDate': orderDate.toIso8601String(),
      };

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 'No ID',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => Product.fromJson(item))
              .toList() ??
          [],
      deliveryAddress: json['deliveryAddress'] != null
          ? Address.fromJson(json['deliveryAddress'])
          : Address.empty(), // Define an empty Address factory for fallback
      total: (json['total'] ?? 0).toDouble(),
      orderDate: json['orderDate'] != null
          ? DateTime.parse(json['orderDate'])
          : DateTime.now(),
    );
  }
}
