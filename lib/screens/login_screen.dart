import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/screens/register.dart';

import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/color_palette.dart';
import 'package:myshop/widget/textformfield.dart';
import 'package:myshop/product/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  bool passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MyShop',
                  style: GoogleFonts.eduNswActFoundation(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF73877B),
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
                      obscureText: false,
                      controller: _emailController,
                    ),
                    MyTextFormField(
                      hintText: '*********',
                      obscureText: !passwordVisible, // corrected spelling here
                      controller: _passwordController,
                      icon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
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
                          color: const Color(0XFF839788),
                          onPress: () {
                            authController.signIn(
                                context,
                                _emailController.text,
                                _passwordController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Doesnt have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const RegisterScreen(),
                            transitionDuration: const Duration(seconds: 0),
                            reverseTransitionDuration:
                                const Duration(seconds: 0),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF73877B),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorPalette.background,
    );
  }
}
