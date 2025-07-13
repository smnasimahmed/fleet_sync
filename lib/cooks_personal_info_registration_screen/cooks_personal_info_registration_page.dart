import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/cooks_personal_info_registration_screen/component/cooks_personal_info_page.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/rememberMe.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/controller/radioController.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CooksPersonalInfoRegistrationPage extends StatelessWidget {
  CooksPersonalInfoRegistrationPage({super.key});
  final RadioController controller = Get.find<RadioController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.registration),
      body: _registarionBody(),
    );
  }

  Center _registarionBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CooksPersonalInfoPage(),
              rememberMeCheckBox(ConstStrings.iAgreeTermsAndConditions),
              Padding(
                padding: const EdgeInsets.only(bottom: 43.0),
                child: _cancleNextButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cancleNextButton() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 9),
            child: customElevatedButton(
              title: ConstStrings.cancel,
              color: Colors.red,
              onPressed: () => Get.back(),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 9),
            child: customElevatedButton(
              title: ConstStrings.next,
              onPressed: () => Get.offAllNamed(AppRoutes.packageBuying),
            ),
          ),
        ),
      ],
    );
  }
}
