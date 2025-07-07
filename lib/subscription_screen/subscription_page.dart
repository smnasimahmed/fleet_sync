import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/set_password/set_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.subscriptions),
      body: Center(
        child: customElevatedButton(
          title: ConstStrings.subscriptions,
          onPressed: () {
            Get.to(() => SetPasswordPage());
          },
        ),
      ),
    );
  }
}
