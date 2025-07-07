import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_gridview.dart';
import 'package:fleet_sync/custom_widgets/custom_search_bar.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';
import 'package:fleet_sync/models/comapany_models.dart';
import 'package:fleet_sync/models/company_truck_abstract.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final Future<List<FeedItem>> fetchFeedItems =
      FeedCompanyModels().getFeedCompanyData();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [_searchBar(), _popularCompanyTitle(), _listGridView()],
        ),
      ),
    );
  }

  SliverPadding _listGridView() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: CustomGridView<List<FeedItem>>(
          fetchFeedItems: fetchFeedItems,
          cardMode: CardMode.company,
          onPressed: () => Get.toNamed(AppRoutes.companyDetailsPage),
        ),
      ),
    );
  }

  Widget _popularCompanyTitle() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Customtext(
          left: 3,
          title: ConstStrings.popularCompanies,
          textSize: 18,
          fontWeight: FontWeight.w600,
          top: 11,
          bottom: 8,
        ),
      ),
    );
  }
}

SliverPadding _searchBar() {
  return SliverPadding(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
    sliver: SliverAppBar(
      elevation: 0,
      actions: [SizedBox()],
      collapsedHeight: 63,
      flexibleSpace: Align(
        alignment: Alignment.bottomLeft,
        heightFactor: 3.8,
        child: Row(
          children: [
            CustomSearchBar(
              hintText: ConstStrings.searchHere,
              prefixIcon: SizedBox(child: searchIcon()),
            ),
            InkWell(
              child: SvgPicture.asset('assets/icons/tuiningButton.svg'),
              onTap: () => print('Something Press'),
            ),
          ],
        ),
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
