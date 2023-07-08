import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../getx/info_pet_controller.dart';

class RowTitlePV extends GetWidget<InfoPetController> {
  const RowTitlePV({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w),
      child: Row(
        children: [
          Obx(
            () => Text(
              controller.selectedPet.value.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(width: 10),
          controller.selectedPet.value.species == 'Perro'
              ? const FaIcon(FontAwesomeIcons.dog)
              : const FaIcon(FontAwesomeIcons.cat),
          const SizedBox(width: 10),
          controller.selectedPet.value.sex == 'Macho'
              ? const Icon(Icons.male)
              : const Icon(Icons.female),
          // const Spacer(),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     decoration: BoxDecoration(
          //       color: Colors.grey[300],
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: const Icon(Icons.delete),
          //   ),
          // ),
        ],
      ),
    );
  }
}
