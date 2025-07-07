import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PopularCompanyCard extends StatelessWidget {
  final String title;
  final String location;
  final String? ratings;
  final String? brand;
  final String? model;
  final CardMode cardMode;
  final void Function() onPressed;
  final void Function() bookMarkonTap;
  final void Function()? shareOntap;

  const PopularCompanyCard({
    super.key,
    required this.title,
    required this.location,
    this.ratings,
    this.brand,
    this.model,
    required this.cardMode,
    required this.onPressed, required this.bookMarkonTap, this.shareOntap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 161,
      decoration: BoxDecoration(
        border: Border.all(color: ConstColours.gray, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardImage(),
                CardTitle(title: title),
                _cardLocation(isDark: isDark, location: location),
                AfterLocation(
                  isDark: isDark,
                  cardMode: cardMode,
                  brand: brand,
                  model: model,
                ),
                _companyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardImage() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/companyImage1.png',
          height: 107,
          // width: 144,
          fit: BoxFit.fill,
        ),
        Positioned(
          height: 16,
          width: 16,
          right: 4,
          top: 3,
          child: InkWell(onTap: bookMarkonTap,child: SvgPicture.asset('assets/icons/bookMark.svg'),),
        ),
        (cardMode == CardMode.truck)
            ? Positioned(
              height: 16,
              width: 16,
              right: 4,
              top: 24,
              child: InkWell(onTap: shareOntap,child: SvgPicture.asset('assets/icons/share.svg'),),
            )
            : SizedBox(),
      ],
    );
  }

  Widget _companyButton() {
    return customElevatedButton(
      title: ConstStrings.viewDetails,
      onPressed: onPressed,
      height: 32,
      fontSize: 12,
      width: 144,
      top: 0,
    );
  }
}

enum CardMode { company, truck, fuel }

class CardTitle extends StatelessWidget {
  final String title;
  const CardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Customtext(
      maxLine: 1,
      title: title,
      textSize: 14,
      fontWeight: FontWeight.w500,
      textColor: TextColor.colorGreen,
      top: 4,
      bottom: 2,
    );
  }
}

class AfterLocation extends StatelessWidget {
  final CardMode cardMode;
  final String? brand;
  final String? model;
  const AfterLocation({
    super.key,
    required this.isDark,
    required this.cardMode,
    this.brand,
    this.model,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? ConstColours.gray : ConstColours.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.36, vertical: 3.5),
        child:
            (cardMode == CardMode.company || cardMode == CardMode.fuel) ? _companyRatings() : _truckBrand(),
      ),
    );
  }

  Wrap _truckBrand() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Customtext(
          title: brand ?? 'NO DATA',
          textSize: 10,
          fontWeight: FontWeight.w500,
          textColor: TextColor.colorWhite,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: SvgPicture.asset('assets/icons/cityStateDevider.svg'),
        ),
        SizedBox(width: 2),
        Customtext(
          title: model ?? 'NO DATA',
          textSize: 10,
          fontWeight: FontWeight.w500,
          textColor: TextColor.colorWhite,
        ),
      ],
    );
  }

  Wrap _companyRatings() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/star.svg'),
        SizedBox(width: 2),
        Customtext(
          title: '4.8(45)',
          textSize: 10,
          fontWeight: FontWeight.w500,
          textColor: TextColor.colorWhite,
        ),
      ],
    );
  }
}

Widget _cardLocation({required bool isDark, required String location}) {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      SvgPicture.asset('assets/icons/mapPin.svg'),
      Customtext(
        title: location,
        textSize: 10,
        fontWeight: FontWeight.w500,
        textColor: isDark ? TextColor.colorOffWhite : TextColor.colorBlack,
        bottom: 4,
      ),
    ],
  );
}
