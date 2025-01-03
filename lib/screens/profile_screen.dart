import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/product/controller/auth_controller.dart';
import 'package:myshop/product/controller/cart_controller.dart';
import 'package:myshop/product/controller/login_controller.dart';
import 'package:myshop/screens/address_screen.dart';
import 'package:myshop/screens/addtocart.dart';
import 'package:myshop/screens/order_screen.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:myshop/widget/color_palette.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CartController cartController = Get.put(CartController());
  final AuthController authController = Get.put(AuthController());
  final LoginController loginController = Get.find<LoginController>();

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
        title: const Text('Profile'),
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
                const SizedBox(height: 20),
                // Profile Image
                Obx(() {
                  return loginController.userPhoto.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(loginController.userPhoto.value),
                          radius: 50,
                        )
                      : const Icon(Icons.account_circle, size: 100);
                }),
                const SizedBox(height: 16),
                // Name
                Obx(() {
                  return Text(
                    loginController.userName.value,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  );
                }),

                const SizedBox(height: 10),
                Align(
                  alignment:
                      Alignment.centerLeft, // Align 'My Account' to the left
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'My Account',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Addresses Button
                const SizedBox(height: 5),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Addresses'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    AppNavigator.pushReplacementWithoutAnimation(
                        context, const AddressListScreen());
                  },
                ),
                const SizedBox(
                  height: 180,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      authController.signOut(context);
                    },
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ),
                ),
                // Logout Button
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        unselectedItemColor: ColorPalette.accent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: 'Order History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      backgroundColor: ColorPalette.background,
    );
  }
}
