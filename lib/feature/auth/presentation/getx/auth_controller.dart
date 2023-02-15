import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/service/local_storage.dart';

import '../../../firebase/firebase_controller.dart';

enum LoginType { google, credentials, googleWeb }

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isLogued = false.obs;
  final FirebaseController _firebaseController = Get.find();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> logIn({
    required LoginType loginType,
    String? email,
    String? pass,
  }) async {
    try {
      if (GetPlatform.isWeb) {
        switch (loginType) {
          case LoginType.google:
            await _loginWithGoogleWeb();
            break;
          case LoginType.credentials:
            await _loginWithCredentials();
            break;
          default:
        }
      } else {
        switch (loginType) {
          case LoginType.google:
            await _loginWithGoogle();
            break;
          case LoginType.credentials:
            await _loginWithCredentials();
            break;
          default:
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      isLogued.value = await _firebaseController.loginWithGoogle();
      LocalStorage.setPref(SetPref.auth, true);
    } catch (e) {
      isLogued.value = false;
      rethrow;
    }
  }

  Future<void> _loginWithGoogleWeb() async {
    try {
      // isLogued.value =
      await _firebaseController.loginWithGoogleWeb();
      LocalStorage.setPref(SetPref.auth, true);
    } catch (e) {
      // isLogued.value = false;
      rethrow;
    }
  }

  Future<void> _loginWithCredentials() async {
    try {
      isLogued.value = await _firebaseController.loginWithCredentials(
        email: emailController.text,
        pass: passController.text,
      );
      LocalStorage.setPref(SetPref.auth, true);
    } catch (e) {
      isLogued.value = false;
      rethrow;
    }
  }

  // Future<void> logOut() async {
  //   try {
  //     await _firebaseController.logoutGoogle();
  //     // isLogued.value = false;
  //   } catch (e) {
  //     // isLogued.value = false;
  //     rethrow;
  //   }
  // }
}
