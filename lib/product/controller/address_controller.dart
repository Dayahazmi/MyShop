import 'dart:convert';
import 'package:get/get.dart';
import 'package:myshop/product/model/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController {
  static const String _storageKey = 'addresses';
  final RxList<Address> addresses = <Address>[].obs;
  var selectedAddress = Rxn<Address>();

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? addressesJson = prefs.getString(_storageKey);
    if (addressesJson != null) {
      final List<dynamic> decodedList = json.decode(addressesJson);
      addresses.value =
          decodedList.map((item) => Address.fromJson(item)).toList();
    }
  }

  Future<void> saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(
      addresses.map((address) => address.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encodedList);
  }

  void addAddress(Address address) async {
    addresses.add(address);
    await saveAddresses();
  }

  void toggleSelection(int index) {
    for (var i = 0; i < addresses.length; i++) {
      addresses[i].isSelected = i == index;
    }
    selectedAddress.value = addresses[index];
    addresses.refresh();
  }

  String? get selectedAddressText {
    return selectedAddress.value?.fullAddress;
  }
}
