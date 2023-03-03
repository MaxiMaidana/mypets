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
              child: SizedBox(
                height: 10.h,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      DialogCustom.infoDialogWhitOptionsCustom(
                        context,
                        title: 'Cancelar?',
                        actions: [
                          ButtonCustom.text(
                            text: 'Seguir Despues',
                            onPress: () async => _goToMain(context),
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
              child: _step(context, controller.petStepToCreate.value),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToMain(BuildContext context) async {
    context.pop();
    context.pop();
    // controller.petStepToCreate.value = PetStep.name;
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
              // inputTextStep(context, petStep),
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

  // Widget inputTextStep(BuildContext context, PetStep petStep) => petStep ==
  //         PetStep.selectSpecie
  //     ? Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               ItemPetType(
  //                 icon: const FaIcon(
  //                   FontAwesomeIcons.dog,
  //                   size: 80,
  //                 ),
  //                 onTap: () {
  //                   controller.petModel.value.type = 'Dog';
  //                   controller.petModel.refresh();
  //                 },
  //                 type: 'Dog',
  //                 typeSelect: 'Sepecie',
  //               ),
  //               ItemPetType(
  //                 icon: const FaIcon(
  //                   FontAwesomeIcons.cat,
  //                   size: 80,
  //                 ),
  //                 onTap: () {
  //                   controller.petModel.value.type = 'Cat';
  //                   controller.petModel.refresh();
  //                 },
  //                 type: 'Cat',
  //                 typeSelect: 'Sepecie',
  //               )
  //             ],
  //           ),
  //           Container(
  //             height: 100,
  //             width: 100,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(25.h),
  //               color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
  //             ),
  //             child: const Center(
  //               child: Icon(
  //                 Icons.more_horiz,
  //                 size: 30,
  //               ),
  //             ),
  //           ),
  //         ],
  //       )
  //     : petStep == PetStep.name
  //         ? InputCustom.base(
  //             controller: controller.nameController,
  //             hint: 'Nombre*',
  //           )
  //         : petStep == PetStep.sex
  //             ? Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   ItemPetType(
  //                     icon: const Icon(
  //                       Icons.male,
  //                       size: 80,
  //                     ),
  //                     onTap: () {
  //                       controller.petModel.value.sex = 'Male';
  //                       controller.petModel.refresh();
  //                     },
  //                     type: 'Male',
  //                     typeSelect: 'Sex',
  //                   ),
  //                   ItemPetType(
  //                     icon: const Icon(
  //                       Icons.female,
  //                       size: 80,
  //                     ),
  //                     onTap: () {
  //                       controller.petModel.value.sex = 'Female';
  //                       controller.petModel.refresh();
  //                     },
  //                     type: 'Female',
  //                     typeSelect: 'Sex',
  //                   ),
  //                 ],
  //               )
  //             : petStep == PetStep.birthDate
  //                 ? Column(
  //                     children: [
  //                       GestureDetector(
  //                         onTap: () async => controller
  //                             .dateTimeToBirthDate.value = await showDatePicker(
  //                           context: context,
  //                           initialDate: DateTime.now(),
  //                           firstDate: DateTime(2000),
  //                           lastDate: DateTime.now(),
  //                         ),
  //                         child: Container(
  //                           height: 140,
  //                           width: 140,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(25.h),
  //                             color: Colors.grey[300],
  //                           ),
  //                           child: const Center(
  //                             child: Icon(
  //                               Icons.calendar_month,
  //                               size: 80,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 2.h),
  //                       Text(
  //                         controller.dateTimeToBirthDate.value == DateTime(2000)
  //                             ? ''
  //                             : controller.convertDateTimeToString(),
  //                         style: TextStyle(
  //                           fontSize: Theme.of(context)
  //                               .textTheme
  //                               .titleLarge!
  //                               .fontSize,
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 : petStep == PetStep.other
  //                     ? Column(
  //                         children: [
  //                           InputCustom.base(
  //                             controller: controller.breedController,
  //                             hint: 'Raza',
  //                           ),
  //                           SizedBox(height: 1.h),
  //                           InputCustom.base(
  //                             controller: controller.furController,
  //                             hint: 'Pelaje',
  //                           ),
  //                         ],
  //                       )
  //                     : petStep == PetStep.last
  //                         ? Column(
  //                             children: [
  //                               InputCustom.base(
  //                                 controller: controller.sizeController,
  //                                 hint: 'Tamaño',
  //                               ),
  //                               SizedBox(height: 1.h),
  //                               InputCustom.base(
  //                                 controller: controller.weigthController,
  //                                 hint: 'Peso',
  //                                 textInputType: TextInputType.number,
  //                               ),
  //                             ],
  //                           )
  //                         : Container();
}
