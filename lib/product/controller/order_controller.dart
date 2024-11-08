import 'package:get/get.dart';
import 'package:myshop/product/model/address_model.dart';
import 'package:myshop/product/model/order.dart';
import 'package:myshop/product/model/prodect_model.dart';

class OrderController extends GetxController {
  final orders = <Order>[].obs;

  void createOrder(List<Product> items, Address address, double total) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      deliveryAddress: address,
      total: total,
      orderDate: DateTime.now(),
    );
    orders.insert(0, order);
  }

  Order? getOrderById(String id) {
    return orders.firstWhere((order) => order.id == id);
  }
}
