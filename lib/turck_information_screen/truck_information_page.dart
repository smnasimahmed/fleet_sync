import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/skip_nextButton.dart';
import 'package:fleet_sync/turck_information_screen/component/truck_info_form_page.dart';
import 'package:flutter/material.dart';

class TruckInformationPage extends StatelessWidget {
  const TruckInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 43.0),
        child: SkipNextButton(),
      ),
      appBar: CustomAppBar(title: ConstStrings.registration),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: TruckInfoFormBody(),
        ),
      ),
    );
  }
}
