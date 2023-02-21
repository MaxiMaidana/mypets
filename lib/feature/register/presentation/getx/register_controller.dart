import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mypets/data/models/error_model.dart';
import 'package:mypets/feature/firebase/data/model/user_model.dart';

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
  completed
}

class RegisterController extends GetxController with StateMixin {
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

  Future<void> clearData() async {
    emailController.clear();
    passController.clear();
    confirmPassController.clear();
    phoneController.clear();
    dniController.clear();
    nameController.clear();
    lastNameController.clear();
    statusRegister.value = StatusRegister.init;
    completedDataStatus.value = CompletedDataStatus.firstStep;
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

  Future<void> checkIfEmailIsVerify() async {
    try {
      await _firebaseController.verifyIfUserValidate(
          email: emailController.text);
      if (_firebaseController.firebaseAuth.currentUser!.emailVerified) {
        bool res = await _firebaseController.changePasswordUser(
            pass: passController.text);
        if (res) {
          statusRegister.value = StatusRegister.emailVerified;
        } else {
          Exception('cambiar la pass');
        }
      } else {
        Exception('No pudimos validar tu email');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createUser() async {
    try {
      _firebaseController.addUSer(
        UserModel(
          name: nameController.text,
          lastName: lastNameController.text,
          dni: int.parse(dniController.text),
          phone: int.parse(phoneController.text),
          urlPhoto:
              _firebaseController.firebaseAuth.currentUser!.photoURL ?? '',
          petsId: [],
        ),
      );
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: true);
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
}
