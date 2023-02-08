import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../getx/info_pet_controller.dart';

class InfoPetPhoneView extends GetWidget<InfoPetController> {
  const InfoPetPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        Text('info de la mascota ${controller.selectPet.name}'),
      ],
    );
  }
}
