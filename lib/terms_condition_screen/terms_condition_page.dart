import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.termsAndConditions),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        child: const Customtext(
          title: ConstStrings.termsAndConditionsDescription,
          maxLine: 100,
        ),
      ),
    );
  }
}
