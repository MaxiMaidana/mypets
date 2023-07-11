import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/firebase/getx/firebase_controller.dart';
import 'package:mypets/feature/pets/domain/provider/pets_provider.dart';

import '../../../info_pet_support/presentation/getx/pet_info_support_controller.dart';
import '../../../reminders/presentation/getx/reminder_controller.dart';

class PetsController extends GetxController {
  final PetsProvider _petsProvider = PetsProvider();
  RxList<PetModel> petsLs = <PetModel>[].obs;
  RxBool isChargingPets = false.obs;
  RxBool isSearchingReminders = false.obs;

  final petInfoSupportController = Get.find<PetInfoSupportController>();
  final _appController = Get.find<AppController>();
  final _firebaseController = Get.find<FirebaseController>();
  final _reminderController = Get.find<ReminderController>();

  Future<void> getPets() async {
    try {
      log('=========se pide info de mascotas=========');
      petsLs.clear();
      if (_appController.userModel == null) {
        await _appController
            .getUserData(_firebaseController.firebaseAuth.currentUser!.uid);
      }
      isChargingPets.value = true;
      petsLs.addAll(await _petsProvider.getPets(
          lsPetsId: _appController.userModel!.pets));
      isChargingPets.value = false;
      isSearchingReminders.value = true;
      for (var pet in petsLs) {
        if (pet.remindersId.isNotEmpty) {
          for (var id in pet.remindersId) {
            final eventRes = await _reminderController.getReminderData(id);
            if (checkISValidDateTimeEvent(eventRes.end!.dateTime!)) {
              pet.lsEvents!.add(eventRes);
            } else {
              log('entro por el else ${pet.name} con ${pet.lsEvents!.length}');
              pet.lsEvents!.removeWhere((event) => event.id == eventRes.id);
              await updatePet(pet.id!, pet);
            }
          }
        }
      }
      isSearchingReminders.value = false;
      log('=========termino todo el tramite de mascotas=========');
    } catch (e) {
      isChargingPets.value = false;
      rethrow;
    }
  }

  Future<void> updatePet(String uid, PetModel petModel) async {
    try {
      await _petsProvider.updateNewPet(uid, petModel);
    } catch (e) {
      return;
    }
  }

  PetModel searchPet(String id) =>
      petsLs.firstWhere((element) => element.id == id);

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

  @override
  void onInit() {
    getPets();
    super.onInit();
  }
}
