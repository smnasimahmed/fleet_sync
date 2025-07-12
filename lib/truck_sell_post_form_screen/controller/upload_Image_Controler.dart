import 'package:fleet_sync/const/const_strings.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadImageControler extends GetxController {
  final picker = ImagePicker();
  Rx<XFile?> pickedSingleFile = Rx<XFile?>(null);
  RxList<XFile> pickedMultipleFile = <XFile>[].obs;

  Future<void> requestPhotosPermissionAndPick({
    required bool isSingleImage,
  }) async {
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      // Permission granted, proceed to pick image
      (isSingleImage == true) ? await pickImage() : pickMultiImage();
    } else if (status.isDenied) {
      // Show a polite dialog explaining why permission is needed
      Get.snackbar(
        'Permission Needed',
        'Please allow gallery access to select images.',
      );
    } else if (status.isPermanentlyDenied) {
      // Guide user to app settings
      Get.defaultDialog(
        title: 'Permission Required',
        middleText:
            'Please enable gallery permission from settings to upload images.',
        textConfirm: 'Open Settings',
        onConfirm: () {
          openAppSettings();
          Get.back();
        },
        textCancel: 'Cancel',
      );
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        pickedSingleFile.value = file;
        Get.snackbar(
          ConstStrings.success,
          ConstStrings.imageSelected + file.name,
        );
      } else {
        Get.snackbar(ConstStrings.cancelled, ConstStrings.noImageSelected);
      }
    } catch (error) {
      Get.snackbar(
        ConstStrings.error,
        '${ConstStrings.failedToPickImage}: $error',
      );
    }
  }

  Future<void> pickMultiImage() async {
    try {
      final List<XFile> files = await picker.pickMultiImage();
      if (files.isNotEmpty) {
        pickedMultipleFile.value = files;
        Get.snackbar(
          ConstStrings.success,
          '${files.length} ${ConstStrings.imageSelected}',
        );
      } else {
        Get.snackbar(ConstStrings.cancelled, ConstStrings.noImageSelected);
      }
    } catch (error) {
      Get.snackbar(
        ConstStrings.error,
        '${ConstStrings.failedToPickImage}: $error',
      );
    }
  }

  Future<void> requestStorageAndCameraPermissions() async {
    if (await Permission.photos.isDenied ||
        await Permission.photos.isPermanentlyDenied) {
      await Permission.photos.request();
    }
    if (await Permission.storage.isDenied ||
        await Permission.storage.isPermanentlyDenied) {
      await Permission.storage.request();
    }
    if (await Permission.camera.isDenied ||
        await Permission.camera.isPermanentlyDenied) {
      await Permission.camera.request();
    }
  }
}
