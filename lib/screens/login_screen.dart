import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/screens/register.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/user_auth/firebase/auth_services.dart';
import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/color_palette.dart';
import 'package:myshop/widget/textformfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
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
                      obsecureText: false,
                      controller: _emailController,
                    ),
                    MyTextFormField(
                      hintText: '*********',
                      obsecureText: passwordVisible,
                      controller: _passwordController,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                            _signIn();
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

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signIn(email, password);
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
        print('Sign In failed');
      }
    }
  }
}
