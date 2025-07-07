import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompanyDetailsPage extends StatelessWidget {
  const CompanyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 43, right: 20, left: 20),
        child: customElevatedButton(
          title: ConstStrings.sendRequest,
          onPressed: null,
        ),
      ),
      appBar: CustomAppBar(title: ConstStrings.companyDetails),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topImage(),
            _brandName(),
            _address(),
            _ratings(),
            _shortDetails(),
            Customtext(
              title: ConstStrings.officeHour,
              textSize: 16,
              fontWeight: FontWeight.w500,
              bottom: 3,
            ),
            Customtext(
              title: ConstStrings.monFri8Am5Pm,
              textSize: 14,
              textColor: TextColor.colorGreen,
              fontWeight: FontWeight.w500,
            ),
            Customtext(
              title: ConstStrings.companyDescription,
              maxLine: 7,
              textSize: 12,
              textColor: TextColor.colorOffWhite,
              fontWeight: FontWeight.w400,
              top: 8,
            ),
          ],
        ),
      ),
    );
  }

  Padding _shortDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _box('250+', 'Total Trucks'),
          _box('3 Years ', 'Experience'),
          _box('250+', 'Total Employees'),
        ],
      ),
    );
  }

  Wrap _ratings() {
    return Wrap(
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
    );
  }

  Wrap _address() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Transform.scale(
          scale: 1.5,
          child: SvgPicture.asset('assets/icons/mapPin.svg'),
        ),
        Customtext(
          title: ConstStrings.losAngelesCalifornia,
          textSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Customtext _brandName() {
    return Customtext(
      title: ConstStrings.americanTrucking,
      textSize: 24,
      fontWeight: FontWeight.w600,
      textColor: TextColor.colorGreen,
      top: 12,
    );
  }

  Stack _topImage() {
    return Stack(
      children: [
        SizedBox(
          height: 277.41,
          width: double.infinity,
          child: Image.asset(
            'assets/images/comapnyImage3.png',
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
    );
  }

  Widget _box(title, subtitle) {
    return Container(
      height: 70,
      width: 102,
      decoration: BoxDecoration(color: ConstColours.transparentGreen),
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Customtext(
              title: title,
              textSize: 18,
              fontWeight: FontWeight.w600,
              textColor: TextColor.colorGreen,
            ),
            Customtext(
              title: subtitle,
              textSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
