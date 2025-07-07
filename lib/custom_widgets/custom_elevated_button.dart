import 'package:fleet_sync/const/const_colours.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customElevatedButton({
  required String title,
  required void Function()? onPressed,
  Color? color = ConstColours.colorGreen,
  double height = 56,
  double fontSize = 16,
  double width = double.infinity,
  double top = 12,
  FontWeight fontWeight = FontWeight.w600,
  double horizontal = 20,
  // double vertical = 8,
}) {
  return Padding(
    padding: EdgeInsets.only(top: top), //12
    child: ElevatedButton(
      onPressed: onPressed ?? () => print("Elevated Button Pressed"),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.manrope(
          fontSize: fontSize,
          fontWeight: fontWeight,
          textStyle: TextStyle(),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: Size(width, height),
        padding: EdgeInsets.symmetric(
          // vertical: vertical,
          horizontal: horizontal,
        ),
      ),
      child: Text(title),
    ),
  );
}
