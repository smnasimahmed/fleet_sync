import 'package:fleet_sync/chats_screen/chats_page.dart';
import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/custom_widgets/logo.dart';
import 'package:fleet_sync/drawer_screen/drawer_page.dart';
import 'package:fleet_sync/fuel_card_screen/fuel_card_page.dart';
import 'package:fleet_sync/home_screen/home_page.dart';
import 'package:fleet_sync/list_screen/list_page.dart';
import 'package:fleet_sync/map_screen/map_page.dart';
import 'package:fleet_sync/truck_sales_screen/truck_sales_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  static const double drawerWidth = 290.0;
  @override
  Widget build(BuildContext context) {
    List<String> iconLabel = [
      ConstStrings.home,
      ConstStrings.map,
      ConstStrings.chats,
      ConstStrings.list,
      ConstStrings.truckSales,
      ConstStrings.fuelCard,
    ];
    List<String> icons = [
      'assets/icons/home.svg',
      'assets/icons/map.svg',
      'assets/icons/chats.svg',
      'assets/icons/list.svg',
      'assets/icons/truck_sales.svg',
      'assets/icons/fuel_card.svg',
    ];

    List<Widget> pages = [
      HomePage(),
      MapPage(),
      ChatsPage(),
      ListPage(),
      TruckSalesPage(),
      FuelCardPage(),
    ];

    RxInt selectedIndex = 5.obs;

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: SizedBox(width: drawerWidth, child: DrawerPage()),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Logo(),
          ),
          actions: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Icon(Icons.menu_rounded),
              ),
              onTap: () => scaffoldKey.currentState!.openEndDrawer(),
            ),
          ],
        ),
        bottomNavigationBar: _navbar(iconLabel, icons, selectedIndex),
        body: Obx(
          () => IndexedStack(index: selectedIndex.value, children: pages),
        ),
      ),
    );
  }

  Container _navbar(
    List<String> iconLabel,
    List<String> icons,
    RxInt selectedIndex,
  ) {
    return Container(
      decoration: BoxDecoration(color: ConstColours.appDarktBackGround),
      padding: EdgeInsets.all(5),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(iconLabel.length, (index) {
              return Expanded(
                child: Obx(
                  () => InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          icons[index],
                          colorFilter: ColorFilter.mode(
                            selectedIndex == index
                                ? ConstColours.colorGreen
                                : ConstColours.offWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        Customtext(
                          title: iconLabel[index],
                          textSize: 10,
                          maxLine: 1,

                          fontWeight: FontWeight.w500,
                          textColor:
                              (selectedIndex.value == index)
                                  ? TextColor.colorGreen
                                  : TextColor.colorOffWhite,
                        ),
                      ],
                    ),
                    onTap: () => selectedIndex.value = index,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
