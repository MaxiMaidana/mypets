import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/theme/themes.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/models/user/user_model.dart';

class AppController extends GetxController {
  PackageInfo? packageInfo;

  RxBool isDarkMode = false.obs;

  Rx<ThemeData> actualTheme = ligthMode.obs;

  late UserModel userModel;

  Future<void> getUserData(
      CollectionReference collectionReference, String uid) async {
    try {
      DocumentSnapshot res = await collectionReference.doc(uid).get();
      if (res.exists) {
        userModel = UserModel.fromJson(res.data() as Map<String, dynamic>);
      } else {
        print('Document does not exist on the database');
      }
    } catch (e) {
      log('rompio al traer el usuario de la base');
      rethrow;
    }
  }

  @override
  void onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }
}
