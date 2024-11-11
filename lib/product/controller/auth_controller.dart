import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/screens/addtocart.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/appnavigator.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserEmail();
  }

  void _loadUserEmail() {
    User? user = _auth.currentUser;
    if (user != null) {
      userEmail.value = user.email ?? '';
    }
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => RootScreen(),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Sign up failed: $e');
      }
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        userEmail.value = userCredential.user!.email ?? '';

        AppNavigator.pushReplacementWithoutAnimation(
            context, const RootScreen());
      }
    } catch (e) {
      print('Sign In failed: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    userEmail.value = '';
    AppNavigator.pushReplacementWithoutAnimation(
        context, const AddToCartScreen());
  }
}
