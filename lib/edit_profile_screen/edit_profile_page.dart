import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/skip_nextButton.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/component/driver_personal_info_page.dart';
import 'package:fleet_sync/turck_information_screen/component/truck_info_form_page.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 43.0, left: 20, right: 20),
        child: SkipNextButton(),
      ),
      appBar: CustomAppBar(title: ConstStrings.editProfile),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              DriverPersonalInfoPage(),
              TruckInfoFormBody(),
            ],
          ),
        ),
      ),
    );
  }
}
