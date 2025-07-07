import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TruckInfoFormBody extends StatelessWidget {
  const TruckInfoFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtext(
          title: ConstStrings.truckInformation,
          textColor: TextColor.colorGreen,
          textSize: 18,
          bottom: 3,
          fontWeight: FontWeight.w600,
        ),
        _brandModel(),
        _manufactureEngine(),
        _tranmissionAxels(),
        CustomTextFormField(title: ConstStrings.condition),
        CustomTextFormField(title: ConstStrings.truckDescription),
      ],
    );
  }
}

Row _tranmissionAxels() {
  return Row(
    children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomTextFormField(title: ConstStrings.transmissionType),
        ),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomTextFormField(title: ConstStrings.axels),
        ),
      ),
    ],
  );
}

Row _manufactureEngine() {
  return Row(
    children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomTextFormField(title: ConstStrings.manufactureYear),
        ),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomTextFormField(title: ConstStrings.engineType),
        ),
      ),
    ],
  );
}

Row _brandModel() {
  return Row(
    children: [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomTextFormField(title: ConstStrings.brand),
        ),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomTextFormField(title: ConstStrings.model),
        ),
      ),
    ],
  );
}
