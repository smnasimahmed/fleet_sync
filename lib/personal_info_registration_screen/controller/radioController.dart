import 'package:get/get.dart';

class RadioController extends GetxController {
  final Rx<OwnATrailer?> selectedTrailerOption = OwnATrailer.yes.obs;
  final Rx<DriverOwner?> selectedOperationOption = DriverOwner.no.obs;
  final Rx<TEndoursement?> selectedTEndousement = TEndoursement.yes.obs;

  void setSelectedOptionOwnATrailer(OwnATrailer? value) {
    selectedTrailerOption.value = value;
  }

  void setSelectedDriverOwner(DriverOwner? value) {
    selectedOperationOption.value = value;
  }

  void setselectedTEndousement(TEndoursement? value) {
    selectedTEndousement.value = value;
  }
}

enum DriverOwner { yes, no }

enum OwnATrailer { yes, no }

enum TEndoursement { yes, no }
