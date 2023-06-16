import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routes/routes.dart';
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
                onPressed: () async => await switchBack(),
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
              onPress: () async => await switchNext(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> switchBack() async {
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
        controller.sizeInputData.value = 55.h;
        await Future.delayed(const Duration(milliseconds: 1000));
        controller.sizeIcon.value = 25.h;
        break;
      default:
    }
  }

  Future<void> switchNext(BuildContext context) async {
    switch (controller.petStepToCreate.value) {
      case PetStep.selectSpecie:
        if (controller.specieSelected.value != '') {
          controller.petStepToCreate.value = PetStep.name;
        }
        break;
      case PetStep.name:
        if (controller.nameController.text != '') {
          controller.petStepToCreate.value = PetStep.sex;
        }
        break;
      case PetStep.sex:
        if (controller.sexSelected.value != '') {
          controller.petStepToCreate.value = PetStep.birthDate;
        }
        break;
      case PetStep.birthDate:
        if (controller.specieSelected.value == 'Perro' ||
            controller.specieSelected.value == 'Gato') {
          if (controller.dateTimeToBirthDate.value!.year > 2000) {
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
        controller.sizeIcon.value = 0;
        controller.petStepToCreate.value = PetStep.check;
        controller.sizeInputData.value = 90.h;
        await Future.delayed(const Duration(milliseconds: 1000));
        break;
      case PetStep.check:
        context.go(Routes.newPetCompleted);
        controller.addPet();
        break;
      default:
    }
  }
}
