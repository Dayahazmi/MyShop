import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myshop/product/model/address_model.dart';
import 'package:myshop/product/model/order.dart';
import 'package:myshop/product/model/prodect_model.dart';

class OrderController extends GetxController {
  final orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders(); // Load orders from SharedPreferences when the controller initializes
  }

  Future<void> createOrder(
      List<Product> items, Address address, double total) async {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      deliveryAddress: address,
      total: total,
      orderDate: DateTime.now(),
    );
    orders.insert(0, order);
    await saveOrders(); // Save orders to SharedPreferences after adding a new order
  }

  Order? getOrderById(String id) {
    return orders.firstWhereOrNull((order) => order.id == id);
  }

  Future<void> saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson =
        orders.map((order) => jsonEncode(order.toJson())).toList();
    await prefs.setStringList('orders', ordersJson);
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList('orders') ?? [];
    orders.assignAll(
        ordersJson.map((order) => Order.fromJson(jsonDecode(order))).toList());
  }
}
