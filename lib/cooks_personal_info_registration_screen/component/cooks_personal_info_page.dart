import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customRadio.dart';
import 'package:fleet_sync/custom_widgets/custom_dropdown_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/driver_personal_info_registration_screen/controller/radioController.dart';
import 'package:fleet_sync/truck_sell_post_form_screen/controller/upload_Image_Controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CooksPersonalInfoPage extends StatelessWidget {
  // final RadioController controller;
  const CooksPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> cityList = [
      DropdownMenuItem(value: 0, child: Text('  State 1')),
      DropdownMenuItem(value: 1, child: Text('  State 2')),
      DropdownMenuItem(value: 2, child: Text('  State 3')),
      DropdownMenuItem(value: 3, child: Text('  State 4')),
      DropdownMenuItem(value: 4, child: Text('  State 5')),
    ];

    List<DropdownMenuItem<int>> languagePreferences = [
      DropdownMenuItem(value: 0, child: Text('  Language Preferences 1')),
      DropdownMenuItem(value: 1, child: Text('  Language Preferences 2')),
      DropdownMenuItem(value: 2, child: Text('  Language Preferences 3')),
      DropdownMenuItem(value: 3, child: Text('  Language Preferences 4')),
      DropdownMenuItem(value: 4, child: Text('  Language Preferences 5')),
    ];

    final controller = Get.find<RadioController>();
    // final controller =  Get.put(RadioController());
    final uploadImageControler = Get.find<UploadImageControler>();

    return Obx(
      () => Column(
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
          _firstAndLastName(),
          CustomTextFormField(title: ConstStrings.foodServiceName),
          CustomTextFormField(title: ConstStrings.typesOfCuisines),
          Text(ConstStrings.doYouHavePhysicalRepairShop),
          _physicalRepair(controller),
          Text(ConstStrings.doYouOfferMobileAssistance),
          _mobileAssistant(controller),
          CustomTextFormField(title: ConstStrings.address),
          _cityState(cityList),
          CustomTextFormField(title: ConstStrings.email),
          CustomTextFormField(title: ConstStrings.phone, numaric: true),
          CustomTextFormField(title: ConstStrings.website),
          CustomDropdownFormField(
            title: ConstStrings.languagePreferences,
            list: languagePreferences,
          ),
          CustomTextFormField(title: ConstStrings.description, maxLine: 5),
          _uploadCirtificate(),
        ],
      ),
    );
  }
}

Padding _uploadCirtificate() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ConstStrings.uploadYourCertificate),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: TextFormField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                // TODO: Make Click Able
                child: SvgPicture.asset('assets/icons/uploadButton.svg'),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
              errorStyle: TextStyle(color: Colors.red),
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    ),
  );
}

Widget _firstAndLastName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(right: 9.5),
          child: CustomTextFormField(title: ConstStrings.firstName),
        ),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 9.5),
          child: CustomTextFormField(title: ConstStrings.lastName),
        ),
      ),
    ],
  );
}

Row _physicalRepair(RadioController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: CustomRadio<PhysicalRepair>(
          title: Customtext(
            title: ConstStrings.yes,
            textColor: TextColor.colorWhite,
          ),
          value: PhysicalRepair.yes,
          groupValue:
              controller.selectedPhysicalRepair.value ?? PhysicalRepair.no,
          onChanged: controller.setselectedPhysicalRepair,
        ),
      ),

      Flexible(
        flex: 1,
        child: CustomRadio<PhysicalRepair>(
          title: Customtext(
            title: ConstStrings.no,
            textColor: TextColor.colorWhite,
          ),
          value: PhysicalRepair.no,
          groupValue:
              controller.selectedPhysicalRepair.value ?? PhysicalRepair.no,
          onChanged: controller.setselectedPhysicalRepair,
        ),
      ),
    ],
  );
}

Row _mobileAssistant(RadioController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: CustomRadio<MobileAssistant>(
          title: Customtext(
            title: ConstStrings.yes,
            textColor: TextColor.colorWhite,
          ),
          value: MobileAssistant.yes,
          groupValue:
              controller.selectedMobileAssistant.value ?? MobileAssistant.no,
          onChanged: controller.setselectedMobileAssistant,
        ),
      ),

      Flexible(
        flex: 1,
        child: CustomRadio<MobileAssistant>(
          title: Customtext(
            title: ConstStrings.no,
            textColor: TextColor.colorWhite,
          ),
          value: MobileAssistant.no,
          groupValue:
              controller.selectedMobileAssistant.value ?? MobileAssistant.no,
          onChanged: controller.setselectedMobileAssistant,
        ),
      ),
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
          child: CustomDropdownFormField(title: ConstStrings.state, list: list),
        ),
      ),
    ],
  );
}
