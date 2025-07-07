import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/authTopDisplay.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SingleChildScrollView(child: signUpView())),
    );
  }

  Widget signUpView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTopDisplay(
            title: ConstStrings.signUp,
            subTitile: ConstStrings.signUpSubTitile,
          ),
          Row(
            children: [
              Flexible(
                child: CustomTextFormField(
                  title: ConstStrings.firstName,
                  fieldType: FieldType.normal,
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: CustomTextFormField(
                  title: ConstStrings.lastName,
                  fieldType: FieldType.normal,
                ),
              ),
            ],
          ),
          CustomTextFormField(
            title: ConstStrings.phoneNumber,
            fieldType: FieldType.normal,
          ),
          customElevatedButton(
            title: ConstStrings.varify,
            onPressed:
                () => Get.toNamed(
                  AppRoutes.otp,
                  arguments: [
                    ConstStrings.setpassword,
                    ConstStrings.setpassword,
                  ],
                  // First one authTopName and Second one for button
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 162), //159
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ConstStrings.alRdyHavAnAcunt),
                GestureDetector(
                  child: Customtext(
                    title: ConstStrings.logIn,
                    textSize: 12,
                    textColor: TextColor.colorGreen,
                  ),
                  onTap: () => Get.offNamed(AppRoutes.login),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
