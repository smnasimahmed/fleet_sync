import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/rememberMe.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateSetResetForm extends StatelessWidget {
  final bool rememberMeflag;
  final List<String> constStrings;
  const UpdateSetResetForm({
    required this.constStrings,
    super.key,
    this.rememberMeflag = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            title: ConstStrings.setpassword,
            fieldType: FieldType.normal,
          ),
          CustomTextFormField(
            title: ConstStrings.confirmPassword,
            fieldType: FieldType.normal,
          ),
          rememberMeflag == true
              ? rememberMeCheckBox(ConstStrings.rememberMe)
              : SizedBox(height: 0, width: double.infinity),

          customElevatedButton(
            title: constStrings[1],
            onPressed: () => Get.offAllNamed(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}
