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

class DriverPersonalInfoPage extends StatelessWidget {
  // final RadioController controller;
  const DriverPersonalInfoPage({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RadioController>();
    // final controller =  Get.put(RadioController());
    final uploadImageControler = Get.find<UploadImageControler>();
    List<DropdownMenuItem<int>> list = [
      DropdownMenuItem(value: 0, child: Text('CDL Types 1')),
      DropdownMenuItem(value: 1, child: Text('CDL Types 2')),
      DropdownMenuItem(value: 2, child: Text('CDL Types 3')),
      DropdownMenuItem(value: 3, child: Text('CDL Types 4')),
      DropdownMenuItem(value: 4, child: Text('CDL Types 5')),
    ];
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
          CustomTextFormField(title: ConstStrings.fullName),
          CustomTextFormField(title: ConstStrings.phone, numaric: true),
          CustomTextFormField(title: ConstStrings.email),
          _genderDOBform(),
          CustomTextFormField(title: ConstStrings.address),
          CustomTextFormField(title: ConstStrings.languagePreferences),
          Customtext(
            title: ConstStrings.professionalInformation,
            textColor: TextColor.colorGreen,
            textSize: 18,
            fontWeight: FontWeight.w600,
            top: 12,
            bottom: 6,
          ),
          Text(ConstStrings.driverOrOwnerOpertor),
          ownerOperator(controller),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(ConstStrings.ownATrailer),
          ),
          ownTrailer(controller),
          _workExperience(),
          CustomTextFormField(
            title: ConstStrings.accidentsOrViolationsRecordLast2Years,
          ),
          CustomTextFormField(title: ConstStrings.previousCompany),
          CustomDropdownFormField(title: ConstStrings.cdlTypes, list: list),
          Text(ConstStrings.tEndorsement),
          _tEndoursement(controller),
          SizedBox(
            height: 118,
            child: CustomTextFormField(title: ConstStrings.description),
          ),
        ],
      ),
    );
  }
}

Row _tEndoursement(RadioController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: CustomRadio<TEndoursement>(
          title: Customtext(
            title: ConstStrings.yes,
            textColor: TextColor.colorWhite,
          ),
          value: TEndoursement.yes,
          groupValue:
              controller.selectedTEndousement.value ?? TEndoursement.yes,
          onChanged: controller.setselectedTEndousement,
        ),
      ),

      Flexible(
        flex: 1,
        child: CustomRadio<TEndoursement>(
          title: Customtext(
            title: ConstStrings.no,
            textColor: TextColor.colorWhite,
          ),
          value: TEndoursement.no,
          groupValue:
              controller.selectedTEndousement.value ?? TEndoursement.yes,
          onChanged: controller.setselectedTEndousement,
        ),
      ),
    ],
  );
}

Row _workExperience() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(right: 9.5),
          child: CustomTextFormField(
            title: ConstStrings.workExperience,
            hintText: 'Months',
            numaric: true,
          ),
        ),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 9.5),
          child: CustomTextFormField(
            title: '',
            hintText: 'Years',
            numaric: true,
          ),
        ),
      ),
    ],
  );
}

Widget _genderDOBform() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(right: 9.5),
          child: CustomTextFormField(title: ConstStrings.gender),
        ),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 9.5),
          child: CustomTextFormField(title: ConstStrings.dateOfBirth),
        ),
      ),
    ],
  );
}

Row ownTrailer(RadioController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: CustomRadio(
          title: Customtext(
            title: ConstStrings.yes,
            textColor: TextColor.colorWhite,
          ),
          value: OwnATrailer.yes,
          groupValue: controller.selectedTrailerOption.value ?? OwnATrailer.yes,
          onChanged: controller.setSelectedOptionOwnATrailer,
        ),
      ),

      Flexible(
        flex: 1,
        child: CustomRadio(
          title: Customtext(
            title: ConstStrings.no,
            textColor: TextColor.colorWhite,
          ),
          value: OwnATrailer.no,
          groupValue: controller.selectedTrailerOption.value ?? OwnATrailer.yes,
          onChanged: controller.setSelectedOptionOwnATrailer,
        ),
      ),
    ],
  );
}

Row ownerOperator(RadioController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: CustomRadio<DriverOwner>(
          title: Customtext(
            title: ConstStrings.ownerOperator,
            textColor: TextColor.colorWhite,
          ),
          value: DriverOwner.yes,
          groupValue:
              controller.selectedOperationOption.value ?? DriverOwner.no,
          onChanged: controller.setSelectedDriverOwner,
        ),
      ),

      Flexible(
        flex: 1,
        child: CustomRadio<DriverOwner>(
          title: Customtext(
            title: ConstStrings.companyDriver,
            textColor: TextColor.colorWhite,
          ),
          value: DriverOwner.no,
          groupValue:
              controller.selectedOperationOption.value ?? DriverOwner.no,
          onChanged: controller.setSelectedDriverOwner,
        ),
      ),
    ],
  );
}
