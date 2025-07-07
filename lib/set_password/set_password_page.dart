import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/authTopDisplay.dart';
import 'package:fleet_sync/set_password/component/update_set_reset_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordPage extends StatelessWidget {
  final List<String> constStrings = Get.arguments;
  SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTopDisplay(
            title: constStrings[1],
            subTitile: ConstStrings.provideUrPhNoToCngPass,
          ),
          UpdateSetResetForm(constStrings: constStrings),
        ],
      ),
    );
  }
}
