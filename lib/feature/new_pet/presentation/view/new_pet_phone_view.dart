import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';
import 'package:sizer/sizer.dart';

class NewPetsPhoneView extends GetWidget<NewPetController> {
  const NewPetsPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        ElevatedButton(
          onPressed: () => controller.uploadImage(),
          child: const Text('Seleccionar Foto'),
        ),
        Obx(
          () => Visibility(
            visible: controller.petImage.value.path != '',
            child: Image.file(File(controller.petImage.value.path)),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'nombre'),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'raza'),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'edad'),
        ),
      ],
    );
  }
}
