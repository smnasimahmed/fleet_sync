import 'dart:ui';

import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> logOutPopUp(BuildContext context) {

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
        child: Dialog(
          backgroundColor: ConstColours.appDarktBackGround, // dark background
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 246,
                  child: Customtext(
                    textAlign: TextAlign.center,
                    title: ConstStrings.areYouSureLogOut,
                    textColor: TextColor.colorWhite,
                    fontWeight: FontWeight.w500,
                    textSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _noButton(context),
                    SizedBox(width: 12),
                    _yesButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _yesButton(BuildContext context) {
      final logInSession = GetStorage();
  return SizedBox(
    height: 30,
    child: ElevatedButton(
      onPressed: () {
            logInSession.write('role', 0);
        logInSession.write('logInSession', false);
        Get.toNamed(AppRoutes.login);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ConstColours.colorGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Customtext(
        title: ConstStrings.yes,
        textColor: TextColor.colorWhite,
        fontWeight: FontWeight.w400,
        textSize: 14,
      ),
      // ),
    ),
  );
}

Widget _noButton(BuildContext context) {
  return SizedBox(
    height: 30,
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ConstColours.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Customtext(
        title: ConstStrings.no,
        textColor: TextColor.colorWhite,
        fontWeight: FontWeight.w400,
        textSize: 14,
      ),
      // ),
    ),
  );
}
