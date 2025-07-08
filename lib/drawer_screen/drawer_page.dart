import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/custom_widgets/logoutPopUP.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});

  final List<String> iconAsset = [
    'assets/icons/theme.svg',
    'assets/icons/profile_visibility.svg',
    'assets/icons/language.svg',
    'assets/icons/saved_posts.svg',
    'assets/icons/notifications.svg',
    'assets/icons/subscriptions.svg',
    'assets/icons/change_password.svg',
    'assets/icons/about-us.svg',
    'assets/icons/privacy_policy.svg',
    'assets/icons/terms_conditions.svg',
    'assets/icons/faq.svg',
    'assets/icons/report-problem.svg',
    'assets/icons/log_out.svg',
  ];

  final List<String> options = [
    ConstStrings.themes,
    ConstStrings.profileVisibility,
    ConstStrings.language,
    ConstStrings.savedPosts,
    ConstStrings.notifications,
    ConstStrings.subscriptions,
    ConstStrings.changePassword,
    ConstStrings.aboutUs,
    ConstStrings.privacyPolicy,
    ConstStrings.termsAndConditions,
    ConstStrings.faq,
    ConstStrings.reportProblem,
    ConstStrings.logOut,
  ];

  final List<String> pages = [
    // Replace direct widget instances with route names from AppRout
    // At this point it desnt has 13 items as other list
    // lit has 11 iteam main [index-2]
    // Otherwise it will give us range error
    AppRoutes.language,
    AppRoutes.savedPosts,
    AppRoutes.notificationsPage,
    AppRoutes.subscriptions,
    AppRoutes.updatePasswordPage,
    AppRoutes.aboutUsPage,
    AppRoutes.privacyPolicy,
    AppRoutes.termsAndConditions,
    AppRoutes.faq,
    AppRoutes.reportProblem,
    AppRoutes.logOut,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          CircleAvatar(radius: 40),
          Customtext(
            title: ConstStrings.johnDoe,
            textSize: 18,
            fontWeight: FontWeight.w600,
            textColor: TextColor.colorGreen,
          ),
          customElevatedButton(
            title: ConstStrings.editProfile,
            onPressed: () => Get.toNamed(AppRoutes.editProfilePage),
            height: 32,
            width: 140,
            top: 0,
          ),
          SizedBox(height: 435, width: double.infinity, child: _buildOptions()),
          SizedBox(height: 81),
          _logOutButton(context),
          Spacer(),
        ],
      ),
    );
  }

  Widget _logOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 25),
      child: InkWell(
        onTap: () {
          logOutPopUp(context);
          // Get.toNamed(pages[10]);
        },
        child: Row(
          children: [
            SvgPicture.asset(iconAsset[12]),
            SizedBox(width: 9),
            Customtext(
              title: options[12],
              textSize: 12,
              fontWeight: FontWeight.w600,
            ),
            Spacer(),
            _buildAction(12, pages),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 30, right: 25),
      itemCount: options.length,
      itemBuilder: (context, index) {
        bool flag = (index == 0 || index == 1);
        return InkWell(
          highlightColor: flag ? Colors.transparent : null,
          splashColor: flag ? Colors.transparent : null,
          onTap: () => flag ? null : Get.toNamed(pages[index - 2]),

          child: Row(
            children: [
              SvgPicture.asset(iconAsset[index]),
              SizedBox(width: 9),
              Customtext(
                title: options[index],
                textSize: 12,
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              _buildAction(index, pages),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildAction(int index, List<String> pages) {
  bool flag = index == 0 || index == 1;
  RxBool value = true.obs;

  return SizedBox(
    width: 50,
    height: 37,
    child: Align(
      alignment: AlignmentDirectional.center,
      child:
          flag
              ? Obx(
                () => Transform.scale(
                  scale: .6,
                  child: Switch(
                    value: value.value,
                    onChanged: (bool newValue) {
                      // handle switch change
                      value.value = newValue;
                    },
                  ),
                ),
              )
              : SvgPicture.asset('assets/icons/next.svg'),
      // ),
    ),
  );
}
