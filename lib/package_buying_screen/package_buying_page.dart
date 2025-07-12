import 'dart:ui';

import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageBuyingPage extends StatelessWidget {
  const PackageBuyingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: _trialCancleButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: _packageBody(isDark),
      ),
    );
  }

  Widget _packageBody(bool isDark) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Customtext(
          title: ConstStrings.getYourPackage,
          textColor: TextColor.colorGreen,
          textSize: 24,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 33),
          child: Text(
            ConstStrings.unlockPremiumFeaturesToGetMoreJobs,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),

        Container(
          width: double.infinity,
          // height: 150.0,
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF2B2B37) : Color(0xFFE6F9F1),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(colorSpace: ColorSpace.sRGB),
                offset: Offset(0, 1),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Customtext(
                title: ConstStrings.monthly,
                textSize: 18,
                fontWeight: FontWeight.w600,

                top: 13,
                bottom: 6,
              ),
              Customtext(
                title: ConstStrings.pricePerMonth,
                textSize: 24,
                fontWeight: FontWeight.w600,
                textColor: TextColor.colorGreen,

                bottom: 21,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FilledButton(
                  onPressed:  () => Get.toNamed(AppRoutes.paymentPage), 

                  child: Customtext(
                    title: ConstStrings.buyNow,
                    textColor:
                        isDark ? TextColor.colorBlack : TextColor.colorWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _trialCancleButton() {
  return Wrap(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 32, right: 20),
        child: Column(
          children: [
            customElevatedButton(
              title: ConstStrings.start3DaysFreeTrial,
              color: ConstColours.colorGreen,
              onPressed: () => Get.toNamed(AppRoutes.welcomePage), //paymentPage
            ),
            customElevatedButton(
              title: ConstStrings.cancel,
              color: Colors.red,
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    ],
  );
}
