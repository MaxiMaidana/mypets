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
  // List<String> oldReminders = [];
  // List<String> remindersCharged = [];
  // List<String> petIdCharged = [];

  void chargeLsReminders() {
    isSearchingReminder.value = true;
    for (PetModel pet in petsController.petsLs) {
      if (pet.lsEvents!.isNotEmpty) {
        lsPetReminders.add(PetReminder(
            idPet: pet.id!, name: pet.name, lsEvents: pet.lsEvents!));
      }
    }
    isSearchingReminder.value = false;
  }

  void updateLsReminders(String id, String name, Event event) {
    // bool reminderCharged = false;

    for (var petReminder in lsPetReminders) {
      if (petReminder.idPet == id) {
        _addEventToList(petReminder, event);
        // reminderCharged = true;
      }
    }
    // if (!reminderCharged) {
    //   _addEventToList(
    //       PetReminder(idPet: id, name: name, lsEvents: const []), event);
    // }
  }

  void _addEventToList(PetReminder petReminder, Event event) {
    isSearchingReminder.value = true;
    petReminder.lsEvents.add(event);
    isSearchingReminder.value = false;
  }

  @override
  void onReady() {
    petsController.isSearchingReminders.listen((event) {
      if (!event) {
        chargeLsReminders();
      }
    });
    super.onReady();
  }

  // @override
  // void onInit() {
  //   petsController.petsLs.listen((lsPets) async {
  //     for (PetModel pet in lsPets) {
  //       List<Event> lsEvents = [];
  //       if (pet.remindersId.isNotEmpty) {
  //         if (!remindersCharged.contains(pet.id)) {
  //           for (var reminderId in pet.remindersId) {
  //             isSearchingReminder.value = true;
  //             Event eventRes =
  //                 await reminderController.getReminderData(reminderId);
  //             if (checkISValidDateTimeEvent(eventRes.end!.dateTime!)) {
  //               lsEvents.add(eventRes);
  //               remindersCharged.add(pet.id!);
  //             } else {
  //               oldReminders.add(reminderId);
  //             }
  //           }
  //           if (oldReminders.isNotEmpty) {
  //             PetModel petModel = pet;
  //             for (String oldReminder in oldReminders) {
  //               petModel.remindersId
  //                   .removeWhere((element) => element == oldReminder);
  //             }
  //             await petsController.updatePet(pet.id!, petModel);
  //             oldReminders.clear();
  //           }
  //           isSearchingReminder.value = false;
  //           reminderController.petsReminders[pet] = lsEvents;
  //           lsPetReminders.add(PetReminder(petModel: pet, lsEvents: lsEvents));
  //         }
  //       }
  //     }
  //   });
  //   super.onInit();
  // }

  bool checkISValidDateTimeEvent(DateTime toEvaluate) {
    DateTime now = DateTime.now();
    if (toEvaluate.year > now.year) {
      return true;
    }
    if (toEvaluate.day > now.day && toEvaluate.month <= now.month) {
      return true;
    }
    if (toEvaluate.day < now.day && toEvaluate.month <= now.month) {
      return false;
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
