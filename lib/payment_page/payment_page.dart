import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text('${ConstStrings.paymentPage} Click me!!!!!'),
          onTap: () => Get.toNamed(AppRoutes.welcomePage),
        ),
      ),
    );
  }
}
