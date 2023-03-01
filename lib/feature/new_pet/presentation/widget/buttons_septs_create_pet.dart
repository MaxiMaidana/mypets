import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/button_custom.dart';
import '../../../../core/widgets/dialog_custom.dart';

class ButtonsStepsCreatePets extends GetWidget<NewPetController> {
  const ButtonsStepsCreatePets({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Visibility(
            visible: controller.petStepToCreate.value != PetStep.selectSpecie,
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
            width: controller.petStepToCreate.value != PetStep.selectSpecie
                ? 70.w
                : 90.w,
            child: ButtonCustom.principal(
              text: controller.petStepToCreate.value == PetStep.check
                  ? 'Finalizar'
                  : 'Siguiente',
              onPress: controller.petStepToCreate.value == PetStep.check
                  ? () async {
                      // bool res = await controller.updateUser(isLastStep: true);
                      // if (res) {
                      //   controller.statusRegister.value = StatusRegister.init;
                      //   controller.petStepToCreate.value =
                      //       PetStep.firstStep;
                      //   context.go(Routes.registerComplete);
                      // } else {
                      //   DialogCustom.infoDialog(
                      //     context,
                      //     title: controller.errorModel!.code,
                      //     message: controller.errorModel!.message,
                      //     aceptar: () => context.go(Routes.auth),
                      //   );
                      // }
                    }
                  : () => switchNext(),
            ),
          ),
        ],
      ),
    );
  }

  void switchBack() {
    //   switch (controller.PetStep.value) {
    //     case PetStep.firstStep:
    //       controller.PetStep.value = PetStep.firstStep;
    //       break;
    //     case PetStep.secondStep:
    //       controller.PetStep.value = PetStep.firstStep;
    //       break;
    //     case PetStep.thirtStep:
    //       controller.PetStep.value = PetStep.secondStep;
    //       break;
    //     case PetStep.checkData:
    //       controller.PetStep.value = PetStep.thirtStep;
    //       break;
    //     default:
    //   }
  }

  void switchNext() {
    // switch (controller.PetStep.value) {
    //   case PetStep.firstStep:
    //     if (controller.nameController.text != '' &&
    //         controller.lastNameController.text != '') {
    //       controller.PetStep.value = PetStep.secondStep;
    //     }
    //     break;
    //   case PetStep.secondStep:
    //     if (controller.dniController.text != '') {
    //       controller.PetStep.value = PetStep.thirtStep;
    //     }
    //     break;
    //   case PetStep.thirtStep:
    //     if (controller.phoneController.text != '') {
    //       controller.PetStep.value = PetStep.checkData;
    //     }
    //     break;
    //   case PetStep.checkData:
    //     controller.PetStep.value = PetStep.completed;
    //     break;
    //   default:
    // }
  }
}
