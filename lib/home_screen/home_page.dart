import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_search_bar.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';
import 'package:fleet_sync/home_screen/components/sliverListView.dart';
import 'package:fleet_sync/models/comapany_models.dart';
import 'package:fleet_sync/models/truck_models.dart';
import 'package:fleet_sync/scroll_unfocus_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const double drawerWidth = 290.0;


  final List<String> serviceName = [
    ConstStrings.dispatchService,
    ConstStrings.eldService,
    ConstStrings.timestampCamera,
    ConstStrings.tandemSlideCalculate,
    ConstStrings.cldPrepTests,
    ConstStrings.aiAssistant,
  ];
  final List<String> serviceIcons = [
    'assets/icons/dispatchService.svg',
    'assets/icons/eldService.svg',
    'assets/icons/timeStampCamera.svg',
    'assets/icons/tandemSlideCalculate.svg',
    'assets/icons/cldPrepTests.svg',
    'assets/icons/aiAssistant.svg',
  ];

  final feedTruck = FeedTruckModels().getFeedTruckData;
  final feedCompany = FeedCompanyModels().getFeedCompanyData;

  @override
  Widget build(BuildContext context) {
    // final truckList = TruckModels().getTruckData();
    // final comapnyList = CompanyModels().getCompanyData(); // Will Pass it later

  // final ScrollUnfocus controller = Get.find<ScrollUnfocus>();

    return SafeArea(
        child: ScrollUnfocusWrapper(
          child: CustomScrollView(
            // controller:controller.scrollController,
            slivers: [
              _searchBar(),
              _gridView(),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              _popularcompanyText(),
              _popularComapanyList(),
              SliverToBoxAdapter(child: SizedBox(height: 40)),
              SliverToBoxAdapter(child: _cardChoose()),
              _truckSaleText(),
              _trucSaleList(),
            ],
          ),
        ),

    );
  }

  SliverPadding _trucSaleList() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
      sliver: CustomListview(
        cardMode: CardMode.truck,
        fetchFeedItems: feedTruck,
        onPressed: () {},
        bookMarkonTap: () {},
        shareOntap: () {},
      ),
    );
  }

  SliverPadding _truckSaleText() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Customtext(
          title: ConstStrings.truckSales,
          textSize: 18,
          fontWeight: FontWeight.w600,
          top: 33,
          bottom: 18,
        ),
      ),
    );
  }

  SliverPadding _popularComapanyList() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
      sliver: CustomListview(
        cardMode: CardMode.company,
        fetchFeedItems: feedCompany,
        onPressed: () {},
        bookMarkonTap: () {},
      ),
    );
  }

  SliverPadding _popularcompanyText() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Customtext(
          title: ConstStrings.popularCompanies,
          textSize: 18,
          fontWeight: FontWeight.w600,
          bottom: 11,
        ),
      ),
    );
  }

  SliverPadding _gridView() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: _buildFeatureGrid(
          serviceName: serviceName,
          serviceIcons: serviceIcons,
        ),
      ),
    );
  }

  SliverPadding _searchBar() {
    return SliverPadding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
      sliver: SliverAppBar(
        elevation: 0,
              leading: SizedBox(),
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

  SizedBox _cardChoose() {
    return SizedBox(
      height: 185,
      // width: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/card_image.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: 53,
            right: 20,
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 7,
                bottom: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                ConstStrings.yourFuelCard,
                style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 37,
            right: 20,
            child: customElevatedButton(
              title: ConstStrings.chooseYourCard,
              fontSize: 12,
              onPressed: () {},
              height: 32,
              width: 50,
            ),
          ),
        ],
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

  Widget _buildFeatureGrid({
    required List<String> serviceName,
    required List<String> serviceIcons,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtext(
          title: ConstStrings.upcomingFeatures,
          textSize: 18,
          fontWeight: FontWeight.w600,
          top: 10,
        ),
        GridView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            childAspectRatio: 3,
          ),
          itemCount: serviceName.length,
          itemBuilder: (context, index) {
            return _featureGrid(
              serviceName: serviceName[index],
              serviceIcons: serviceIcons[index],
            );
          },
        ),
      ],
    );
  }

  Widget _featureGrid({
    required String serviceName,
    required String serviceIcons,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          serviceIcons,
          colorFilter: ColorFilter.mode(
            ConstColours.colorGreen,
            BlendMode.srcIn,
          ),
        ),
        Customtext(
          title: serviceName,
          textSize: 14,
          fontWeight: FontWeight.w600,
          left: 10,
          top: 10,
          right: 10,
          bottom: 10,
        ),
      ],
    );
  }
}
