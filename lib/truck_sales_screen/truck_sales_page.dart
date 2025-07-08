import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_gridview.dart';
import 'package:fleet_sync/custom_widgets/custom_search_bar.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';
import 'package:fleet_sync/models/company_truck_abstract.dart';
import 'package:fleet_sync/models/truck_models.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TruckSalesPage extends StatelessWidget {
  TruckSalesPage({super.key});

  final Future<List<FeedItem>> fetchFeedItemsTruk =
      FeedTruckModels().getFeedTruckData();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ConstColours.colorGreen,
            labelColor: ConstColours.colorGreen,
            tabs: [
              Tab(
                child: Customtext(
                  title: ConstStrings.truckSales,
                  textSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Tab(
                child: Customtext(
                  title: ConstStrings.sellPost,
                  textSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          body: TabBarView(children: [_page1(), _page2()]), //_page1(),
        ),
      ),
    );
  }

  Widget _page2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Customtext(
              title: ConstStrings.createAPost,
              top: 9,
              bottom: 21,
              textSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SliverToBoxAdapter(
            child: SvgPicture.asset('assets/icons/uploadPostImage.svg'),
          ),
          SliverToBoxAdapter(
            child: customElevatedButton(
              top: 21,
              title: ConstStrings.createNow,
              onPressed: () => Get.toNamed(AppRoutes.truckSellPostFormPage),
            ),
          ),
          SliverToBoxAdapter(
            child: Customtext(
              title: ConstStrings.postList,
              top: 33,
              bottom: 9,
              textSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          _ownPostlistGridView(),
        ],
      ),
    );
  }

  Widget _page1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomScrollView(
        slivers: [_searchBar(), _truckSalesTitle(), _listGridView()],
      ),
    );
  }

  Widget _ownPostlistGridView() {
    return SliverToBoxAdapter(
      child: CustomGridView<List<FeedItem>>(
        fetchFeedItems: fetchFeedItemsTruk,
        cardMode: CardMode.truck,
        ownPost: true,
        onPressed:
            () => Get.toNamed(
              AppRoutes.truckDetailsPage,
              arguments: {
                'deletePostOnPressed': () {},
                'editPostOnPressed': Get.toNamed(
                  AppRoutes.truckSellPostFormPage,
                ),
                'sendRequestOnPressed': () {},
                'ownPost': true,
              },
            ),
      ),
    );
  }

  Widget _listGridView() {
    return SliverToBoxAdapter(
      child: CustomGridView<List<FeedItem>>(
        fetchFeedItems: fetchFeedItemsTruk,
        cardMode: CardMode.company,
        onPressed:
            () => Get.toNamed(
              AppRoutes.truckDetailsPage,
              arguments: {
                'deletePostOnPressed': () {},
                'editPostOnPressed': () {},
                'sendRequestOnPressed': () {},
                'ownPost': false,
              },
            ),
      ),
    );
  }

  Widget _truckSalesTitle() {
    return SliverToBoxAdapter(
      child: Customtext(
        left: 3,
        title: ConstStrings.truckSales,
        textSize: 18,
        fontWeight: FontWeight.w600,
        top: 16,
      ),
    );
  }
}

Widget _searchBar() {
  return SliverPadding(
    padding: EdgeInsetsDirectional.only(top: 17),
    sliver: SliverAppBar(
      leading: SizedBox(),
      elevation: 0,
      actions: [SizedBox()],
      collapsedHeight: 63,
      flexibleSpace: Row(
        children: [
          CustomSearchBar(
            hintText: ConstStrings.searchHere,
            prefixIcon: SizedBox(child: searchIcon()),
          ),
        ],
      ),
      expandedHeight: 35,
      pinned: false,
    ),
  );
}

Widget searchIcon() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: SvgPicture.asset(
      'assets/icons/search.svg',
      colorFilter: ColorFilter.mode(Colors.white24, BlendMode.srcIn),
    ),
  );
}
