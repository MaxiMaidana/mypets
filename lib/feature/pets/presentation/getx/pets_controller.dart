import 'dart:developer';

import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';

import '../../domain/data/pets_repository.dart';

class PetsController extends GetxController with StateMixin {
  RxList<PetModel> petsLs = <PetModel>[].obs;
  RxBool isChargingPets = false.obs;

  Future<void> getPets() async {
    try {
      change(null, status: RxStatus.loading());
      petsLs.addAll(await PetsRepository().getPets());
      change(petsLs, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.empty());
      rethrow;
    }
  }

  @override
  void onInit() {
    getPets();
    super.onInit();
  }
}
