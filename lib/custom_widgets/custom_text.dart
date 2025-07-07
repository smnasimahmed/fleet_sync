import 'package:fleet_sync/const/const_colours.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtext extends StatelessWidget {
  final String title;
  final TextColor? textColor;
  final FontWeight? fontWeight;
  final int textSize;
  final bool fontPoppins;
  final int top;
  final int right;
  final int left;
  final int bottom;
  final TextAlign textAlign;
  final int maxLine;
  const Customtext({
    super.key,
    required this.title,
    this.textColor,
    this.fontWeight,
    this.textSize = 14,
    this.fontPoppins = false,
    this.top = 0,
    this.right = 0,
    this.left = 0,
    this.bottom = 0,
    this.textAlign = TextAlign.left,
    this.maxLine = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top.toDouble(),
        left: left.toDouble(),
        right: right.toDouble(),
        bottom: bottom.toDouble(),
      ),
      child: Text(
        title,
        textAlign: textAlign,
        maxLines: maxLine,

        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily:
              fontPoppins
                  ? GoogleFonts.poppins().fontFamily
                  : GoogleFonts.manrope().fontFamily,
          fontSize: textSize.toDouble(),
          fontWeight: fontWeight,
          color: textColor?.value,
        ),
      ),
    );
  }
}

// Text CustomText({
//   required String title,
//   int textSize = 14,
//   TextColor? textColor,
//   FontWeight? fontWeight,
//   bool fontPoppins = false,
// }) =>

// GoogleFonts.poppins(
//     fontSize: textSize.toDouble(),
//     fontWeight: fontWeight,
//     color: textColor?.value,
//   ),

// enum CustomTextSize {
//   tweleve(12),
//   fourteen(14),
//   ten(10),
//   sixteen(16);

//   final int value;
//   const CustomTextSize(this.value);
// }

enum TextColor {
  colorRed(Colors.red),
  colorGreen(ConstColours.colorGreen),
  colorBlack(ConstColours.black),
  colorWhite(ConstColours.white),
  colorGray(ConstColours.gray),
  colorOffWhite(ConstColours.offWhite);

  final Color value;
  const TextColor(this.value);
}
