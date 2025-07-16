import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_search_bar.dart';
import 'package:fleet_sync/drawer_screen/drawer_page.dart';
import 'package:fleet_sync/map_screen/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const double drawerWidth = 290.0;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  // final MapService mapService = const MapService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SizedBox(width: drawerWidth, child: DrawerPage()),
      body: SafeArea(
        child: Column(
          children: [
            // _appbar(),
            _search(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  customElevatedButton(
                    top: 0,
                    title: ConstStrings.destination,
                    onPressed: () {
                      
                    },
                    height: 32,
                    width: 118,
                  ),
                  Spacer(),
                  SvgPicture.asset('assets/icons/location_pin_button_icon.svg'),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/icons/service_man_button_icon.svg'),
                ],
              ),
            ),
            Expanded(child: MapService()),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            CustomSearchBar(
              hintText: 'From: ',// ConstStrings.searchHere,
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
            CustomSearchBar(
              hintText: 'To',// ConstStrings.searchHere,
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
    );
  }

  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
