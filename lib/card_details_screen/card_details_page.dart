import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double boxWidth = screenWidth * 0.28; // 25% of screen width

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 43, right: 20, left: 20),
        child: customElevatedButton(
          title: ConstStrings.sendRequest,
          onPressed: null,
        ),
      ),
      appBar: CustomAppBar(title: ConstStrings.truckDetails),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topImage(),
              _brandName(),
              Customtext(
                title: ConstStrings.companyDescription,
                maxLine: 7,
                textSize: 12,
                textColor: TextColor.colorOffWhite,
                fontWeight: FontWeight.w400,
                top: 8,
              ),
              _ratings(),
              _details(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Customtext(
                  title: ConstStrings.companyDescription,
                  maxLine: 7,
                  textSize: 12,
                  textColor: TextColor.colorOffWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _details() {
    return Wrap(
      direction: Axis.vertical,
      spacing: 8,
      children: [
        _detail(ConstStrings.bulletinCardType, ' Fleet Card'),
        _detail(
          ConstStrings.bulletinAcceptedFuelStations,
          ' Shell, BP, ExxonMobil',
        ),
        _detail(
          ConstStrings.bulletinDiscountsAndOffers,
          'up to 5% fuel discount, cashback offers, fleet rewards',
        ),
        _detail(ConstStrings.bulletinCreditLine, '\$10,000 credit'),
        _detail(ConstStrings.bulletinCardCompanyName, 'FuelFast Inc.'),
        _detail(ConstStrings.bulletinLocation, ' Los Angels,Chicago'),
      ],
    );
  }

  Widget _detail(heading, info) {
    return Row(
      children: [
        Customtext(title: heading, fontWeight: FontWeight.w400, textSize: 12),
        Customtext(
          title: info,
          fontWeight: FontWeight.w400,
          textSize: 12,
          textColor: TextColor.colorGreen,
        ),
      ],
    );
  }

  Widget _ratings() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        spacing: 2,
        children: [
          SvgPicture.asset('assets/icons/stars.svg'),
          Customtext(
            title: '4.8',
            textColor: TextColor.colorGreen,
            textSize: 12,
            fontWeight: FontWeight.w400,
          ),
          Customtext(
            title: ConstStrings.reviews,
            textSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Customtext _brandName() {
    return Customtext(
      title: ConstStrings.fuelFastPlusCard,
      textSize: 24,
      textColor: TextColor.colorGreen,
      fontWeight: FontWeight.w600,
      top: 12,
    );
  }

  Widget _topImage() {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: Stack(
        children: [
          SizedBox(
            height: 277.41,
            width: double.infinity,
            child: Image.asset(
              'assets/images/fuel_card_image.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            right: 9,
            top: 9,
            child: SvgPicture.asset('assets/icons/bookMark.svg'),
          ),
          Positioned(
            right: 9,
            top: 48,
            child: SvgPicture.asset('assets/icons/share.svg'),
          ),
        ],
      ),
    );
  }
}
