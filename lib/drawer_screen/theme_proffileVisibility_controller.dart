import 'package:get/get.dart';

class ThemeProfileVisibilityController extends GetxController {
  RxBool isThemeOn = false.obs;
  RxBool isProfileVisibilityOn = false.obs;

  void toggleTheme(bool val) => isThemeOn.value = val;
  void toggleProfileVisibility(bool val) => isProfileVisibilityOn.value = val;
}
