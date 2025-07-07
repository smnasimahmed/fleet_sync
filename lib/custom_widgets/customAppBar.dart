import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 64,
      title: Customtext(
        title: title,
        textSize: 18,
        textColor: TextColor.colorGreen,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: ConstColours.appDarktBackGround,
      elevation: 0,
      leading: _customBackButton(),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Widget _customBackButton() {
  return InkWell(
    child: SizedBox(
      height: 6,
      width: 6,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          'assets/icons/back_button.svg',
          colorFilter: ColorFilter.mode(
            ConstColours.colorGreen,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    onTap: () => Get.back(),
  );
}
