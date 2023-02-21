import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/service/local_storage.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';

import '../../../../data/models/error_model.dart';
import '../../../firebase/getx/firebase_controller.dart';

enum LoginType { google, credentials, googleWeb }

enum UserStatus {
  init,
  needValidateEmail,
  needCompleteData,
  dataCompleted,
  error
}

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // RxBool isLogued = false.obs;
  final FirebaseController _firebaseController = Get.find();

  Rx<UserStatus> userStatus = UserStatus.init.obs;

  ErrorModel? errorModel;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> logIn(
      {required LoginType loginType, String? email, String? pass}) async {
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
      // isLogued.value =
      await _firebaseController.loginWithGoogle();
      validateDataUser();
      // LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String title = '';
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          title = 'Error';
          message = 'El usuario no se encuentra registrado en el app';
          break;
        case 'network-request-failed':
          title = 'Error';
          message =
              'Parece que hubo un problema con la conexion, vuelva a intentarlo mas tarde.';
          break;
        default:
      }
      errorModel = ErrorModel(code: title, message: message);
      userStatus.value = UserStatus.error;
    } catch (e) {}
  }

  Future<void> _loginWithGoogleWeb() async {
    try {
      // isLogued.value =
      await _firebaseController.loginWithGoogleWeb();
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
    } catch (e) {
      log(e.toString());
      errorModel!.code = 'Error';
      errorModel!.message = 'No pudimos iniciar sesion';
      userStatus.value = UserStatus.error;
      // rethrow;
    }
  }

  Future<void> _loginWithCredentials() async {
    try {
      await _firebaseController.loginWithCredentials(
        email: emailController.text,
        pass: passController.text,
      );
      validateDataUser();
      // LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String title = '';
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          title = 'Error';
          message = 'El usuario no se encuentra registrado en el app';
          break;
        case 'network-request-failed':
          title = 'Error';
          message =
              'Parece que hubo un problema con la conexion, vuelva a intentarlo mas tarde.';
          break;
        default:
      }
      errorModel = ErrorModel(code: title, message: message);
      userStatus.value = UserStatus.error;
    } catch (e) {}
  }

  void validateDataUser() {
    if (!_firebaseController.firebaseAuth.currentUser!.emailVerified) {
      log('need validate email');
      final registerController = Get.put(RegisterController());
      registerController.statusRegister.value = StatusRegister.emailSended;
      userStatus.value = UserStatus.needValidateEmail;
      return;
    }
    if (_firebaseController.firebaseAuth.currentUser!.displayName == null) {
      log('need complete data');
      final registerController = Get.put(RegisterController());
      registerController.statusRegister.value = StatusRegister.emailVerified;
      userStatus.value = UserStatus.needCompleteData;
      return;
    } else {
      log('all okey');
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
      return;
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
