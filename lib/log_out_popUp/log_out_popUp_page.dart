import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class LogOutPopupPage extends StatelessWidget {
  const LogOutPopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: ConstStrings.logOut),
        body: Text('No LouOut POP UP'),
      ),
    );
  }
}
