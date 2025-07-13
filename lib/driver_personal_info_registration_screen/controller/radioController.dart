import 'package:get/get.dart';

class RadioController extends GetxController {
  final Rx<OwnATrailer?> selectedTrailerOption = OwnATrailer.yes.obs;
  final Rx<DriverOwner?> selectedOperationOption = DriverOwner.no.obs;
  final Rx<TEndoursement?> selectedTEndousement = TEndoursement.yes.obs;
  final Rx<PhysicalRepair?> selectedPhysicalRepair = PhysicalRepair.yes.obs;
  final Rx<MobileAssistant?> selectedMobileAssistant = MobileAssistant.yes.obs;
  final Rx<CreditLine?> selectedCreditLine = CreditLine.yes.obs;

  void setSelectedOptionOwnATrailer(OwnATrailer? value) {
    selectedTrailerOption.value = value;
  }

  void setSelectedDriverOwner(DriverOwner? value) {
    selectedOperationOption.value = value;
  }

  void setselectedTEndousement(TEndoursement? value) {
    selectedTEndousement.value = value;
  }

  void setselectedPhysicalRepair(PhysicalRepair? value) {
    selectedPhysicalRepair.value = value;
  }

  void setselectedMobileAssistant(MobileAssistant? value) {
    selectedMobileAssistant.value = value;
  }

  void setselectedCreditLine(CreditLine? value) {
    selectedCreditLine.value = value;
  }
}

enum DriverOwner { yes, no }

enum OwnATrailer { yes, no }

enum TEndoursement { yes, no }

enum PhysicalRepair { yes, no }

enum MobileAssistant { yes, no }

enum CreditLine { yes, no }
