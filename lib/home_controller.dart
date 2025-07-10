import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ScrollUnfocus extends GetxController {
  final ScrollController scrollController = ScrollController();
  // final ScrollController listscrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener((){
      if (scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
    // listscrollController.addListener(() {
    //   if (listscrollController.position.userScrollDirection !=
    //       ScrollDirection.idle) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //   }
    // });
  }

  @override
  void onClose() {
    scrollController.dispose();
    // listscrollController.dispose();
    super.onClose();
  }
}
