import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/controller/order_controller.dart';
import 'package:myshop/screens/addtocart.dart';
import 'package:myshop/screens/orderdetail_screen.dart';
import 'package:myshop/screens/profile_screen.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:myshop/widget/color_palette.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderController = Get.find<OrderController>();
  final CartController cartController = Get.put(CartController());

  void _onItemTapped(int index) {
    setState(() {});
    switch (index) {
      case 0:
        AppNavigator.pushReplacementWithoutAnimation(
            context, const RootScreen());
        break;
      case 1:
        AppNavigator.pushReplacementWithoutAnimation(
            context, const OrderScreen());
        break;
      case 2:
        AppNavigator.pushReplacementWithoutAnimation(
            context, const ProfileScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        actions: [
          Obx(() {
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {
                    AppNavigator.pushReplacementWithoutAnimation(
                        context, const AddToCartScreen());
                  },
                ),
                if (cartController.itemCount.value > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cartController.itemCount.value}',
                        style: GoogleFonts.roboto(
                            fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[800],
            height: 2.0,
          ),
        ),
      ),
      body: Obx(() => orderController.orders.isEmpty
          ? Center(
              child: Text(
                'No orders found!',
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: orderController.orders.length,
              itemBuilder: (context, index) {
                final order = orderController.orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () => AppNavigator.pushReplacementWithoutAnimation(
                          context, OrderDetailsScreen(orderId: order.id)),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        child: order.items.isEmpty
                            ? const Icon(
                                Icons.image,
                                size: 20,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      title: Text(
                        order.items.map((item) => item.title).join(', '),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'RM ${order.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(order.orderDate),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        unselectedItemColor: ColorPalette.accent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: 'Order History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      backgroundColor: ColorPalette.background,
    );
  }
}
