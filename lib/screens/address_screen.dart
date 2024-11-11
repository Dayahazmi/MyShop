import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/product/controller/address_controller.dart';
import 'package:myshop/screens/add_address.dart';
import 'package:myshop/screens/addtocart.dart';
import 'package:myshop/screens/profile_screen.dart';
import 'package:myshop/widget/appnavigator.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final AddressController controller = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    final bool fromCart = Get.arguments?['fromCart'] ?? false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (fromCart) {
                AppNavigator.pushReplacementWithoutAnimation(context,
                    const AddToCartScreen()); // Kembali ke Cart Screen (Screen C)
              } else {
                AppNavigator.pushReplacementWithoutAnimation(
                  context,
                  const ProfileScreen(),
                );
                // Kembali ke screen sebelumnya (secara lalai Profile Screen, Screen B)
              }
            }),
        title: const Text('Address'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Set height for the line
          child: Container(
            color: Colors.grey[800], // Set line color
            height: 2.0, // Thickness of the line
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: controller.addresses.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    return ListTile(
                      title: Text(address.fullAddress),
                      trailing: Checkbox(
                        value: address.isSelected,
                        onChanged: (_) {
                          controller.toggleSelection(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    '+ Add address',
                  ),
                  onPressed: () => Get.to(() => AddAddressScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
