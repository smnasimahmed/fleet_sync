import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/authTopDisplay.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthTopDisplay(
                  title: ConstStrings.forgotPassword, // title: 'Set Password',
                  subTitile:
                      ConstStrings
                          .forgotPasswordTitile, // subTitile: 'Provide your Phone number to change password.',
                ),

                CustomTextFormField(
                  title: ConstStrings.email, // title: 'Confirm Password',
                ),

                customElevatedButton(
                  title: ConstStrings.sendOTP,
                  onPressed:
                      () => Get.toNamed(
                        AppRoutes.otp,
                        arguments: [
                          ConstStrings.resetPassword,
                          ConstStrings.resetPassword,
                        ],
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
