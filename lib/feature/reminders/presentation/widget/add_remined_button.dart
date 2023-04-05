import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/reminders/presentation/getx/reminder_controller.dart';
import 'package:sizer/sizer.dart';

class AddReminderButton extends GetWidget<ReminderController> {
  const AddReminderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.heightTotal.value = 75.h,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Container(
          width: 70.w,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Agregar recordatorio',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Icon(
                Icons.edit_calendar_rounded,
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
