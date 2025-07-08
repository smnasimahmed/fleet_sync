import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/role_selection_screen/role_selection_controller/role_selection_controller.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:fleet_sync/const/const_colours.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleSelectionPage extends StatelessWidget {
  RoleSelectionPage({super.key});

  final RoleSelectionController roleSelectionController =
      Get.find<RoleSelectionController>();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 43),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: customElevatedButton(
            title: ConstStrings.continu,
            onPressed: () => Get.toNamed(AppRoutes.personalInfoReg),
          ),
        ),
      ),
      body: selectRole(isDark),
    );
  }

  Obx selectRole(bool isDark) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 69),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectRoleText(),
            ..._generatingButton(isDark),

          ],
        ),
      );
    });
  }

  List<Widget> _generatingButton(bool isDark) {
    return List.generate(roleSelectionController.roles.length, (index) {
      final isSelected = roleSelectionController.selectedIndex.value == index;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: _roleButton(index, isDark, isSelected),
      );
    });
  }

  ElevatedButton _roleButton(int index, bool isDark, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        roleSelectionController.selectedIndex.value = index;
        final role = GetStorage();
        role.write('role', index);
      },

      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? ConstColours.colorGreen : Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
        side: BorderSide(color: ConstColours.gray, width: 1),
        textStyle: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 48),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 39.99, left: 5),
            child: svgIcons(index, isDark),
          ),
          Text(roleSelectionController.roles[index]),
        ],
      ),
    );
  }

  SvgPicture svgIcons(int index, bool isDark) {
    return SvgPicture.asset(
      roleSelectionController.icons[index],
      height: 20,
      width: 20,
      colorFilter: ColorFilter.mode(
        isDark ? ConstColours.white : ConstColours.black,
        BlendMode.srcIn,
      ),
    );
  }

  Padding _selectRoleText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Text(
        ConstStrings.selectYourRole,
        style: GoogleFonts.manrope(
          color: ConstColours.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
