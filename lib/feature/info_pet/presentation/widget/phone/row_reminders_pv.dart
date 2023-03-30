import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../reminders/presentation/widget/add_remined_button.dart';
import '../../getx/info_pet_controller.dart';

class RowRemindersPV extends GetWidget<PetInfoController> {
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
          child: Row(
            children: [
              SizedBox(width: 5.w),
              const AddReminderButton(),
              const SizedBox(width: 10),
              // const ReminderItem(),
              // const SizedBox(width: 10),
              // const ReminderItem(),
              // const SizedBox(width: 10),
              // const ReminderItem(),
              // const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
