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
      if (controller.selectedPet.value.breed != '')
        Obx(
          () => PetInfoItem(
            title: 'Raza',
            info: controller.selectedPet.value.breed!,
          ),
        ),
      if (controller.selectedPet.value.fur != '')
        Obx(
          () => PetInfoItem(
            title: 'Pelaje',
            info: controller.selectedPet.value.fur!,
          ),
        ),
      if (controller.selectedPet.value.size != '')
        Obx(
          () => PetInfoItem(
            title: 'Tamaño',
            info: controller.selectedPet.value.size!,
          ),
        ),
      if (controller.selectedPet.value.weigth != '')
        Obx(
          () => PetInfoItem(
            title: 'Peso',
            info: '${controller.selectedPet.value.weigth!} Kg',
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
