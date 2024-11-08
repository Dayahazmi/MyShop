import 'package:get/get.dart';
import 'package:myshop/product/model/prodect_model.dart';
import 'package:myshop/product/product_services/product_services.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs; // Observable list of products
  var isLoading = true.obs; // Observable loading state
  var error = ''.obs; // Observable error message

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      error('');
      final productList = await ProductService().fetchProducts();
      products.assignAll(productList);
    } catch (e) {
      error('Failed to fetch products');
    } finally {
      isLoading(false);
    }
  }
}
