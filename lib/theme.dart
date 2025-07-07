import 'package:fleet_sync/const/const_colours.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeDataLight = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Manrope',
  scaffoldBackgroundColor: ConstColours.white,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: ConstColours.colorGreen,
    selectionColor: ConstColours.colorGreen,
    selectionHandleColor: ConstColours.colorGreen,
  ),

  inputDecorationTheme: InputDecorationTheme(
    // filled: false,
    fillColor: const Color.fromARGB(255, 44, 44, 68),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ConstColours.gray),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.black),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.white54),

  textTheme: GoogleFonts.manropeTextTheme(
    ThemeData.light().textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return ConstColours.colorGreen; // Checked = green box
      }
      return Colors.black; // Unchecked = white box
    }),
    checkColor: WidgetStateProperty.all<Color>(Colors.black), // White tick
    side: const BorderSide(color: Colors.white54), //border for unchecked box
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: ConstColours.colorGreen,
  //     foregroundColor: Colors.white,
  //     textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  //     minimumSize: Size(double.infinity, 56),
  //   ),
  // ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: ConstColours.white,
    // foregroundColor: Colors.white,
  ),
);

ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Manrope',
  scaffoldBackgroundColor: ConstColours.appDarktBackGround,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: ConstColours.colorGreen,
    selectionColor: ConstColours.colorGreen,
    selectionHandleColor: ConstColours.colorGreen,
  ),

  inputDecorationTheme: InputDecorationTheme(
    // filled: false,
    fillColor: const Color.fromARGB(255, 44, 44, 68),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ConstColours.gray),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.white54),

  textTheme: GoogleFonts.manropeTextTheme(
    ThemeData.light().textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return ConstColours.colorGreen; // Checked = green box
      }
      return Colors.white; // Unchecked = white box
    }),
    checkColor: WidgetStateProperty.all<Color>(Colors.white), // White tick
    side: const BorderSide(color: Colors.white54), //border for unchecked box
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: ConstColours.colorGreen,
  //     foregroundColor: Colors.white,
  //     textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  //     minimumSize: Size(double.infinity, 56),
  //   ),
  // ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(10),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ConstColours.appDarktBackGround,
    // foregroundColor: Colors.white,
  ),

  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFE6F4EA); // mint track when ON
      }
      return Color(0xFFB0B0B0); // gray track when OFF
    }),
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF00C853); // bright green thumb when ON
      }
      return Color(0xFF000000); // black thumb when OFF
    }),
  ),
  // switchTheme: SwitchThemeData(
  //   // Style for the "on" state
  //   thumbColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.green; // Color of the thumb when switch is ON
  //     }
  //     return Colors.black; // Fallback for thumb when OFF
  //   }),
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors
  //           .lightGreen[100]; // Color of the track when switch is ON (lighter green)
  //     }
  //     return Colors.grey[400]; // Color of the track when switch is OFF (grey)
  //   }),
  //   // Optional: Splash color when tapped
  //   overlayColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.pressed)) {
  //       return Colors.green.withOpacity(0.2); // Light green ripple on press
  //     }
  //     return Colors.transparent;
  //   }),
  // ),
);
