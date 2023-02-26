import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/theme/themes.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../data/models/user/user_model.dart';
import '../../domain/provider/app_provider.dart';

class AppController extends GetxController {
  final AppProvider appProvider = AppProvider();
  PackageInfo? packageInfo;

  RxBool isDarkMode = false.obs;

  Rx<ThemeData> actualTheme = ligthMode.obs;

  UserModel? userModel;

  Future<void> getUserData(String uid) async {
    try {
      userModel = await appProvider.getUserData(uid);
    } catch (e) {
      log('no se pudo traer la info del user');
      return;
    }
  }

  @override
  void onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }
}
