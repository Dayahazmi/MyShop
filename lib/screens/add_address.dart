import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/product/controller/address_controller.dart';
import 'package:myshop/product/model/address_model.dart';
import 'package:myshop/screens/address_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:myshop/widget/textformfield.dart';

class AddAddressScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(1.0), // Set height for the line
            child: Container(
              color: Colors.grey[800], // Set line color
              height: 2.0, // Thickness of the line
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFormField(
                    hintText: "Street",
                    controller: _streetController,
                    obscureText: false,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter Street' : null,
                  ),
                  const SizedBox(height: 16),
                  MyTextFormField(
                    hintText: "City",
                    controller: _cityController,
                    obscureText: false,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter City' : null,
                  ),
                  const SizedBox(height: 16),
                  MyTextFormField(
                    hintText: "Postcode",
                    controller: _postalCodeController,
                    obscureText: false,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter City' : null,
                  ),
                  const SizedBox(height: 16),
                  MyTextFormField(
                    hintText: "State",
                    controller: _stateController,
                    obscureText: false,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter state' : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final controller = Get.find<AddressController>();
                          controller.addAddress(
                            Address(
                              street: _streetController.text,
                              city: _cityController.text,
                              postalCode: _postalCodeController.text,
                              state: _stateController.text,
                            ),
                          );
                          AppNavigator.pushReplacementWithoutAnimation(
                            context,
                            const AddressListScreen(),
                          );
                        }
                      },
                      child: Text(
                        'Save Address',
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
