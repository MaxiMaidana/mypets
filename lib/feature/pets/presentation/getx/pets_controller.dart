import 'dart:developer';

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
        for (var id in pet.remindersId) {
          final event = await _reminderController.getReminderData(id);
          pet.lsEvents!.add(event);
        }
      }
      isSearchingReminders.value = false;
      // _reminderController.page
      log('=========termino todo el tramite de mascotas=========');
      // chargelsReminders
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

  @override
  void onInit() {
    getPets();
    super.onInit();
  }
}
