import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/service/local_storage.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

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
  final FirebaseController _firebaseController = Get.find();

  Rx<UserStatus> userStatus = UserStatus.init.obs;

  ErrorModel? errorModel;

  RxDouble heightTotal = 0.0.obs;

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
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      String title = '';
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          title = 'Error';
          message = 'El usuario no se encuentra registrado en el app';
          break;
        case 'wrong-password':
          title = 'Error';
          message = 'El password ingresado es incorrecto';
          break;
        case 'invalid-email':
          title = 'Error';
          message = 'El email esta mal escrito';
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
    if (!_firebaseController.userModel.emailVerified) {
      log('need validate email');
      final registerController = Get.put(RegisterController());
      registerController.passController.text = passController.text;
      registerController.emailController.text = emailController.text;
      registerController.statusRegister.value = StatusRegister.emailSended;
      userStatus.value = UserStatus.needValidateEmail;
      return;
    }
    if (_firebaseController.userModel.dni == '') {
      log('need complete data');
      final registerController = Get.put(RegisterController());
      registerController.statusRegister.value = StatusRegister.emailVerified;
      registerController.completedDataStatus.value =
          CompletedDataStatus.secondStep;
      userStatus.value = UserStatus.needCompleteData;
      return;
    } else {
      log('all okey');
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
      userStatus.value = UserStatus.dataCompleted;
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
