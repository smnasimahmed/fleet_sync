import 'package:fleet_sync/routes/app_routes.dart';
import 'package:fleet_sync/routes/app_routes_file.dart';
import 'package:fleet_sync/storage_service.dart';
import 'package:fleet_sync/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        theme: themeDataLight,
        darkTheme: themeDataDark,
        themeMode: ThemeMode.dark,
        defaultTransition: Transition.noTransition,
        // home: DriverPersonalInfoRegistrationPage(),
        initialRoute: //AppRoutes.navbar,
            (AppStorage().getLoginValue() == true)
                ? AppRoutes.navbar
                : AppRoutes.login,
        // initialBinding: RootBindings(),
        getPages: appRouteFile,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
