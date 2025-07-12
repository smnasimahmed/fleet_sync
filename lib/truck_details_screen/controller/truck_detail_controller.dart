import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:get/get.dart';

class TruckDetailsController extends GetxController {
  void deletePost() {
    // Your delete logic here
    print("Post deleted");
  }

  void editPost() {
    // Navigate to edit page
    Get.toNamed(
      AppRoutes.truckSellPostFormPage,
      arguments: [ConstStrings.editPost, ConstStrings.update],
    );
  }

  void sendRequest() {
    // Your send request logic here
    print("Request sent");
  }
}
