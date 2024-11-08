import 'package:get/get.dart';
import 'package:myshop/product/model/prodect_model.dart';

class CartController extends GetxController {
  var products = <Product>[].obs; // List of products in the cart
  var itemCount = 0.obs; // Reactive variable for total items in cart

  double get total => products.fold(0, (sum, item) => sum + item.total);

  void addToCart(Product item, int quantity) {
    final existingItem = products.firstWhere(
      (element) => element.id == item.id,
      orElse: () => Product(id: '', title: '', price: 0, description: ''),
    );

    if (existingItem.id.isEmpty) {
      // If the product does not exist, add it to the cart
      item.quantity = quantity; // Set the quantity for the new item
      products.add(item);
      itemCount.value += quantity; // Update total item count
    } else {
      // If the product exists, update its quantity
      existingItem.quantity += quantity;
      itemCount.value += quantity; // Update total item count
      products.refresh(); // Refresh the observable list
    }
  }

  void updateQuantity(String id, int quantity) {
    final item = products.firstWhere((element) => element.id == id);
    item.quantity = quantity;
    itemCount.value = products.fold(
        0, (sum, item) => sum + item.quantity); // Update item count
    products.refresh();
  }

  void removeFromCart(String id) {
    final item = products.firstWhere((element) => element.id == id);
    itemCount.value -=
        item.quantity; // Subtract the quantity of the removed item
    products.removeWhere((element) => element.id == id);
  }

  void clearCart() {
    products.clear();
    itemCount.value = 0; // Reset item count
  }
}
