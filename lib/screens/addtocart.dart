import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:myshop/product/model/prodect_model.dart';
import 'package:myshop/screens/address_screen.dart';
import 'package:myshop/screens/order_screen.dart';

import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/controller/address_controller.dart';
import 'package:myshop/product/controller/order_controller.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final cartController = Get.find<CartController>();
  final addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppNavigator.pushReplacementWithoutAnimation(
                  context, const RootScreen());
            }),
        title: const Text('Cart'),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.products.length,
                  itemBuilder: (context, index) {
                    final item = cartController.products[index];
                    return Slidable(
                      key: ValueKey(item.id), // Unique key for each item
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _showEditDialog(context, cartController, item);
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              // Add your delete functionality here
                              cartController.deleteProduct(item);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    const Icon(Icons.image, color: Colors.grey),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Qty: ${item.quantity}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'RM ${item.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, -4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => Text(
                                addressController
                                        .selectedAddress.value?.fullAddress ??
                                    'Please Choose Address',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            AppNavigator.pushReplacementWithoutAnimation(
                              context,
                              const AddressListScreen(),
                              arguments: {'fromCart': true},
                            );
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'RM ${cartController.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cartController.products.isNotEmpty &&
                                addressController.selectedAddress.value != null
                            ? () {
                                final orderController =
                                    Get.find<OrderController>();
                                orderController.createOrder(
                                    cartController.products,
                                    addressController.selectedAddress.value!,
                                    cartController.total);
                                cartController.clearCart();
                                Get.off(() => const OrderScreen());
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 19, 80, 23),
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _showEditDialog(
      BuildContext context, CartController cartController, Product item) {
    final titleController = TextEditingController(text: item.title);
    final quantityController =
        TextEditingController(text: item.quantity.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                final newTitle = titleController.text;
                final newQuantity =
                    int.tryParse(quantityController.text) ?? item.quantity;
                cartController.editProduct(item, newTitle, newQuantity);
                cartController
                    .calculateItemCount(); // Hitung ulang itemCount setelah edit
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
