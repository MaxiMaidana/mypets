import 'dart:developer';

import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/pets/domain/provider/pets_provider.dart';

import '../../../pet_info_support/presentation/getx/pet_info_support_controller.dart';

class PetsController extends GetxController {
  final PetsProvider _petsProvider = PetsProvider();
  RxList<PetModel> petsLs = <PetModel>[].obs;
  RxBool isChargingPets = false.obs;

  final petInfoSupportController = Get.find<PetInfoSupportController>();

  Future<void> getPets() async {
    try {
      petsLs.clear();
      // change(null, status: RxStatus.loading());
      isChargingPets.value = true;
      petsLs.addAll(await _petsProvider.getPets());
      isChargingPets.value = false;
      // change(petsLs, status: RxStatus.success());
      // change([], status: RxStatus.empty());
    } catch (e) {
      isChargingPets.value = false;
      rethrow;
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
