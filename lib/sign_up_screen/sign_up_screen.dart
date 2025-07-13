import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/authTopDisplay.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:fleet_sync/sign_up_screen/controller/otpAllowController.dart';
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
    final otpAllowController = Get.put<Otpallowcontroller>(
      Otpallowcontroller(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Form(
        key: otpAllowController.validKey,
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

            _phoneNumberForm(otpAllowController),
            customElevatedButton(
              title: ConstStrings.varify,
              onPressed: () async {
                if (otpAllowController.validKey.currentState!.validate() &&
                    otpAllowController.allowOTP.value == true) {
                  return await Get.toNamed(
                    AppRoutes.otp,
                    arguments: [
                      ConstStrings.setpassword,
                      ConstStrings.setpassword,
                    ],
                  );
                }
              },
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
      ),
    );
  }

  Padding _phoneNumberForm(Otpallowcontroller otpAllowController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ConstStrings.phoneNumber),
              SizedBox(
                height: 12,
                child: Transform.scale(
                  scale: .6,
                  child: otpAllowController.allowOTPswitch(
                    otpAllowController.allowOTP,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextFormField(
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorStyle: TextStyle(color: Colors.red),
              ),
              // key: otpAllowController.validKey,
              controller: otpAllowController.phoneNumberController,
              validator: (value) {
                if (!otpAllowController.allowOTP.value) {
                  return "Please turn on the switch";
                }
                if (value == null || value.isEmpty) {
                  return "Please enter your phone number";
                }
                return null;
              },
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
