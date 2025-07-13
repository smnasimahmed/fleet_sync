import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_dropdown_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/truck_sell_post_form_screen/controller/upload_Image_Controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:get/get.dart';

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadImageControler = Get.find<UploadImageControler>();
    List<DropdownMenuItem<int>> cityList = [
      DropdownMenuItem(value: 0, child: Text('  State 1')),
      DropdownMenuItem(value: 1, child: Text('  State 2')),
      DropdownMenuItem(value: 2, child: Text('  State 3')),
      DropdownMenuItem(value: 3, child: Text('  State 4')),
      DropdownMenuItem(value: 4, child: Text('  State 5')),
    ];
    List<DropdownMenuItem<int>> transportationType = [
      DropdownMenuItem(value: 0, child: Text('  Transportation type 1')),
      DropdownMenuItem(value: 1, child: Text('  Transportation type 2')),
      DropdownMenuItem(value: 2, child: Text('  Transportation type 3')),
      DropdownMenuItem(value: 3, child: Text('  Transportation type 4')),
      DropdownMenuItem(value: 4, child: Text('  Transportation type 5')),
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
        CustomTextFormField(title: ConstStrings.companyName),
        CustomTextFormField(title: ConstStrings.dotNumber, numaric: true),
        CustomTextFormField(title: ConstStrings.mcNumber, numaric: true),

        CustomTextFormField(title: ConstStrings.address),
        _cityState(cityList),
        CustomTextFormField(title: ConstStrings.email),
        CustomTextFormField(title: ConstStrings.phone, numaric: true),
        CustomTextFormField(title: ConstStrings.website, numaric: true),
        CustomDropdownFormField(
          title: ConstStrings.transportationType,
          list: transportationType,
        ),
        CustomDropdownFormField(
          title: ConstStrings.languagePreferences,
          list: languagePreferences,
        ),
        CustomTextFormField(title: ConstStrings.description, maxLine: 5),
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
}
