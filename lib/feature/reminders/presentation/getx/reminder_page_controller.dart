import 'dart:developer';

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
      for (var pet in lsPets) {
        PetModel petModel = pet;
        List<Event> lsEvents = [];
        if (pet.reminders.isNotEmpty) {
          for (var reminderId in pet.reminders) {
            isSearchingReminder.value = true;
            lsEvents.add(await reminderController.getReminderData(reminderId));
            log('-------------- trajo los de ${petModel.name} --------------');
          }
        }
        isSearchingReminder.value = false;
        lsPetReminders.add(PetReminder(petModel: petModel, lsEvents: lsEvents));
      }
    });
    super.onInit();
  }
}
