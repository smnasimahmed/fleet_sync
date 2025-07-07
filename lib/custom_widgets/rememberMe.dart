import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Row rememberMeCheckBox(String title) {
  RxBool rememberMe = false.obs;

  return Row(
    children: [
      Obx(() {
        return Checkbox(
          value: rememberMe.value,
          onChanged: (value) {
            if (value != null) {
              rememberMe.value = value;
            }
          },
        );
      }),
      Expanded(
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
