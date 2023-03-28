import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:sizer/sizer.dart';

import '../getx/new_pet_controller.dart';
import '../widget/phone/buttons_septs_create_pet_pv.dart';
import '../widget/phone/step_to_create_pv.dart';

class NewPetsPV extends GetWidget<NewPetController> {
  const NewPetsPV({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SizedBox(
                height: 40,
                width: 40,
                child: GestureDetector(
                  onTap: () {
                    DialogCustom.infoDialogWhitOptionsCustom(
                      context,
                      title: 'Cancelar?',
                      actions: [
                        SizedBox(
                          width: 26.w,
                          child: ButtonCustom.text(
                            text: 'Cancelar',
                            onPress: () async => _goToMain(context),
                          ),
                        ),
                        ButtonCustom.principalShort(
                          text: 'Continuar',
                          onPress: () => context.pop(),
                        ),
                      ],
                      content: [
                        Text(
                          'Si cancelas perderas todo tu progreso y deberas volver a arrancar desde el pricipio la proxima vez.',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                        ),
                      ],
                    );
                  },
                  child: const Center(
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Obx(
              () => Center(
                child: AnimatedOpacity(
                  opacity:
                      controller.petStepToCreate.value == PetStep.check ? 0 : 1,
                  duration: const Duration(milliseconds: 1000),
                  child: Icon(Icons.graphic_eq_outlined,
                      size: controller.sizeIcon.value),
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: double.infinity,
                height: controller.sizeInputData.value,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: _step(context, controller.petStepToCreate.value),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToMain(BuildContext context) async {
    context.pop();
    context.pop();
    Get.delete<NewPetController>();
  }

  Widget _step(BuildContext context, PetStep petStep) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Obx(
          () => SingleChildScrollView(
            child: SizedBox(
              height: controller.sizeInputData.value,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    titleToCompleteData(controller.petStepToCreate.value),
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const StepToCreate(),
                  const Spacer(),
                  const ButtonsStepsCreatePets(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );

  String titleToCompleteData(PetStep petStep) => petStep == PetStep.selectSpecie
      ? 'Empezemos !'
      : petStep == PetStep.name
          ? 'Como se llama ?'
          : petStep == PetStep.sex
              ? 'Sexo'
              : petStep == PetStep.birthDate
                  ? 'Cuando se combirtio en parte de la familia ?'
                  : petStep == PetStep.other
                      ? 'Otros Datos'
                      : petStep == PetStep.last
                          ? 'Los ultimos !'
                          : petStep == PetStep.check
                              ? 'Repasemos'
                              : '';
}
