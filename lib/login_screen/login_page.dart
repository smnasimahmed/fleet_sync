import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/authTopDisplay.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/custom_widgets/rememberMe.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SingleChildScrollView(child: loginView())),
    );
  }

  Widget loginView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTopDisplay(
            title: ConstStrings.logIn,
            subTitile: ConstStrings.logInASubTitle,
          ),
          CustomTextFormField(
            title: ConstStrings.email,
            fieldType: FieldType.normal,
          ),
          CustomTextFormField(
            title: ConstStrings.password,
            fieldType: FieldType.password,
          ),
          loginOperation(),
          customElevatedButton(
            title: ConstStrings.signIn,
            onPressed: () => Get.offAllNamed(AppRoutes.roleSelection),
          ),
          SizedBox(height: 162),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(ConstStrings.dntHaveAAcunt),
        GestureDetector(
          child: Text(
            ConstStrings.registerNow,
            style: TextStyle(color: ConstColours.colorGreen),
          ),
          onTap: () => Get.offNamed(AppRoutes.signUp),
        ),
      ],
    );
  }

  Widget loginOperation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: rememberMeCheckBox(ConstStrings.rememberMe)),

          GestureDetector(
            child: GestureDetector(
              child: Customtext(
                title: ConstStrings.forgotPassword,
                textSize: 10,
                textColor: TextColor.colorRed,
              ),
              onTap: () => Get.toNamed(AppRoutes.forgotPassword),
            ),
          ),
        ],
      ),
    );
  }
}
