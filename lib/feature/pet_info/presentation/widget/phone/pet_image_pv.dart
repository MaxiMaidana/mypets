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
      height: 100.h,
      child: CachedNetworkImage(
        alignment: Alignment.topCenter,
        imageUrl:
            'https://www.mundoperro.net/wp-content/uploads/Cocker-Spaniel-Ingles-1200x900.jpg',
        height: 40.h,
      ),
    );
  }
}
