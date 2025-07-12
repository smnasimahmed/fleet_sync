import 'package:fleet_sync/inbox_screen/inbox_page.dart';
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
import 'package:get_storage/get_storage.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});

  static const double drawerWidth = 290.0;
  final role = GetStorage();
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
      InboxPage(),
      ListPage(),
      TruckSalesPage(),
      FuelCardPage(),
    ];

    RxInt selectedIndex = 4.obs;

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        endDrawer: SizedBox(width: drawerWidth, child: DrawerPage()),
        appBar: AppBar(
          leading: SizedBox(),
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
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Future.doWhile(() async {
                  await Future.delayed(
                    const Duration(milliseconds: 16),
                  ); // one frame
                  if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
                    return true; // keep waiting
                  }
                  scaffoldKey.currentState!.openEndDrawer();
                  return false; // stop loop
                });
              },
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

  Widget _navbar(
    List<String> iconLabel,
    List<String> icons,
    RxInt selectedIndex,
  ) {
    return Container(
      height: 64,
      decoration: BoxDecoration(color: ConstColours.appDarktBackGround),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(iconLabel.length, (index) {
          // return
          if (role.read('role') == 2 ||
              role.read('role') == 3 ||
              role.read('role') == 4) {
            if (index == 3 || index == 5) {
              return SizedBox();
            } else {
              return _generateItem(icons, index, selectedIndex, iconLabel);
            }
          } else {
            return _generateItem(icons, index, selectedIndex, iconLabel);
          }
        }),
      ),
    );
  }

  Expanded _generateItem(
    List<String> icons,
    int index,
    RxInt selectedIndex,
    List<String> iconLabel,
  ) {
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
  }
}
