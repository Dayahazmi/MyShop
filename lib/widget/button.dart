import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPress;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        height: 45,
        elevation: 0,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        onPressed: () => onPress(),
        color: color,
        child: Text(
          text,
          style: GoogleFonts.roboto(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
