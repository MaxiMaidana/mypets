import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/info_pet/presentation/getx/info_pet_controller.dart';
import 'package:sizer/sizer.dart';

import '../pet_info_item.dart';

class RowPetInfoPV extends GetWidget<InfoPetController> {
  const RowPetInfoPV({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> lsWidgets = [
      SizedBox(width: 5.w),
      Obx(
        () => PetInfoItem(
          title: 'Edad',
          info: controller.petYears.value.toString(),
        ),
      ),
      if (controller.selectPet.value.breed != '')
        Obx(
          () => PetInfoItem(
            title: 'Raza',
            info: controller.selectPet.value.breed!,
          ),
        ),
      if (controller.selectPet.value.fur != '')
        Obx(
          () => PetInfoItem(
            title: 'Pelaje',
            info: controller.selectPet.value.fur!,
          ),
        ),
      if (controller.selectPet.value.size != '')
        Obx(
          () => PetInfoItem(
            title: 'Tamaño',
            info: controller.selectPet.value.size!,
          ),
        ),
      if (controller.selectPet.value.weigth != '')
        Obx(
          () => PetInfoItem(
            title: 'Peso',
            info: '${controller.selectPet.value.weigth!} Kg',
          ),
        ),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: lsWidgets,
      ),
    );
  }
}
