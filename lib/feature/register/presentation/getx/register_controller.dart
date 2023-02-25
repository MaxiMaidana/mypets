import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mypets/data/models/error_model.dart';
import 'package:mypets/data/models/user/user_model.dart';
import 'package:mypets/feature/app/controller/app_controller.dart';

import '../../../../core/service/local_storage.dart';
import '../../../firebase/getx/firebase_controller.dart';

enum StatusRegister {
  init,
  emailNotSend,
  emailSended,
  emailVerified,
  needCompleteData
}

enum CompletedDataStatus {
  firstStep,
  secondStep,
  thirtStep,
  checkData,
  completed,
}

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  Rx<StatusRegister> statusRegister = StatusRegister.init.obs;
  Rx<CompletedDataStatus> completedDataStatus =
      CompletedDataStatus.firstStep.obs;

  final FirebaseController _firebaseController = Get.find();
  final AppController _appController = Get.find();

  late CollectionReference _collectionReference;

  bool emailSended = false;

  ErrorModel? errorModel;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    phoneController.dispose();
    dniController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  bool validateInputs() =>
      emailController.text != '' &&
      passController.text != '' &&
      passController.text == confirmPassController.text;

  // change(null, status: RxStatus.loading());
  Future<bool> registerWithEmail() async {
    try {
      await _firebaseController.registerUserWithEmail(
          email: emailController.text, pass: 'asd123');
      await createUser();
      emailSended = await _firebaseController.sendVerifyEmail();
      if (emailSended) {
        statusRegister.value = StatusRegister.emailSended;
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      String title = '';
      String message = '';
      if (e.code == 'email-already-in-use') {
        title = 'Email en uso';
        message =
            'El email ya se encuentra registrado.\nTrata de registrarte con otro por favor, o si no recuerdas tu clave, puede recuperarla =D';
      }
      errorModel = ErrorModel(code: title, message: message);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerWithGoogle() async {
    try {
      await _firebaseController.loginWithGoogle();
      await _appController.getUserData(_collectionReference,
          _firebaseController.firebaseAuth.currentUser!.uid);
      if (_appController.userModel.emailVerified &&
          _appController.userModel.dni != '') {
        completedDataStatus.value = CompletedDataStatus.completed;
        return true;
      }
      nameController.text = _firebaseController
          .firebaseAuth.currentUser!.displayName!
          .split(' ')
          .first;
      lastNameController.text = _firebaseController
          .firebaseAuth.currentUser!.displayName!
          .split(' ')
          .last;
      await createUser(emailVarified: true);
      statusRegister.value = StatusRegister.emailVerified;
      completedDataStatus.value = CompletedDataStatus.secondStep;
      return true;
    } on FirebaseAuthException catch (e) {
      String title = '';
      String message = '';
      if (e.code == 'email-already-in-use') {
        title = 'Email en uso';
        message =
            'El email ya se encuentra registrado.\nTrata de registrarte con otro por favor, o si no recuerdas tu clave, puede recuperarla =D';
      }
      errorModel = ErrorModel(code: title, message: message);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkIfEmailIsVerify() async {
    try {
      await _firebaseController.verifyIfUserValidate(
          email: emailController.text,
          pass: passController.text == '' ? null : passController.text);
      if (_firebaseController.firebaseAuth.currentUser!.emailVerified) {
        await updateUser(emailVerified: true);
        await _firebaseController.changePasswordUser(pass: passController.text);
        return true;
      } else {
        errorModel = ErrorModel(
            code: 'Algo andvo mal',
            message: 'No  pudimos  validar tu email =(');
        return false;
      }
    } catch (e) {
      errorModel = ErrorModel(
          code: 'Algo andvo mal', message: 'No  pudimos  validar tu email :(');
      return false;
    }
  }

  Future<void> changePassword() async {
    try {
      await _firebaseController.changePasswordUser(pass: passController.text);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendEmailToValidate() async {
    try {
      await _firebaseController.sendVerifyEmail();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createUser({bool? emailVarified}) async {
    try {
      addUSer(
        UserModel(
          name: nameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          dni: dniController.text,
          phone: phoneController.text,
          urlPhoto:
              _firebaseController.firebaseAuth.currentUser!.photoURL ?? '',
          emailVerified: emailVarified ?? false,
          pets: [],
        ),
      );

      return true;
    } catch (e) {
      String title = '';
      String message = '';
      title = 'Erro al crear el usuario';
      message =
          'Tuvimos un problema a la hora de crear tu usuario, intentelo mas tarde por favor.';
      errorModel = ErrorModel(code: title, message: message);
      return false;
    }
  }

  Future<bool> updateUser(
      {bool? emailVerified, bool isLastStep = false}) async {
    try {
      await updateUSer(
        UserModel(
          name: nameController.text,
          lastName: lastNameController.text,
          email: _firebaseController.firebaseAuth.currentUser!.email!,
          dni: dniController.text,
          phone: phoneController.text,
          urlPhoto:
              _firebaseController.firebaseAuth.currentUser!.photoURL ?? '',
          emailVerified: emailVerified ??
              _firebaseController.firebaseAuth.currentUser!.emailVerified,
          pets: [],
        ),
      );
      if (isLastStep) {
        LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
      }
      return true;
    } catch (e) {
      String title = '';
      String message = '';
      title = 'Erro al crear el usuario';
      message =
          'Tuvimos un problema a la hora de crear tu usuario, intentelo mas tarde por favor.';
      errorModel = ErrorModel(code: title, message: message);
      return false;
    }
  }

  Future<void> addUSer(UserModel userModel) async {
    try {
      await _collectionReference
          .doc(_firebaseController.firebaseAuth.currentUser!.uid)
          .set(userModel.toJson());
      log('se creo el usuario');
    } catch (e) {
      log('no se creo el usuario');
      rethrow;
    }
  }

  Future<void> updateUSer(UserModel userModel) async {
    try {
      _collectionReference
          .doc(_firebaseController.firebaseAuth.currentUser!.uid)
          .update(userModel.toJson());
      log('se actualizo el usuario');
    } catch (e) {
      log('no se actualizo el usuario');
      rethrow;
    }
  }

  @override
  void onInit() {
    _collectionReference =
        _firebaseController.connectWithFirebaseCollection('users');
    super.onInit();
  }
}
