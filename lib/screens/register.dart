import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/screens/login_screen.dart';
import 'package:myshop/widget/appnavigator.dart';
import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/color_palette.dart';
import 'package:myshop/widget/textformfield.dart';
import 'package:myshop/product/controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController authController = AuthController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(25.0),
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
                            AppNavigator.pushReplacementWithoutAnimation(
                                context, LoginScreen());
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
                          hintText: 'Email',
                          obscureText: false,
                          controller: _emailController,
                        ),
                        MyTextFormField(
                          hintText: '*********',
                          obscureText:
                              !passwordVisible, // corrected spelling here
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
                                authController.signUp(
                                  context,
                                  _emailController.text,
                                  _passwordController.text,
                                );
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
}
