import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/button.dart';
import 'package:myshop/widget/textformfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MyShop',
              style: GoogleFonts.eduNswActFoundation(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Login',
              style:
                  GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
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
                  obsecureText: true,
                  controller: _passwordController,
                )
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
                        color: Colors.black87,
                        onPress: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const RootScreen(),
                              transitionDuration: const Duration(seconds: 0),
                              reverseTransitionDuration:
                                  const Duration(seconds: 0),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text('Or'),
              ],
            )
          ],
        ),
      )),
    );
  }
}
