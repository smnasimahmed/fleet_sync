import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/authTopDisplay.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatelessWidget {
  final constStrings = Get.arguments;
  OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SingleChildScrollView(child: otpBody())),
    );
  }

  Widget otpBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        children: [
          AuthTopDisplay(
            title: ConstStrings.otpVarification, // title: 'OTP Varification',
            subTitile:
                ConstStrings
                    .otpVarificationSubtitle, // subTitile: 'Provide your email address to change password.',
          ),
          OtpGenerator(),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: customElevatedButton(
              title: ConstStrings.varify,
              onPressed:
                  () => Get.offNamed(
                    AppRoutes.setResetPassword,
                    arguments: constStrings,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21),
            child: Customtext(
              title: ConstStrings.resendCode, // title: 'Resend Code',
              textSize: 16,
              textColor: TextColor.colorRed,
            ),
          ),
        ],
      ),
    );
  }
}

class OtpGenerator extends StatelessWidget {
  const OtpGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      animationType: AnimationType.fade,

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 44,
        fieldWidth: 44,
        borderWidth: 1.0,
        inactiveColor: Colors.white24,
        selectedColor: Colors.white24,
        activeColor: Colors.white24,
      ),
    );
  }
}
