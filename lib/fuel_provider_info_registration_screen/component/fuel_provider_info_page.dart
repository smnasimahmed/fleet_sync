import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customRadio.dart';
import 'package:fleet_sync/custom_widgets/custom_dropdown_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/controller/radioController.dart';
import 'package:fleet_sync/truck_sell_post_form_screen/controller/upload_Image_Controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:get/get.dart';

class FuelProviderInfoPage extends StatelessWidget {
  const FuelProviderInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadImageControler = Get.find<UploadImageControler>();
    final radioController = Get.find<RadioController>();
    List<DropdownMenuItem<int>> cityList = [
      DropdownMenuItem(value: 0, child: Text('  State 1')),
      DropdownMenuItem(value: 1, child: Text('  State 2')),
      DropdownMenuItem(value: 2, child: Text('  State 3')),
      DropdownMenuItem(value: 3, child: Text('  State 4')),
      DropdownMenuItem(value: 4, child: Text('  State 5')),
    ];
    List<DropdownMenuItem<int>> truckStopsList = [
      DropdownMenuItem(value: 0, child: Text('  Supported Truck Stops 1')),
      DropdownMenuItem(value: 1, child: Text('  Supported Truck Stops 2')),
      DropdownMenuItem(value: 2, child: Text('  Supported Truck Stops 3')),
      DropdownMenuItem(value: 3, child: Text('  Supported Truck Stops 4')),
      DropdownMenuItem(value: 4, child: Text('  Supported Truck Stops 5')),
    ];
    List<DropdownMenuItem<int>> languagePreferences = [
      DropdownMenuItem(value: 0, child: Text('  Language Preferences 1')),
      DropdownMenuItem(value: 1, child: Text('  Language Preferences 2')),
      DropdownMenuItem(value: 2, child: Text('  Language Preferences 3')),
      DropdownMenuItem(value: 3, child: Text('  Language Preferences 4')),
      DropdownMenuItem(value: 4, child: Text('  Language Preferences 5')),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtext(
          title: ConstStrings.personalInformation,
          textColor: TextColor.colorGreen,
          textSize: 18,
          fontWeight: FontWeight.w600,
          bottom: 5,
        ),
        Text(ConstStrings.uploadPhoto),
        Center(
          child: GestureDetector(
            onTap: () {
              // uploadImageControler.requestStorageAndCameraPermissions();
              uploadImageControler.requestPhotosPermissionAndPick(
                isSingleImage: true,
              );
            },
            child: SvgPicture.asset(
              'assets/icons/uploadImage.svg',
              height: 95,
              width: 98,
            ),
          ),
        ),
        CustomTextFormField(title: ConstStrings.fuelCardName),
        CustomTextFormField(title: ConstStrings.fuelCompanyName),
        CustomDropdownFormField(
          title: ConstStrings.supportedTruckStops,
          list: truckStopsList,
        ),

        CustomTextFormField(title: ConstStrings.address),
        _cityState(cityList),
        CustomTextFormField(title: ConstStrings.email),
        CustomTextFormField(title: ConstStrings.phone, numaric: true),
        CustomTextFormField(title: ConstStrings.website),
        CustomTextFormField(title: ConstStrings.averageWeeklyDiscount),
        Text(ConstStrings.creditLineAvailability),
        _creditLine(radioController),
        CustomDropdownFormField(
          title: ConstStrings.languagePreferences,
          list: languagePreferences,
        ),
        CustomTextFormField(title: ConstStrings.description, maxLine: 3),
      ],
    );
  }

  Row _cityState(List<DropdownMenuItem<int>> list) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 9.5),
            child: CustomTextFormField(title: ConstStrings.city),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 9.5),
            child: CustomDropdownFormField(
              title: ConstStrings.state,
              list: list,
            ),
          ),
        ),
      ],
    );
  }

  Widget _creditLine(RadioController radioController) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: CustomRadio<CreditLine>(
              title: Customtext(
                title: ConstStrings.yes,
                textColor: TextColor.colorWhite,
              ),
              value: CreditLine.yes,
              groupValue:
                  radioController.selectedCreditLine.value ?? CreditLine.no,
              onChanged: radioController.setselectedCreditLine,
            ),
          ),

          Flexible(
            flex: 1,
            child: CustomRadio<CreditLine>(
              title: Customtext(
                title: ConstStrings.no,
                textColor: TextColor.colorWhite,
              ),
              value: CreditLine.no,
              groupValue:
                  radioController.selectedCreditLine.value ?? CreditLine.no,
              onChanged: radioController.setselectedCreditLine,
            ),
          ),
        ],
      );
    });
  }
}
