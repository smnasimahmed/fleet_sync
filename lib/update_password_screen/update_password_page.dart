import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/set_password/component/update_set_reset_form.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.changePassword),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UpdateSetResetForm(
            constStrings: ['', ConstStrings.update],
            rememberMeflag: false,
          ),
        ],
      ),
    );
  }
}
