import 'dart:convert';

import 'package:get/get.dart';
import 'package:myshop/product/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  static const String _storageKey = 'register';
  final RxList<UserModel> users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    UserRegister();
  }

  Future<void> UserRegister() async {
    final prefs = await SharedPreferences.getInstance();
    final String? addressesJson = prefs.getString(_storageKey);
    if (addressesJson != null) {
      final List<dynamic> decodedList = json.decode(addressesJson);
      users.value =
          decodedList.map((item) => UserModel.fromJson(item)).toList();
    }
  }

  Future<void> saveRegister(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(
      users.map((address) => address.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encodedList);
  }
}
