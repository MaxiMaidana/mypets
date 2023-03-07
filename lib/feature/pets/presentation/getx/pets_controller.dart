import 'dart:developer';

import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';

class PetsController extends GetxController {
  RxList<PetModel> petsLs = <PetModel>[].obs;
  RxBool isChargingPets = false.obs;

  Future<void> getPets() async {
    try {
      // change(null, status: RxStatus.loading());
      isChargingPets.value = true;
      // petsLs.addAll(await PetsRepository().getPets());
      isChargingPets.value = false;
      // change(petsLs, status: RxStatus.success());
      // change([], status: RxStatus.empty());
    } catch (e) {
      isChargingPets.value = false;
      rethrow;
    }
  }

  @override
  void onInit() {
    getPets();
    super.onInit();
  }
}
