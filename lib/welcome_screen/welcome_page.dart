import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/role_selection_screen/role_selection_controller/role_selection_controller.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  final controller = Get.find<RoleSelectionController>();
  final role = GetStorage();
  final logInSession = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 43, right: 20, left: 20),
        child: customElevatedButton(
          title: ConstStrings.letsGetStarted,
          onPressed: () {
            logInSession.write('logInSession', true);
            Get.toNamed(AppRoutes.navbar);
          },
        ),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('I am not getting Icons here. Need to fix later on...!!!!'),
            SvgPicture.asset('assets/icons/fleet.svg', height: 100, width: 100),
            Customtext(
              title:
                  '${ConstStrings.welcomeTo}\n${ConstStrings.fleetSyncCommunity}',
              textSize: 28,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),

            Customtext(
              title:
                  '${ConstStrings.your}${controller.roles[role.read('role') ?? 0]}${ConstStrings.profileIsNowActive}',
              textSize: 18,
              fontWeight: FontWeight.w600,
              textColor: TextColor.colorGreen,
              top: 10,
            ),
          ],
        ),
      ),
    );
  }
}
