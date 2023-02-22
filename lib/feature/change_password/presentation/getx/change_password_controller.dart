import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/error_model.dart';
import '../../../firebase/getx/firebase_controller.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FirebaseController _firebaseController = Get.find();

  ErrorModel? errorModel;

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<bool> changePassword() async {
    try {
      await _firebaseController.sendEmailToResetPassword(
          email: emailController.text);
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
