import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/rememberMe.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/component/driver_personal_info_page.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/controller/radioController.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:fleet_sync/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverPersonalInfoRegistrationPage extends StatelessWidget {
  DriverPersonalInfoRegistrationPage({super.key});
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
              DriverPersonalInfoPage(),
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
              onPressed: () {
                if (controller.selectedTrailerOption.value == OwnATrailer.yes) {
                  Get.toNamed(AppRoutes.truckInformation);
                } else {
                  AppStorage().setLoginValue(RouteInitial.packageBuying);
                  Get.offAllNamed(AppRoutes.packageBuying);
                }
                print('Wellcome');
              },
            ),
          ),
        ),
      ],
    );
  }
}
