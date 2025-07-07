import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: ConstStrings.faq),
      body: SingleChildScrollView(
        child: Customtext(
          title: ConstStrings.faqDescrition,
          maxLine: 60,
          fontWeight: FontWeight.w400,
          textSize: 14,
          right: 21,
          left: 23,
        ),
      ),
    );
  }
}
