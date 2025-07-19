import 'package:get_storage/get_storage.dart';

class StorageKey {
  // StorageKey._();
  // static const String token = "token";
  // static const String refreshToken = "refreshToken";
  // static const String onBoardValue = "onBoard";
  // static const String likeValue = "likeValue";
  // static const String dislikeValue = "dislkeValue";
  static const String loginValue = "loginValue";
  static const String setLoginUserRole = "setLoginUserRole";
}

class AppStorage {
  ////////////// storage initial
  GetStorage box = GetStorage();

  //////////////////// Token
  // Future<void> setToken(String value) async {
  //   await box.write(StorageKey.token, value);
  // }

  // String? getToken() {
  //   return box.read(StorageKey.token) ?? "";
  // }

  // Future<void> setRefreshToken(String value) async {
  //   await box.write(StorageKey.refreshToken, value);
  // }

  Future<void> setLoginValue(RouteInitial value) async {
    await box.write(StorageKey.loginValue, value.name);
  }

  Future<void> setLoginUserRole(int value) async {
    await box.write(StorageKey.setLoginUserRole, value);
  }

  RouteInitial getLoginValue() {
    String? stored = box.read(StorageKey.loginValue);
    var something = RouteInitial.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => RouteInitial.login,
    );
    return something;
    // return box.read(StorageKey.loginValue) ?? RouteInitial.login.name;
  }

  int getLoginUserRole() {
    return box.read(StorageKey.setLoginUserRole) ?? 0;
  }
  // String? getRefreshToken() {
  //   return box.read(StorageKey.refreshToken);
  // }

  // Future<void> setOnBoardValue(String value) async {
  //   await box.write(StorageKey.onBoardValue, value);
  // }

  // Future<void> setLikeValue(String value) async {
  //   await box.write(StorageKey.likeValue, value);
  // }

  // Future<void> setDislikeValue(String value) async {
  //   await box.write(StorageKey.dislikeValue, value);
  // }

  String? getValue(String value) {
    return box.read(value);
  }

  // Future<void> removeValue(String value) async {
  //   await box.remove(value);
  // }

  // ///logout
  // Future<void> storageAllClear() async {
  //   await box.erase();
  // }
}

enum RouteInitial { login, navbar, role, packageBuying, welcomePage }
