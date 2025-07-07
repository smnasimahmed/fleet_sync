import 'package:fleet_sync/navbar/navbar.dart';
import 'package:fleet_sync/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Get.put(RoleSelectionController());
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeDataLight,
      darkTheme: themeDataDark,
      themeMode: ThemeMode.dark,
      home: Navbar(),
      // initialRoute: AppRoutes.login, //AppRoutes.navbar,
      // getPages: appRouteFile,
      debugShowCheckedModeBanner: false,
    );
  }
}
