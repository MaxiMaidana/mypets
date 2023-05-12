import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mypets/feature/reminders/presentation/getx/reminder_controller.dart';

import '../../../../data/models/pet/pet_model.dart';
import '../../../pets/presentation/getx/pets_controller.dart';
import '../../domain/model/pet_reminder.dart';

class ReminderPageController extends GetxController {
  final PetsController petsController = Get.find();
  final ReminderController reminderController = Get.find();

  RxList<PetReminder> lsPetReminders = <PetReminder>[].obs;
  RxBool isSearchingReminder = false.obs;

  @override
  void onInit() {
    petsController.petsLs.listen((lsPets) async {
      for (PetModel pet in lsPets) {
        // PetModel petModel = pet;
        List<Event> lsEvents = [];
        if (pet.reminders.isNotEmpty) {
          for (var reminderId in pet.reminders) {
            isSearchingReminder.value = true;
            Event eventRes =
                await reminderController.getReminderData(reminderId);
            if (checkISValidDateTimeEvent(eventRes.end!.dateTime!)) {
              lsEvents.add(eventRes);
            } else {
              log('se tendria que eliminar algo aca de ${pet.name}');
              // PetModel petModel = pet;
              // petModel.reminders
              //     .removeWhere((element) => element == reminderId);
              // await petsController.updatePet(pet.id!, petModel);
            }
            log('-------------- trajo los recordatorios de ${pet.name} --------------');
          }
        }
        isSearchingReminder.value = false;
        reminderController.petsReminders[pet] = lsEvents;
        lsPetReminders.add(PetReminder(petModel: pet, lsEvents: lsEvents));
      }
    });
    super.onInit();
  }

  bool checkISValidDateTimeEvent(DateTime toEvaluate) {
    DateTime now = DateTime.now();
    if (toEvaluate.year > now.year) {
      return true;
    }
    if (toEvaluate.day > now.day && toEvaluate.month <= now.month) {
      return true;
    }
    if (toEvaluate.day < now.day && toEvaluate.month < now.month) {
      return true;
    }
    TimeOfDay timeNow = TimeOfDay.now();
    if (timeNow.hour > toEvaluate.hour) {
      return true;
    }
    if (timeNow.minute > toEvaluate.hour) {
      return true;
    }
    return false;
  }
}
