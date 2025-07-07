import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TruckSellPostFormPage extends StatelessWidget {
  const TruckSellPostFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: ConstStrings.createAPost),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(title: ConstStrings.brand),
                CustomTextFormField(title: ConstStrings.model),
                _buildRowForm(
                  leftForm: ConstStrings.manufactureYear,
                  rightForm: ConstStrings.mileage,
                ),
                _buildRowForm(
                  leftForm: ConstStrings.transmissionType,
                  rightForm: ConstStrings.engineType,
                ),
                _buildRowForm(
                  leftForm: ConstStrings.axels,
                  rightForm: ConstStrings.price,
                ),
                CustomTextFormField(title: ConstStrings.condition),
                CustomTextFormField(title: ConstStrings.location),
                CustomTextFormField(title: ConstStrings.onBehalfOf),
                CustomTextFormField(
                  title: ConstStrings.description,
                  maxLine: 4,
                ),
                Customtext(
                  title: ConstStrings.addImage,
                  fontWeight: FontWeight.w400,
                ),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/uploadImage.svg'),
                      SizedBox(height: 12,),
                      SvgPicture.asset('assets/icons/add_Image_Icon.svg'),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
                customElevatedButton(title: ConstStrings.postNow, onPressed: null)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildRowForm({required String leftForm, required String rightForm}) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CustomTextFormField(title: leftForm),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CustomTextFormField(title: rightForm),
          ),
        ),
      ],
    );
  }
}
