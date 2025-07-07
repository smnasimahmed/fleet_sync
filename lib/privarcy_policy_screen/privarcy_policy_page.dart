import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class PrivarcyPolicyPage extends StatelessWidget {
  const PrivarcyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: ConstStrings.privacyPolicy),
        body: Center(child: Text('No Privacy Policy Implimented')),
      ),
    );
  }
}
