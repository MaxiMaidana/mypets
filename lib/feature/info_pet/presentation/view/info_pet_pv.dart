import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:sizer/sizer.dart';

import '../getx/info_pet_controller.dart';
import '../widget/phone/pet_image_pv.dart';
import '../widget/phone/row_pet_info_pv.dart';
import '../widget/phone/row_reminders_pv.dart';
import '../widget/phone/row_title_pv.dart';

class InfoPetPV extends GetWidget<PetInfoController> {
  const InfoPetPV({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        Get.delete<PetInfoController>();
        return true;
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: 110.h,
          child: Stack(
            children: [
              const PetImagePV(),
              Padding(
                padding: EdgeInsets.all(5.w),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                    Get.delete<PetInfoController>();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RowTitlePV(),
                      const SizedBox(height: 7),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          controller.selectPet.birthDate,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const RowPetInfoPV(),
                      const SizedBox(height: 10),
                      Divider(endIndent: 5.w, indent: 5.w, color: Colors.black),
                      const SizedBox(height: 10),
                      const RowRemindersPV(),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ButtonCustom.principal(
                          text: 'Datos Veterianrios',
                          onPress: () {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ButtonCustom.principal(
                          text: 'Editar Mascota',
                          onPress: () {},
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
