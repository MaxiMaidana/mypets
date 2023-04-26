import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/phone/email_verified_pv.dart';
import '../view/phone/register_pv.dart';
import '../view/phone/steps_to_complete_data_pv.dart';
import '../view/phone/waithing_validation_pv.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WidgetTree(
        tiny: const Text('tiny'),
        phone: Obx(
          () => controller.statusRegister.value == StatusRegister.init
              ? const RegisterPV()
              : controller.statusRegister.value == StatusRegister.emailSended
                  ? const WaithingValidationPV()
                  : controller.statusRegister.value ==
                          StatusRegister.emailVerified
                      ? const EmailVerifiedPV()
                      : controller.statusRegister.value ==
                              StatusRegister.needCompleteData
                          ? const StepsToCompleteDataPV()
                          : Container(),
        ),
        tablet: const Text('tablet'),
        largeTablet: const Text('tablet large'),
        computer: const Text('computer'),
      ),
    );
  }
}
