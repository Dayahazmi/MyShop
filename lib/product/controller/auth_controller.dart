import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myshop/screens/login_screen.dart';
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
    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be more than 6 characters',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        AppNavigator.pushReplacementWithoutAnimation(
            context, const LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The email is already in use by another account.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'The email address is not valid.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password is too weak.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Sign up failed: $e',
            snackPosition: SnackPosition.BOTTOM);
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for this email.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect password.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Sign In failed: Please Sign In again',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Sign In failed: Please Sign In again');
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    userEmail.value = '';
    AppNavigator.pushReplacementWithoutAnimation(context, const LoginScreen());
  }
}
