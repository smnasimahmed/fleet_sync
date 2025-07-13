import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Otpallowcontroller extends GetxController {
  GlobalKey<FormState> validKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool allowOTP = false.obs;

  Widget allowOTPswitch(RxBool allowOTP) {
    return Obx(() {
      return Switch(
        value: allowOTP.value,
        onChanged: (newValue) {
          allowOTP.value = newValue;
          print('${allowOTP.value}');
        },
      );
    });
  }
}
