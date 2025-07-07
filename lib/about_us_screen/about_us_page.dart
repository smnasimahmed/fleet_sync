import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.aboutUs),
      body: Customtext(
        title: ConstStrings.aboutUsDescription,
        fontWeight: FontWeight.w400,
        textSize: 14,
        maxLine: 50,
        left: 22,
        right: 22,
      ),
    );
  }
}
