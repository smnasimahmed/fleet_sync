import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:fleet_sync/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkipNextButton extends StatelessWidget {
  const SkipNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: customElevatedButton(
              title: ConstStrings.skip,
              color: ConstColours.yellow,
              onPressed: () {
                AppStorage().setLoginValue(RouteInitial.packageBuying);
                Get.offAllNamed(AppRoutes.packageBuying);
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: customElevatedButton(
              title: ConstStrings.done,
              onPressed: () {
                AppStorage().setLoginValue(RouteInitial.packageBuying);
                Get.offAllNamed(AppRoutes.packageBuying);
              },
            ),
          ),
        ),
      ],
    );
  }
}
