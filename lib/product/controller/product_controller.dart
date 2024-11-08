import 'package:get/get.dart';
import 'package:myshop/product/model/prodect_model.dart';
import 'package:myshop/product/product_services/product_services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var categories = <String>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;
  var selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Panggil untuk mendapatkan kategori unik
    fetchProducts();
  }

  // Fungsi untuk mendapatkan kategori
  void fetchCategories() async {
    try {
      isLoading(true);
      final categoryList = await ProductService().fetchCategories();
      categories.assignAll(
          ['All', ...categoryList]); // Masukkan 'All' sebagai pilihan pertama
    } catch (e) {
      error('Failed to load categories');
    } finally {
      isLoading(false);
    }
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      error('');

      final productList =
          await ProductService().fetchProducts(selectedCategory.value);
      products.assignAll(productList);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lastSelectedCategory', selectedCategory.value);
    } catch (e) {
      error('Failed to fetch products');
    } finally {
      isLoading(false);
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    fetchProducts(); // Re-fetch products based on the selected category
  }
}
