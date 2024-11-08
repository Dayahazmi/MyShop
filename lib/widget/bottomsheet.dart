import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/model/prodect_model.dart';

import 'package:myshop/widget/button.dart';

class BottomSheetModal extends StatelessWidget {
  final Product product;
  final cartController = Get.find<CartController>();

  BottomSheetModal({super.key, required this.product});

  final RxInt quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Quantity'),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantity.value > 1) {
                              quantity.value--;
                            }
                          },
                        ),
                        Obx(() => Text(quantity.value.toString())),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            quantity.value++;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ButtonWidget(
            text: "Add",
            color: const Color.fromARGB(255, 19, 80, 23),
            onPress: () {
              cartController.addToCart(product, quantity.value);
              Get.snackbar(
                "Added to Cart",
                "${product.title} has been added to your cart.",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
          )
        ],
      ),
    );
  }
}
