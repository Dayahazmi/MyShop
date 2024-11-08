import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myshop/product/model/prodect_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts(String category) async {
    try {
      final url = category == 'All'
          ? 'https://dummyjson.com/products'
          : 'https://dummyjson.com/products/category/$category';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final productList = data['products'] as List;
        return productList.map((json) => Product.fromJson(json)).toList();
      } else {
        if (kDebugMode) {
          print(
              'Failed to fetch products: ${response.statusCode}, ${response.body}');
        }
        throw Exception(
            'Failed to fetch products with status ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in fetchProducts: $e');
      }
      throw Exception('Failed to fetch products');
    }
  }

  Future<List<String>> fetchCategories() async {
    const url = 'https://dummyjson.com/products';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final productList = data['products'] as List;
      return productList
          .map((product) => product['category'] as String)
          .toSet()
          .toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
