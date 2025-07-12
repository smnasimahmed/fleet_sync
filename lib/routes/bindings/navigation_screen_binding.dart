import 'package:fleet_sync/navbar/controller/navbar_controller.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/controller/radioController.dart';
import 'package:fleet_sync/role_selection_screen/role_selection_controller/role_selection_controller.dart';
import 'package:fleet_sync/truck_details_screen/controller/truck_detail_controller.dart';
import 'package:fleet_sync/truck_sell_post_form_screen/controller/upload_Image_Controler.dart';
import 'package:get/get.dart';

class NavigationScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(RoleSelectionController());
    Get.lazyPut(() => RoleSelectionController());
    Get.lazyPut(() => RadioController());
    Get.lazyPut(() => NavbarController());
    Get.lazyPut(() => TruckDetailsController());
    Get.lazyPut(() => UploadImageControler());
    // Get.lazyPut(() => ScrollUnfocus());
  }
}
