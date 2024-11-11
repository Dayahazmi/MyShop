import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/controller/product_controller.dart';
import 'package:myshop/screens/addtocart.dart';
import 'package:myshop/screens/productdetail_screen.dart';
import 'package:myshop/screens/profile_screen.dart';
import 'package:myshop/screens/order_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:myshop/widget/color_palette.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List<String> categories = ["All", "Smartphones", "Fragrances"];
  String selectedCategory = "All";
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final ProductController controller = Get.find();

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
        title: const Text('eShop'),
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
          preferredSize: const Size.fromHeight(1.0), // Set height for the line
          child: Container(
            color: Colors.grey[800], // Set line color
            height: 2.0, // Thickness of the line
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Obx(() {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => controller.changeCategory(category),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: controller.selectedCategory.value ==
                                          category
                                      ? Colors.grey
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(category),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  Expanded(
                    child: Obx(() {
                      if (productController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (productController.error.isNotEmpty) {
                        return Center(
                            child: Text(productController.error.value));
                      } else if (productController.products.isEmpty) {
                        return const Center(child: Text('No products found.'));
                      } else {
                        return GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: productController.products.length,
                          itemBuilder: (context, index) {
                            final product = productController.products[index];
                            return GestureDetector(
                              onTap: () {
                                AppNavigator.pushReplacementWithoutAnimation(
                                    context,
                                    ProductDetailScreen(
                                      product: product,
                                    ));
                              },
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: Colors.grey[200],
                                          child: const Icon(
                                            Icons.image,
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        product.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'RM ${product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
