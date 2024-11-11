import 'package:flutter/material.dart';

class AppNavigator {
  static Future<void> pushReplacementWithoutAnimation(
    BuildContext context,
    Widget page, {
    Map<String, dynamic>? arguments,
  }) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => page,
        settings: RouteSettings(arguments: arguments),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
