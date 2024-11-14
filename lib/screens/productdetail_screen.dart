import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/model/prodect_model.dart';
import 'package:myshop/screens/addtocart.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:myshop/widget/bottomsheet.dart';
import 'package:myshop/widget/button.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppNavigator.pushReplacementWithoutAnimation(
                  context, const RootScreen());
            }),
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: Colors.grey[200],
                      height: 200,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'RM ${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.product.description,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      widget.product.description,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      widget.product.category,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      widget.product.brand,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                text: "Add To Cart",
                color: const Color.fromARGB(255, 19, 80, 23),
                onPress: () {
                  showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BottomSheetModal(product: widget.product)
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
