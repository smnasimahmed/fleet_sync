import 'package:fleet_sync/routes/app_routes.dart';
import 'package:get/get.dart';

class TruckDetailsController extends GetxController {
  void deletePost() {
    // Your delete logic here
    print("Post deleted");
  }

  void editPost() {
    // Navigate to edit page
    Get.toNamed(AppRoutes.truckSellPostFormPage);
  }

  void sendRequest() {
    // Your send request logic here
    print("Request sent");
  }
}
