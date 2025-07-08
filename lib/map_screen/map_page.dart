import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_search_bar.dart';
// import 'package:fleet_sync/custom_widgets/logo.dart';
import 'package:fleet_sync/drawer_screen/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const double drawerWidth = 290.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      endDrawer: SizedBox(width: drawerWidth, child: DrawerPage()),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // _appbar(),
            _search(),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    customElevatedButton(
                      top: 0,
                      title: ConstStrings.destination,
                      onPressed: () {},
                      height: 32,
                      width: 118,
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      'assets/icons/location_pin_button_icon.svg',
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/service_man_button_icon.svg',
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Image.asset(
                'assets/images/mapDummyImage.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List<Widget> _generatingButton(bool isDark) {
  //   return List.generate(navBarController.roles.length, (index) {
  //     final isSelected = navBarController.selectedIndex.value == index;

  //     return Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 6),
  //       child: _roleButton(index, isDark, isSelected),
  //     );
  //   });
  // }

  SliverPadding _search() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      sliver: SliverAppBar(
        leading: SizedBox(),
        // backgroundColor: ConstColours.appDarktBackGround,
        elevation: 0,
        collapsedHeight: 63,
        actions: [SizedBox()],
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          heightFactor: 3.8,
          child: Row(
            children: [
              CustomSearchBar(
                hintText: ConstStrings.searchHere,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    colorFilter: ColorFilter.mode(
                      ConstColours.colorGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        expandedHeight: 35,
        pinned: false,
      ),
    );
  }

  // SliverPadding _appbar() {
  //   return SliverPadding(
  //     padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
  //     sliver: SliverAppBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       collapsedHeight: 63,
  //       flexibleSpace: Logo(),
  //       expandedHeight: 35,
  //       pinned: true,
  //     ),
  //   );
  // }

  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
