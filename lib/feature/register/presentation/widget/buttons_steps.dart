import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/button_custom.dart';

class ButtonsSteps extends GetView<RegisterController> {
  const ButtonsSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Visibility(
            visible: controller.completedDataStatus.value !=
                CompletedDataStatus.firstStep,
            child: SizedBox(
              width: 20.w,
              child: IconButton(
                onPressed: () => switchBack(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: controller.completedDataStatus.value !=
                    CompletedDataStatus.firstStep
                ? 70.w
                : 90.w,
            child: ButtonCustom.principal(
              text: controller.completedDataStatus.value ==
                      CompletedDataStatus.checkData
                  ? 'Finalizar'
                  : 'Siguiente',
              onPress: controller.completedDataStatus.value ==
                      CompletedDataStatus.checkData
                  ? () {}
                  : () => switchNext(),
            ),
          ),
        ],
      ),
    );
  }

  void switchBack() {
    switch (controller.completedDataStatus.value) {
      case CompletedDataStatus.firstStep:
        controller.completedDataStatus.value = CompletedDataStatus.firstStep;
        break;
      case CompletedDataStatus.secondStep:
        controller.completedDataStatus.value = CompletedDataStatus.firstStep;
        break;
      case CompletedDataStatus.thirtStep:
        controller.completedDataStatus.value = CompletedDataStatus.secondStep;
        break;
      case CompletedDataStatus.checkData:
        controller.completedDataStatus.value = CompletedDataStatus.thirtStep;
        break;
      default:
    }
  }

  void switchNext() {
    switch (controller.completedDataStatus.value) {
      case CompletedDataStatus.firstStep:
        if (controller.nameController.text != '' &&
            controller.lastNameController.text != '') {
          controller.completedDataStatus.value = CompletedDataStatus.secondStep;
        }
        break;
      case CompletedDataStatus.secondStep:
        if (controller.dniController.text != '') {
          controller.completedDataStatus.value = CompletedDataStatus.thirtStep;
        }
        break;
      case CompletedDataStatus.thirtStep:
        if (controller.phoneController.text != '') {
          controller.completedDataStatus.value = CompletedDataStatus.checkData;
        }
        break;
      case CompletedDataStatus.checkData:
        controller.completedDataStatus.value = CompletedDataStatus.completed;
        break;
      default:
    }
  }
}
