import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:sizer/sizer.dart';

import '../../../reminders/presentation/widget/phone/reminder_buttonsheet_pv.dart';
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
        if (controller.reminderController.heightTotal.value > 0.0) {
          controller.reminderController.cleanAllData();
        } else {
          context.pop();
          Get.delete<PetInfoController>();
        }
        return false;
      },
      child: GestureDetector(
        onTap: () => controller.reminderController.cleanAllData(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 100.h,
                child: Stack(
                  children: [
                    const PetImagePV(),
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: GestureDetector(
                        onTap: () {
                          if (controller.reminderController.heightTotal.value >
                              0.0) {
                            controller.reminderController.heightTotal.value =
                                0.0;
                          } else {
                            context.pop();
                            Get.delete<PetInfoController>();
                          }
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
                        height: 78.h,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const RowPetInfoPV(),
                            const SizedBox(height: 10),
                            Divider(
                                endIndent: 5.w,
                                indent: 5.w,
                                color: Colors.black),
                            const SizedBox(height: 10),
                            const RowRemindersPV(),
                            SizedBox(height: Get.height < 720 ? 30 : 8.5.h),
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
                                onPress: () => context.push(Uri(
                                    path: Routes.editInfoPet,
                                    queryParameters: {
                                      'id': controller.selectPet.id.toString()
                                    }).toString()),
                              ),
                            ),
                            // SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: ReminderButtonSheetPV(petName: controller.selectPet.name),
            ),
          ],
        ),
      ),
    );
  }
}
