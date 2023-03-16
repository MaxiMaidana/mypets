import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';
import 'package:sizer/sizer.dart';

import 'add_pet_button.dart';
import 'pet_item.dart';

class PetList extends GetWidget<PetsController> {
  const PetList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...List.generate(
            controller.petsLs.length,
            (i) => PetItem(petModel: controller.petsLs[i]),
          ),
          const AddPetButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
