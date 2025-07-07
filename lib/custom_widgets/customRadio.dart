import 'package:fleet_sync/const/const_colours.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final Widget title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;

  const CustomRadio({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: title,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor ?? ConstColours.colorGreen,
      visualDensity: VisualDensity(vertical: -4),
    );
  }
}
