import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/model/prodect_model.dart';

void showEditDialog(
    BuildContext context, CartController cartController, Product item) {
  final titleController = TextEditingController(text: item.title);
  final RxInt quantity = item.quantity.obs;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              cartController.editProduct(item, newTitle, quantity.value);
              cartController.calculateItemCount();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
