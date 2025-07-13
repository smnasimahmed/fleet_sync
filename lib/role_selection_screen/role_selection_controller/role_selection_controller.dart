import 'package:fleet_sync/routes/app_routes.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class RoleSelectionController extends GetxController {
  var selectedIndex = 0.obs;
  final roles = ['Driver', 'Company', 'Mechanic', 'Fuel Provider', 'Cook'];

  final icons = [
    'assets/icons/driver.svg',
    'assets/icons/company.svg',
    'assets/icons/mechanic.svg',
    'assets/icons/fuel_provider.svg',
    'assets/icons/cook.svg',
  ];

  String get selectedRole => roles[selectedIndex.value];

  void roleWiseFormNavigate(int index) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.driverPersonalInfoReg);
        break;
      case 1:
        Get.toNamed(AppRoutes.comapnyInfoRegistrationPage);
        break;
      case 2:
        Get.toNamed(AppRoutes.mechanicsPersonalInfoRegistrationPage);
        break;
      case 3:
        Get.toNamed(AppRoutes.fuelProviderInfoRegistrationPage);
        break;
      case 4:
        Get.toNamed(AppRoutes.cooksPersonalInfoRegistrationPage);
        break;
      default:
        Get.defaultDialog(
          title: 'Route Error',
          middleText: 'Route Not Found. Please Contact to Developer',
        );
    }
  }
}
