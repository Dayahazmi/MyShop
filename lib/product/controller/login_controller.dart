import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myshop/screens/root_screen.dart';
import 'package:myshop/widget/appnavigator.dart';

class LoginController extends GetxController {
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userPhoto = ''.obs;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Fetch and store user details
        userName.value = userCredential.user!.displayName ?? '';
        userEmail.value = userCredential.user!.email ?? '';
        userPhoto.value = userCredential.user!.photoURL ?? '';

        // Navigate to another page
        AppNavigator.pushReplacementWithoutAnimation(
            context, const RootScreen());
      }
    } catch (e) {
      debugPrint('exception->$e');
    }
  }
}
