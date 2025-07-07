import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/truck_details_screen/truc_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TruckDetailsPage extends StatelessWidget {

  const TruckDetailsPage({super.key,});

  @override
  Widget build(BuildContext context) {
    // final Function deletePostOnPressed = Get.arguments['deletePostOnPressed'];
    // final  Function editPostOnPressed = Get.arguments['editPostOnPressed'];
    // final Function sendRequestOnPressed = Get.arguments['sendRequestOnPressed'];
    
      final TruckDetailsController controller = Get.find<TruckDetailsController>();
      final bool? ownPost = Get.arguments['ownPost'];

    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth = screenWidth * 0.28; // 25% of screen width

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 43, right: 20, left: 20),
        child:
            (ownPost == false)
                ? customElevatedButton(
                  title: ConstStrings.sendRequest,
                  onPressed: ()=>controller.sendRequest(),
                )
                : Row(
                  children: [
                    Expanded(
                      child: customElevatedButton(
                        title: ConstStrings.deletePost,
                        color: ConstColours.red,
                        onPressed: () => controller.deletePost(),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: customElevatedButton(
                        title: ConstStrings.editPost,
                        onPressed: () => controller.editPost(),
                      ),
                    ),
                  ],
                ),
      ),
      appBar: CustomAppBar(title: ConstStrings.truckDetails),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shortDetails(boxWidth),
                  _brandName(),
                  _address(),
                  Customtext(
                    title: ConstStrings.companyDescription,
                    maxLine: 7,
                    textSize: 12,
                    textColor: TextColor.colorOffWhite,
                    fontWeight: FontWeight.w400,
                    top: 8,
                  ),
                  _price(),
                  _details(),
                  _truckOwnerDetails(),
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
          ],
        ),
      ),
    );
  }

  Widget _truckOwnerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtext(
          title: ConstStrings.ownerOfTheTruck,
          fontWeight: FontWeight.w400,
          textSize: 12,
          top: 12,
          bottom: 2,
        ),
        Wrap(
          spacing: 4,
          direction: Axis.horizontal,
          children: [
            CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image.asset('assets/images/person_image2.png'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Customtext(
                  title: 'Samuel Hasan',
                  fontWeight: FontWeight.w400,
                  textSize: 16,
                  textColor: TextColor.colorGreen,
                ),
                Customtext(
                  title: ConstStrings.owner,
                  fontWeight: FontWeight.w400,
                  textSize: 12,
                  textColor: TextColor.colorOffWhite,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _details() {
    return Wrap(
      direction: Axis.vertical,
      spacing: 8,
      children: [
        _detail(ConstStrings.buletinModelName, 'Cascadia, 579, T680'),
        _detail(ConstStrings.buletinBrandName, 'Peterbilt'),
        _detail(ConstStrings.buletinManufacturerYear, '2020'),
        _detail(ConstStrings.buletinMileage, '450,000 miles'),
        _detail(ConstStrings.buletinTransmissionType, '450,000 miles'),
        _detail(ConstStrings.buletinEngineType, '450,000 miles'),
        _detail(ConstStrings.buletinCondition, '450,000 miles'),
        _detail(ConstStrings.buletinAxells, '450,000 miles'),
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

  Widget _price() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(color: ConstColours.transparentGreen),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Customtext(
                title: ConstStrings.price,
                fontWeight: FontWeight.w500,
                textSize: 16,
              ),
              Customtext(
                title: ConstStrings.priceNumber,
                fontWeight: FontWeight.w500,
                textSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _shortDetails(double boxWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _box('assets/images/truck1.png', boxWidth),
          // Gap(12),
          _box('assets/images/truck2.png', boxWidth),
          // Gap(12),
          _box('assets/images/truck3.png', boxWidth),
        ],
      ),
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
          child: SvgPicture.asset(
            'assets/icons/mapPin.svg',
            colorFilter: ColorFilter.mode(
              ConstColours.offWhite,
              BlendMode.srcIn,
            ),
          ),
        ),
        Customtext(
          title: ConstStrings.losAngelesCalifornia,
          textSize: 16,
          fontWeight: FontWeight.w400,
          textColor: TextColor.colorOffWhite,
        ),
      ],
    );
  }

  Customtext _brandName() {
    return Customtext(
      title: ConstStrings.peterbilt579,
      textSize: 24,
      textColor: TextColor.colorGreen,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _topImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      child: Stack(
        children: [
          SizedBox(
            height: 277.41,
            width: double.infinity,
            child: Image.asset(
              'assets/images/truck4.png',
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

  Widget _box(String assetName, double boxWidth) {
    return SizedBox(
      height: 72,
      width: boxWidth,
      child: Image.asset(assetName, fit: BoxFit.fitWidth),
    );
  }
}
