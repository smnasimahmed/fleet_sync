import 'package:fleet_sync/const/const_strings.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              height: 40,
              fit: BoxFit.cover,
              // alignment: Alignment.center,
            ),
            SizedBox(
              height: 35,
              width: 78,
              child: Stack(
                alignment: Alignment.topLeft,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned(
                    top: -4,
                    child: Text(
                      ConstStrings.fleetSync,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    child: Text(
                      ConstStrings.technologies,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
