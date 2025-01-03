import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myshop/product/controller/login_controller.dart';
import 'package:myshop/screens/register.dart';

import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/color_palette.dart';
import 'package:myshop/widget/textformfield.dart';
import 'package:myshop/product/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final LoginController loginController = Get.put(LoginController());
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
                    fontSize: 60,
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
                      hintText: 'Enter Your Email',
                      obscureText: false,
                      controller: _emailController,
                    ),
                    MyTextFormField(
                      hintText: 'Enter Your Password',
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
                const SizedBox(height: 15),
                SizedBox(
                  width: 150,
                  height: 80,
                  child: IconButton(
                    iconSize: 25,
                    icon: Image.asset('assets/Google__G__logo.svg'),
                    onPressed: () {
                      loginController.signInWithGoogle(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorPalette.background,
    );
  }
}
