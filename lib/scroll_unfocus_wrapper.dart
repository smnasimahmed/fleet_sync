import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollUnfocusWrapper extends StatelessWidget {
  final Widget child;

  const ScrollUnfocusWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction != ScrollDirection.idle) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        return false;
      },
      child: child,
    );
  }
}
