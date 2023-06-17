import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../reminders/presentation/widget/add_remined_button.dart';
import '../../../../reminders/presentation/widget/reminter_item.dart';
import '../../getx/info_pet_controller.dart';

class RowRemindersPV extends GetWidget<InfoPetController> {
  const RowRemindersPV({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            'Recordatorios',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => !controller.isSearchingReminder.value
                ? controller.lsEvents.isNotEmpty
                    ? Row(
                        children: [
                          SizedBox(width: 5.w),
                          ...List.generate(
                              controller.lsEvents.length,
                              (i) => ReminderItem(
                                  event: controller.lsEvents[i],
                                  petModel: controller.selectPet.value)),
                          const AddReminderButton(),
                          const SizedBox(width: 10),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(width: 5.w),
                          const AddReminderButton(),
                          const SizedBox(width: 10),
                        ],
                      )
                : _shimmer(),
          ),
        ),
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
