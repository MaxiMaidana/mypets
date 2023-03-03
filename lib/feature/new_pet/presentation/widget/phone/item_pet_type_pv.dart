import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

class ItemPetType extends GetWidget<NewPetController> {
  final Widget icon;
  final Function() onTap;
  final String type;
  final String typeSelect;
  const ItemPetType({
    super.key,
    required this.icon,
    required this.onTap,
    required this.type,
    required this.typeSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.h),
            color: typeSelect == 'Sex'
                ? controller.petModel.value.sex == type
                    ? Colors.green
                    : Colors.transparent
                : controller.petModel.value.type == type
                    ? Colors.green
                    : Colors.transparent,
          ),
          child: Container(
              height: 135,
              width: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.h),
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
              child: Center(child: icon)),
        ),
      ),
    );
  }
}
