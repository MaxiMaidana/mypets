import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/theme/themes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  PackageInfo? packageInfo;

  RxBool isDarkMode = false.obs;

  Rx<ThemeData> actualTheme = ligthMode.obs;

  @override
  void onInit() async {
    packageInfo = await PackageInfo.fromPlatform();

    super.onInit();
  }
}
