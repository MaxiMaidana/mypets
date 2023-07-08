import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/reminders/presentation/getx/reminder_page_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../domain/model/pet_reminder.dart';
import '../widget/add_remined_button.dart';
import '../widget/phone/reminder_buttonsheet_pv.dart';
import '../widget/reminter_item.dart';

class RemindersPV extends GetWidget<ReminderPageController> {
  const RemindersPV({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.reminderController.heightTotal.value > 0.0) {
          controller.reminderController.cleanAllData();
        }
        return false;
      },
      child: GestureDetector(
        onTap: () => controller.reminderController.cleanAllData(),
        child: Stack(
          children: [
            SizedBox(
              height: 100.h,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 100.w,
                  child: Obx(
                    () => Column(
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          'Recordatorios',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 40),
                        if (controller.petsController.petsLs.isNotEmpty)
                          ...List.generate(
                            controller.lsPetReminders.length,
                            (i) => _petItem(
                              context,
                              controller.lsPetReminders[i],
                            ),
                          ),
                        controller.petsController.petsLs.length > 4
                            ? const SizedBox(height: 80)
                            : const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 0.0,
              child: ReminderButtonSheetPV(petName: ''),
            ),
          ],
        ),
      ),
    );
  }

  Widget _petItem(BuildContext context, PetReminder petReminder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            petReminder.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Divider(
          color: Colors.black,
          endIndent: 5.w,
          indent: 5.w,
        ),
        Visibility(
          visible: petReminder.lsEvents.isNotEmpty,
          replacement: Row(
            children: [
              SizedBox(width: 5.w),
              const AddReminderButton(),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => !controller.isSearchingReminder.value
                  // ? petReminder.lsEvents.isNotEmpty
                  ? Row(
                      children: [
                        SizedBox(width: 5.w),
                        ...List.generate(
                            petReminder.lsEvents.length,
                            (i) => ReminderItem(
                                event: petReminder.lsEvents[i],
                                petModel: PetModel.init())),
                        const AddReminderButton(),
                        const SizedBox(width: 10),
                      ],
                    )
                  // : Row(
                  //     children: [
                  //       SizedBox(width: 5.w),
                  //       const AddReminderButton(),
                  //       const SizedBox(width: 10),
                  //     ],
                  //   )
                  : _shimmer(),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _shimmer() => Row(
        children: [
          SizedBox(width: 5.w),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.5),
            highlightColor: Colors.white,
            child: Container(
              width: 70.w,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.5),
            highlightColor: Colors.white,
            child: Container(
              width: 70.w,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.5),
            highlightColor: Colors.white,
            child: Container(
              width: 70.w,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
}
