import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

import 'item_pet_type_pv.dart';

class CheckItemsPV extends GetWidget<NewPetController> {
  const CheckItemsPV({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${controller.nameController.text} es',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ItemPetType(
                icon: FaIcon(
                  controller.petModel.value.species == 'Dog'
                      ? FontAwesomeIcons.dog
                      : FontAwesomeIcons.cat,
                  size: 30,
                ),
                onTap: () {},
                type: '',
                typeSelect: 'Specie',
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 50,
              width: 50,
              child: ItemPetType(
                icon: Icon(
                  controller.petModel.value.sex == 'Male'
                      ? Icons.male
                      : Icons.female,
                  size: 30,
                ),
                onTap: () {},
                type: '',
                typeSelect: 'Sex',
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        _rowItem(context, 'Nacio el:', controller.petModel.value.birthDate),
        _rowItem(context, 'Raza:', controller.breedController.text),
        _rowItem(context, 'Tamaño:', controller.sizeController.text),
        _rowItem(context, 'Pelaje:', controller.furController.text),
        _rowItem(context, 'Peso:', controller.weigthController.text),
      ],
    );
  }

  Widget _rowItem(BuildContext context, String left, String data) {
    return data != ''
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      left,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 50.w,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xFF6750A4).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
            ],
          )
        : Container();
  }
}
