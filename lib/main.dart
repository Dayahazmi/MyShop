import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/product/controller/address_controller.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/controller/order_controller.dart';
import 'package:myshop/screens/login_screen.dart';

void main() {
  Get.put(CartController());
  Get.put(AddressController());
  Get.put(OrderController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CartController());
      }),
      home: LoginScreen(),
    );
  }
}
