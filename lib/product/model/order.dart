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
}
