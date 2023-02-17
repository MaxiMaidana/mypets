import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
}
