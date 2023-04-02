import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart' as calendarEvent;
import 'package:sizer/sizer.dart';

import '../../../info_pet/presentation/getx/info_pet_controller.dart';

class ReminderItem extends GetWidget<PetInfoController> {
  final calendarEvent.Event event;
  const ReminderItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String title = event.summary!.split('-').first.trim();
    Color cardColor = title == 'Peluqueria'
        ? Theme.of(context).primaryColor.withOpacity(0.8)
        : title == 'Remedio'
            ? const Color.fromARGB(255, 76, 180, 90).withOpacity(0.8)
            : title == 'Control'
                ? Colors.deepOrange.withOpacity(0.8)
                : Colors.grey.withOpacity(0.8);
    String initTime =
        '${event.start!.dateTime!.hour}:${event.start!.dateTime!.minute.toString().length == 1 ? _time(event.start!.dateTime!.minute) : event.start!.dateTime!.minute}';
    String finishTime =
        '${event.end!.dateTime!.hour}:${event.end!.dateTime!.minute.toString().length == 1 ? _time(event.end!.dateTime!.minute) : event.end!.dateTime!.minute}';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Container(
            width: 70.w,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding:
                const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 5),
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
                          color: cardColor,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                          '$initTime: - $finishTime',
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
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  String _time(int data) => '0$data';
}
