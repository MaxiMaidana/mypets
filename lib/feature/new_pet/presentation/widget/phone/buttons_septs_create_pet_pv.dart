import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/button_custom.dart';
import '../../../../../core/widgets/dialog_custom.dart';

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
              onPress: () async => await switchNext(context),
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

  Future<void> switchNext(BuildContext context) async {
    switch (controller.petStepToCreate.value) {
      case PetStep.selectSpecie:
        if (controller.petModel.value.species != '') {
          controller.petStepToCreate.value = PetStep.name;
        }
        break;
      case PetStep.name:
        if (controller.nameController.text != '') {
          controller.petModel.value.name = controller.nameController.text[0].toUpperCase() + controller.nameController.text.substring(1);
          controller.petStepToCreate.value = PetStep.sex;
        }
        break;
      case PetStep.sex:
        if (controller.petModel.value.sex != '') {
          controller.petStepToCreate.value = PetStep.birthDate;
        }
        break;
      case PetStep.birthDate:
        if (controller.petModel.value.species == 'Dog' ||
            controller.petModel.value.species == 'Cat') {
          if (controller.petModel.value.birthDate != '') {
            controller.petStepToCreate.value = PetStep.other;
          }
        } else {
          controller.petStepToCreate.value = PetStep.check;
        }
        break;
      case PetStep.other:
        controller.petModel.value.breed = controller.breedController.text;
        controller.petModel.value.fur = controller.furController.text;
        controller.petStepToCreate.value = PetStep.last;
        break;
      case PetStep.last:
        controller.petModel.value.size = controller.sizeController.text;
        controller.petModel.value.weigth = controller.weigthController.text;
        controller.petStepToCreate.value = PetStep.check;
        break;
      case PetStep.check:
        bool res = await controller.addPet();
        if (res) {
          context.go(Routes.registerComplete);
        } else {
          DialogCustom.infoDialog(
            context,
            title: controller.errorModel!.code,
            message: controller.errorModel!.message,
            aceptar: () => context.go(Routes.auth),
          );
        }
        break;
      default:
    }
  }
}
