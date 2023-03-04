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
        height: 96.5.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
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
                  child: const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: controller.petStepToCreate.value == PetStep.check
                    ? 20.h
                    : 30.h,
                child: Icon(Icons.graphic_eq_outlined,
                    size: controller.petStepToCreate.value == PetStep.check
                        ? 20.h
                        : 25.h),
              ),
            ),
            const Spacer(),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: double.infinity,
                height: controller.petStepToCreate.value == PetStep.check
                    ? 70.h
                    : 55.h,
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
          () => Column(
            children: [
              SizedBox(height: 2.h),
              Text(
                titleToCompleteData(controller.petStepToCreate.value),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
              ),
              SizedBox(height: 2.h),
              const StepToCreate(),
              const Spacer(),
              const ButtonsStepsCreatePets(),
              SizedBox(height: 2.h),
            ],
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
