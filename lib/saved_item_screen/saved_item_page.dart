import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_gridview.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';
import 'package:fleet_sync/models/company_truck_abstract.dart';
import 'package:fleet_sync/models/truck_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedItemPage extends StatelessWidget {
  SavedItemPage({super.key});

  final RxBool isSelected = false.obs;
  final RxInt tab = 0.obs;
  final Future<List<FeedItem>> fetchFeedItems =
      FeedTruckModels().getFeedTruckData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: false,
      left: false,
      child: Scaffold(
        appBar: CustomAppBar(title: ConstStrings.savedItems),
        body: CustomScrollView(
          slivers: [
            Obx(
              () => SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: _topSwitchText(),
                ),
                pinned: true,
                expandedHeight: 80,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: CustomGridView<List<FeedItem>>(
                  fetchFeedItems: fetchFeedItems,
                  cardMode: CardMode.truck,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSwitchText() {
    return Column(children: [_tabName()]);
  }

  Row _tabName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Customtext(
            title: ConstStrings.truckSales,
            textSize: 18,
            fontWeight: FontWeight.w600,
            textColor:
                isSelected.value
                    ? TextColor.colorGreen
                    : TextColor.colorOffWhite,
          ),
          onTap: () {
            if (tab.value == 0) {
              isSelected.value = true;
              tab.value = 1;
            }
          },
        ),
        GestureDetector(
          child: Customtext(
            title: ConstStrings.fuelProvider,
            textSize: 18,
            fontWeight: FontWeight.w600,
            textColor:
                isSelected.value
                    ? TextColor.colorOffWhite
                    : TextColor.colorGreen,
          ),
          onTap: () {
            if (tab.value == 1) {
              isSelected.value = false;
              tab.value = 0;
            }
          },
        ),
      ],
    );
  }
}
