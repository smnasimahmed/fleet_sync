import 'package:fleet_sync/const/const_strings.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          hintText: hintText??ConstStrings.searchHere,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
