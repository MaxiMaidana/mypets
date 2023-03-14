import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/pet_info/presentation/getx/info_pet_controller.dart';
import 'package:sizer/sizer.dart';

import '../pet_info_item.dart';

class RowPetInfoPV extends GetWidget<PetInfoController> {
  const RowPetInfoPV({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> lsWidgets = [
      SizedBox(width: 5.w),
      const PetInfoItem(
        title: 'Años',
        info: '14',
      ),
      if (controller.selectPet.breed != '')
        PetInfoItem(
          title: 'Raza',
          info: controller.selectPet.breed!,
        ),
      if (controller.selectPet.fur != '')
        PetInfoItem(
          title: 'Pelaje',
          info: controller.selectPet.fur!,
        ),
      if (controller.selectPet.size != '')
        PetInfoItem(
          title: 'Peso',
          info: controller.selectPet.size!,
        ),
      if (controller.selectPet.weigth != '')
        PetInfoItem(
          title: 'Peso',
          info: '${controller.selectPet.weigth!} Kg',
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
