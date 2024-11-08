import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/color_palette.dart';
import 'package:myshop/widget/textformfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  // Email validation function
  String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validation function
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MyShop',
                  style: GoogleFonts.eduNswActFoundation(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF73877B),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Login',
                  style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFBDBBB6)),
                ),
                Column(
                  children: [
                    MyTextFormField(
                      hintText: 'email@gmail.com',
                      obsecureText: false,
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                    MyTextFormField(
                      hintText: '*********',
                      obsecureText: true,
                      controller: _passwordController,
                      validator: validatePassword,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          text: "Login",
                          color: Color(0XFF839788),
                          onPress: () {
                            // Trigger validation on form submit
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const RootScreen(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                  reverseTransitionDuration:
                                      const Duration(seconds: 0),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Doesnt have an account? Sign Up here'),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorPalette.background,
    );
  }
}
