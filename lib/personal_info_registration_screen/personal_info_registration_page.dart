import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/rememberMe.dart';
import 'package:fleet_sync/personal_info_registration_screen/component/personal_info_page.dart';
import 'package:fleet_sync/personal_info_registration_screen/controller/radioController.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoRegistrationPage extends StatelessWidget {
  PersonalInfoRegistrationPage({super.key});
  final RadioController controller = Get.find<RadioController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.registration),
      body: _registarionBody(),
    );
  }

  Center _registarionBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonalInfoPage(),
              rememberMeCheckBox(ConstStrings.iAgreeTermsAndConditions),
              Padding(
                padding: const EdgeInsets.only(bottom: 43.0),
                child: _cancleNextButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Center _registarionBody() {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 18),
  //       child: SingleChildScrollView(
  //         child: Obx(() {
  //           return Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               newMethod(),
  //               rememberMeCheckBox(ConstStrings.iAgreeTermsAndConditions),
  //               Padding(
  //                 padding: const EdgeInsets.only(bottom: 43.0),
  //                 child: _cancleNextButton(),
  //               ),
  //             ],
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  // }

  Widget _cancleNextButton() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 9),
            child: customElevatedButton(
              title: ConstStrings.cancel,
              color: Colors.red,
              onPressed: () => Get.back(),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 9),
            child: customElevatedButton(
              title: ConstStrings.next,
              onPressed: () {
                if (controller.selectedTrailerOption.value == OwnATrailer.yes) {
                  Get.toNamed(AppRoutes.truckInformation);
                }
                print('Wellcome');
              },
            ),
          ),
        ),
      ],
    );
  }

  //   Row _tEndoursement() {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Flexible(
  //           flex: 1,
  //           child: CustomRadio<TEndoursement>(
  //             title: Customtext(
  //               title: ConstStrings.yes,
  //               textColor: TextColor.colorWhite,
  //             ),
  //             value: TEndoursement.yes,
  //             groupValue:
  //                 controller.selectedTEndousement.value ?? TEndoursement.yes,
  //             onChanged: controller.setselectedTEndousement,
  //           ),
  //         ),

  //         Flexible(
  //           flex: 1,
  //           child: CustomRadio<TEndoursement>(
  //             title: Customtext(
  //               title: ConstStrings.no,
  //               textColor: TextColor.colorWhite,
  //             ),
  //             value: TEndoursement.no,
  //             groupValue:
  //                 controller.selectedTEndousement.value ?? TEndoursement.yes,
  //             onChanged: controller.setselectedTEndousement,
  //           ),
  //         ),
  //       ],
  //     );
  //   }

  //   Row _workExperience() {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 9.5),
  //             child: customTextFormField(
  //               title: ConstStrings.workExperience,
  //               hintText: 'Months',
  //               numaric: true,
  //             ),
  //           ),
  //         ),
  //         Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 9.5),
  //             child: customTextFormField(
  //               title: '',
  //               hintText: 'Years',
  //               numaric: true,
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   }

  //   Widget _genderDOBform() {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 9.5),
  //             child: customTextFormField(title: ConstStrings.gender),
  //           ),
  //         ),
  //         Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 9.5),
  //             child: customTextFormField(title: ConstStrings.dateOfBirth),
  //           ),
  //         ),
  //       ],
  //     );
  //   }

  //   Row ownTrailer() {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Flexible(
  //           flex: 1,
  //           child: CustomRadio(
  //             title: Customtext(
  //               title: ConstStrings.yes,
  //               textColor: TextColor.colorWhite,
  //             ),
  //             value: OwnATrailer.yes,
  //             groupValue:
  //                 controller.selectedTrailerOption.value ?? OwnATrailer.yes,
  //             onChanged: controller.setSelectedOptionOwnATrailer,
  //           ),
  //         ),

  //         Flexible(
  //           flex: 1,
  //           child: CustomRadio(
  //             title: Customtext(
  //               title: ConstStrings.no,
  //               textColor: TextColor.colorWhite,
  //             ),
  //             value: OwnATrailer.no,
  //             groupValue:
  //                 controller.selectedTrailerOption.value ?? OwnATrailer.yes,
  //             onChanged: controller.setSelectedOptionOwnATrailer,
  //           ),
  //         ),
  //       ],
  //     );
  //   }

  //   Row ownerOperator() {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Flexible(
  //           flex: 1,
  //           child: CustomRadio<DriverOwner>(
  //             title: Customtext(
  //               title: ConstStrings.ownerOperator,
  //               textColor: TextColor.colorWhite,
  //             ),
  //             value: DriverOwner.yes,
  //             groupValue:
  //                 controller.selectedOperationOption.value ?? DriverOwner.no,
  //             onChanged: controller.setSelectedDriverOwner,
  //           ),
  //         ),

  //         Flexible(
  //           flex: 1,
  //           child: CustomRadio<DriverOwner>(
  //             title: Customtext(
  //               title: ConstStrings.companyDriver,
  //               textColor: TextColor.colorWhite,
  //             ),
  //             value: DriverOwner.no,
  //             groupValue:
  //                 controller.selectedOperationOption.value ?? DriverOwner.no,
  //             onChanged: controller.setSelectedDriverOwner,
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }
}
