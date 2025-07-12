import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<int>> list;
  const CustomDropdownFormField({
    super.key,
    required this.title,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
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
            child: DropdownButtonFormField(
              items: list,
              onChanged: (value) {
                print("$value");
              },
            ),
          ),
        ],
      ),
    );
  }
}
