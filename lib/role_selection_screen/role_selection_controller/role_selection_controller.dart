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
//    final role = GetStorage();

//  void updateRoleIndex(int index){   
//    role.write('role', selectedRole);
//  }

//   @override
//   void onInit() {
//     super.onInit();

//    updateRoleIndex(selectedIndex.value);
//     // role.write('role', 0);
//   }
}
