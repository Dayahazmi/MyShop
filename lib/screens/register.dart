import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshop/product/controller/register_controller.dart';
import 'package:myshop/screens/login_screen.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/user_auth/firebase/auth_services.dart';
import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/color_palette.dart';
import 'package:myshop/widget/textformfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    _name.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MyShop',
                      style: GoogleFonts.eduNswActFoundation(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 25, color: ColorPalette.textNeutral),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'If you have an account, ',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        LoginScreen(),
                                transitionDuration: const Duration(seconds: 0),
                                reverseTransitionDuration:
                                    const Duration(seconds: 0),
                              ),
                            );
                          },
                          child: const Text(
                            'please login',
                            style: TextStyle(
                              color: ColorPalette.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        MyTextFormField(
                          hintText: 'Name',
                          obsecureText: false,
                          controller: _name,
                        ),
                        MyTextFormField(
                          hintText: 'Email',
                          obsecureText: false,
                          controller: _emailController,
                        ),
                        MyTextFormField(
                          hintText: 'Password',
                          obsecureText: true,
                          controller: _passwordController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              text: "Register",
                              color: const Color(0XFF839788),
                              onPress: () {
                                _signup();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        )),
      ),
      backgroundColor: ColorPalette.background,
    );
  }

  void _signup() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUp(email, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => RootScreen(),
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    } else {
      if (kDebugMode) {
        print('Sign up failed');
      }
    }
  }
}
