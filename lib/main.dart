import 'package:fleet_sync/routes/app_routes.dart';
import 'package:fleet_sync/routes/app_routes_file.dart';
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
    final logInSession = GetStorage();
    return GetMaterialApp(
      theme: themeDataLight,
      darkTheme: themeDataDark,
      themeMode: ThemeMode.dark,
      // home: ChatPage(),
      initialRoute:
          (logInSession.read('logInSession') == true)
              ? AppRoutes.navbar
              : AppRoutes.login, //AppRoutes.navbar,
      getPages: appRouteFile,
      debugShowCheckedModeBanner: false,
    );
  }
}
