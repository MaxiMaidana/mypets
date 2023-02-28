import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';
import 'package:mypets/feature/pets/presentation/widget/message_without_pets.dart';
import 'package:mypets/feature/pets/presentation/widget/pet_list.dart';
import 'package:sizer/sizer.dart';

import '../widget/add_pet_button.dart';

class PetsPhoneView extends GetView<PetsController> {
  const PetsPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Obx(
              () => controller.isChargingPets.value
                  ? const CircularProgressIndicator()
                  : controller.petsLs.isEmpty
                      ? const MessageWithoutPets()
                      : const PetList(),
            ),
            Obx(
              () => controller.isChargingPets.value
                  ? Container()
                  : !controller.isChargingPets.value &&
                          controller.petsLs.isNotEmpty
                      ? Container()
                      : const AddPetButton(),
            ),
          ],
        ),
      ),
    );
  }
}
