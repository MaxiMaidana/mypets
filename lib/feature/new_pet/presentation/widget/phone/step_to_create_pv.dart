import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:mypets/feature/new_pet/presentation/widget/phone/check_items_pv.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/widgets/input_custom.dart';
import 'item_pet_type_pv.dart';

class StepToCreate extends GetWidget<NewPetController> {
  const StepToCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.petStepToCreate.value == PetStep.selectSpecie
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ItemPetType(
                      icon: const FaIcon(
                        FontAwesomeIcons.dog,
                        size: 80,
                      ),
                      onTap: () {
                        controller.petModel.value.species = 'Dog';
                        controller.petModel.refresh();
                      },
                      type: 'Dog',
                      typeSelect: 'Sepecie',
                    ),
                    ItemPetType(
                      icon: const FaIcon(
                        FontAwesomeIcons.cat,
                        size: 80,
                      ),
                      onTap: () {
                        controller.petModel.value.species = 'Cat';
                        controller.petModel.refresh();
                      },
                      type: 'Cat',
                      typeSelect: 'Sepecie',
                    )
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.h),
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.more_horiz,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          : controller.petStepToCreate.value == PetStep.name
              ? InputCustom.base(
                  controller: controller.nameController,
                  hint: 'Nombre*',
                )
              : controller.petStepToCreate.value == PetStep.sex
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ItemPetType(
                          icon: const Icon(
                            Icons.male,
                            size: 80,
                          ),
                          onTap: () {
                            controller.petModel.value.sex = 'Male';
                            controller.petModel.refresh();
                          },
                          type: 'Male',
                          typeSelect: 'Sex',
                        ),
                        ItemPetType(
                          icon: const Icon(
                            Icons.female,
                            size: 80,
                          ),
                          onTap: () {
                            controller.petModel.value.sex = 'Female';
                            controller.petModel.refresh();
                          },
                          type: 'Female',
                          typeSelect: 'Sex',
                        ),
                      ],
                    )
                  : controller.petStepToCreate.value == PetStep.birthDate
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () async => controller.dateTimeToBirthDate
                                  .value = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              ),
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.h),
                                  color: Colors.grey[300],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.calendar_month,
                                    size: 80,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              controller.dateTimeToBirthDate.value ==
                                      DateTime(2000)
                                  ? ''
                                  : controller.convertDateTimeToString(),
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                          ],
                        )
                      : controller.petStepToCreate.value == PetStep.other
                          ? Column(
                              children: [
                                InputCustom.base(
                                  controller: controller.breedController,
                                  hint: 'Raza',
                                ),
                                SizedBox(height: 1.h),
                                InputCustom.base(
                                  controller: controller.furController,
                                  hint: 'Pelaje',
                                ),
                              ],
                            )
                          : controller.petStepToCreate.value == PetStep.last
                              ? Column(
                                  children: [
                                    InputCustom.base(
                                      controller: controller.sizeController,
                                      hint: 'Tamaño',
                                    ),
                                    SizedBox(height: 1.h),
                                    InputCustom.base(
                                      controller: controller.weigthController,
                                      hint: 'Peso',
                                      textInputType: TextInputType.number,
                                    ),
                                  ],
                                )
                              : controller.petStepToCreate.value ==
                                      PetStep.check
                                  ? const CheckItemsPV()
                                  : Container(),
    );
  }
}
