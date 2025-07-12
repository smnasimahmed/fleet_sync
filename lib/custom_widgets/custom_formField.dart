import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final bool numaric;
  final FieldType fieldType;
  final String? hintText;
  final int maxLine;
  final int? minLines;


  const CustomTextFormField({
    super.key,
    required this.title,
    this.numaric = false,
    this.hintText,
    this.fieldType = FieldType.normal,
    this.maxLine = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    RxBool obsecurePassword = true.obs;
    RxBool isPassword = false.obs;
    isPassword.value = fieldType == FieldType.password;
    RxBool isSearch = false.obs;
    isSearch.value = fieldType == FieldType.search;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (title == '')
              ? SizedBox(height: 0, width: double.infinity)
              : Text(title),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Obx(() {
              return TextFormField(
                minLines: minLines,
                maxLines: maxLine,
                textInputAction: TextInputAction.newline,
                keyboardType: numaric ? TextInputType.number : null,
                obscureText: isPassword.value ? obsecurePassword.value : false,
                decoration: InputDecoration(
                  hintText: hintText,
                  suffixIcon:
                      isPassword.value
                          ? IconButton(
                            onPressed:
                                () => {
                                  obsecurePassword.value =
                                      !obsecurePassword.value,
                                },
                            icon: Icon(
                              obsecurePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          )
                          : null,
                  prefixIcon: isSearch.value ? searchIcon() : null,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

enum FieldType { normal, password, search }

Widget searchIcon() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: SvgPicture.asset(
      'assets/icons/search.svg',
      colorFilter: ColorFilter.mode(Colors.white24, BlendMode.srcIn),
    ),
  );
}
