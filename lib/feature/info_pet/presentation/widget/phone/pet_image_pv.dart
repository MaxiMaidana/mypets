import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../getx/info_pet_controller.dart';

class PetImagePV extends GetWidget<PetInfoController> {
  const PetImagePV({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: Obx(
        () => controller.isSearchPhoto.value
            ? const SizedBox(
                width: double.infinity,
              )
            : controller.urlImagePet.value != ''
                ? CachedNetworkImage(
                    alignment: Alignment.topCenter,
                    imageUrl: controller.urlImagePet.value,
                    // imageUrl:
                    //     "https://www.mundoperro.net/wp-content/uploads/Cocker-Spaniel-Ingles-1200x900.jpg",
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    width: double.infinity,
                    child: Text('carga foto pa'),
                  ),
      ),
    );
  }
}
