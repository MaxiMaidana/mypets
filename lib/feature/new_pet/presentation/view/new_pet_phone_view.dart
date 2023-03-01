import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:sizer/sizer.dart';

import '../getx/new_pet_controller.dart';
import '../widget/buttons_septs_create_pet.dart';

class NewPetsPhoneView extends GetWidget<NewPetController> {
  const NewPetsPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 96.5.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SizedBox(
                height: 10.h,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      DialogCustom.infoDialogWhitOptionsCustom(
                        context,
                        title: 'Importante!',
                        actions: [
                          ButtonCustom.text(
                            text: 'Seguir Despues',
                            onPress: () async => goToMain(context),
                          ),
                          ButtonCustom.principalShort(
                            text: 'Continuar',
                            onPress: () => context.pop(),
                          ),
                        ],
                        content: [
                          Text(
                            'Si no completas este formulario no vas a poder entrar al app',
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
            ),
            Icon(Icons.graphic_eq_outlined, size: 30.h),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 55.h,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Obx(() => step(context, controller.petStepToCreate.value)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToMain(BuildContext context) async {
    context.pop();
    context.pop();
    // controller.petStepToCreate.value = PetStep.name;
    Get.delete<NewPetController>();
  }

  Widget step(BuildContext context, PetStep petStep) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Text(
              titleToCompleteData(petStep),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              ),
            ),
            SizedBox(height: 2.h),
            inputTextStep(context, petStep),
            const Spacer(),
            const ButtonsStepsCreatePets(),
            SizedBox(height: 2.h),
          ],
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

  Widget inputTextStep(BuildContext context, PetStep petStep) =>
      petStep == PetStep.selectSpecie
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.h),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.candlestick_chart_outlined,
                          size: 80,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.h),
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.candlestick_chart_outlined,
                          size: 80,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.h),
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.online_prediction_sharp,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          : petStep == PetStep.name
              ? InputCustom.base(
                  controller: controller.nameController,
                  hint: 'Nombre*',
                )
              : petStep == PetStep.sex
                  ? Row(
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[300],
                          ),
                          child: const Center(
                            child: Icon(Icons.candlestick_chart_outlined),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[300],
                          ),
                          child: const Center(
                            child: Icon(Icons.candlestick_chart_outlined),
                          ),
                        ),
                      ],
                    )
                  : petStep == PetStep.birthDate
                      ? Column(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                child: Icon(Icons.candlestick_chart_outlined),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              '3/3/2008',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                          ],
                        )
                      : Container();
}
