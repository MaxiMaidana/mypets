import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../getx/info_pet_controller.dart';

class ReminderItem extends GetWidget<PetInfoController> {
  const ReminderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 1.5.h, left: 4.w, bottom: 1.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.pills,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 5.w),
                  Text('Dar Remedio',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Text(
                'Todos los días',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black.withOpacity(0.5)),
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.clock),
                  SizedBox(width: 2.5.w),
                  Text(
                    '10:00 - 10:30',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_active),
                  SizedBox(width: 2.5.w),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
