import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_gridview.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';
import 'package:fleet_sync/models/company_truck_abstract.dart';
import 'package:fleet_sync/models/fuel_card_models.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FuelCardPage extends StatelessWidget {
  FuelCardPage({super.key});

  final Future<List<FeedItem>> fetchFeedItems =
      FeedFuelCardModels().getFeedFuelCardData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomScrollView(
            slivers: [
              _topImage(),
              _fuelProviderText(),
              SliverToBoxAdapter(
                child: CustomGridView(
                  fetchFeedItems: fetchFeedItems,
                  cardMode: CardMode.fuel,
                  onPressed: ()=> Get.toNamed(AppRoutes.cardkDetailsPage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fuelProviderText() {
    return SliverToBoxAdapter(
      child: Customtext(
        title: ConstStrings.fuelProvider,
        top: 23,
        bottom: 6,
        textSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  SliverToBoxAdapter _topImage() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            height: 188,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.asset(
                'assets/images/fuel_card_image2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(left: 11, bottom: 10, child: _topImageElevatedButton()),
        ],
      ),
    );
  }

  ElevatedButton _topImageElevatedButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          textStyle: TextStyle(),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: Size(126, 32),
      ),
      child: Text(ConstStrings.getNow),
    );
  }
}
