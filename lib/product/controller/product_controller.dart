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
    fetchCategories(); // Fetch categories on initialization
    fetchProducts();
  }

  // Fetch unique categories
  void fetchCategories() async {
    try {
      isLoading(true);
      final categoryList = await ProductService().fetchCategories();
      categories.assignAll(['All', ...categoryList]);
    } catch (e) {
      error('Failed to load categories');
    } finally {
      isLoading(false);
    }
  }

  // Fetch products
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

  // Change category and fetch products accordingly
  void changeCategory(String category) {
    selectedCategory.value = category;
    fetchProducts();
  }

  // Get image by title
  String getImageByTitle(String title) {
    // Search for the product with the given title
    final product = products.firstWhere(
      (product) => product.title == title,
      orElse: () => Product(
        title: 'Unknown',
        price: 0.0,
        description: '',
        category: '',
        images: ['https://via.placeholder.com/200'],
        total: 0.0,
        brand: '',
        id: '',
      ),
    );

    // Return the first image if available, or a placeholder
    return product.images.isNotEmpty
        ? product.images.first
        : 'https://via.placeholder.com/200';
  }
}
