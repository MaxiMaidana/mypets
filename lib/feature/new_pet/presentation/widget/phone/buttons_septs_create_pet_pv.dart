import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/widgets/button_custom.dart';

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
    switch (controller.petStepToCreate.value) {
      case PetStep.selectSpecie:
        controller.petStepToCreate.value = PetStep.selectSpecie;
        break;
      case PetStep.name:
        controller.petStepToCreate.value = PetStep.selectSpecie;
        break;
      case PetStep.sex:
        controller.petStepToCreate.value = PetStep.name;
        break;
      case PetStep.birthDate:
        controller.petStepToCreate.value = PetStep.sex;
        break;
      case PetStep.other:
        controller.petStepToCreate.value = PetStep.birthDate;
        break;
      case PetStep.last:
        controller.petStepToCreate.value = PetStep.other;
        break;
      case PetStep.check:
        controller.petStepToCreate.value = PetStep.last;
        break;
      default:
    }
  }

  void switchNext() {
    switch (controller.petStepToCreate.value) {
      case PetStep.selectSpecie:
        if (controller.petModel.value.type != '') {
          controller.petStepToCreate.value = PetStep.name;
        }
        break;
      case PetStep.name:
        if (controller.nameController.text != '') {
          controller.petModel.value.name = controller.nameController.text;
          controller.petStepToCreate.value = PetStep.sex;
        }
        break;
      case PetStep.sex:
        if (controller.petModel.value.sex != '') {
          controller.petStepToCreate.value = PetStep.birthDate;
        }
        break;
      case PetStep.birthDate:
        if (controller.petModel.value.type == 'Dog' ||
            controller.petModel.value.type == 'Cat') {
          if (controller.petModel.value.birthday != '') {
            controller.petStepToCreate.value = PetStep.other;
          }
        } else {
          controller.petStepToCreate.value = PetStep.check;
        }
        break;
      case PetStep.other:
        controller.petStepToCreate.value = PetStep.last;
        break;
      case PetStep.last:
        controller.petStepToCreate.value = PetStep.check;
        break;
      default:
    }
  }
}
