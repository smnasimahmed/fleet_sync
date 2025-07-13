import 'package:flutter/material.dart';
import '../const/const_colours.dart';

class AuthTopDisplay extends StatelessWidget {
  final String title;
  final String subTitile;
  const AuthTopDisplay({
    super.key,
    required this.title,
    required this.subTitile,
  });
  @override
  Widget build(BuildContext context) {
    // bool isLight = Theme.of(context).brightness == Brightness.dark; // Unused
    return SizedBox(
      width: 276,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 11.54,
              right: 11.54,
              bottom: 11.54,
              top: 20
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: ConstColours.colorGreen,
              ),
            ),
          ),
          Text(
            subTitile,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 34.46),
        ],
      ),
    );
  }
}
