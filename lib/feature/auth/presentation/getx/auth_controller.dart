import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/service/local_storage.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';

import '../../../../data/models/error_model.dart';
import '../../../app/presentation/getx/app_controller.dart';
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
  final FirebaseController _firebaseController = Get.find();
  final AppController _appController = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Rx<UserStatus> userStatus = UserStatus.init.obs;

  RxDouble heightTotal = 0.0.obs;

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
      await _firebaseController.loginWithGoogle();
      await validateDataUser();
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
      await _firebaseController.loginWithGoogleWeb();
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
    } catch (e) {
      log(e.toString());
      errorModel!.code = 'Error';
      errorModel!.message = 'No pudimos iniciar sesion';
      userStatus.value = UserStatus.error;
    }
  }

  Future<void> _loginWithCredentials() async {
    try {
      await _firebaseController.loginWithCredentials(
        email: emailController.text,
        pass: passController.text,
      );
      await validateDataUser();
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

  Future<void> validateDataUser() async {
    User? user = _firebaseController.firebaseAuth.currentUser!;
    await _appController.getUserData(user.uid);
    if (!_appController.userModel!.emailVerified) {
      log('need validate email');
      final registerController = Get.put(RegisterController());
      registerController.passController.text = passController.text;
      registerController.emailController.text = emailController.text;
      registerController.statusRegister.value = StatusRegister.emailSended;
      userStatus.value = UserStatus.needValidateEmail;
      return;
    }
    if (_appController.userModel!.dni == '') {
      log('need complete data');
      final registerController = Get.put(RegisterController());
      registerController.statusRegister.value = StatusRegister.emailVerified;
      registerController.completedDataStatus.value =
          CompletedDataStatus.secondStep;
      userStatus.value = UserStatus.needCompleteData;
      registerController.nameController.text =
          user.displayName!.split(' ').first;
      registerController.lastNameController.text =
          user.displayName!.split(' ').last;
      return;
    } else {
      log('all okey');
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
      userStatus.value = UserStatus.dataCompleted;
      return;
    }
  }
}
