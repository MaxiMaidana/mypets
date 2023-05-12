import 'dart:developer';

import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/firebase/getx/firebase_controller.dart';
import 'package:mypets/feature/pets/domain/provider/pets_provider.dart';

import '../../../info_pet_support/presentation/getx/pet_info_support_controller.dart';

class PetsController extends GetxController {
  final PetsProvider _petsProvider = PetsProvider();
  RxList<PetModel> petsLs = <PetModel>[].obs;
  RxBool isChargingPets = false.obs;

  final petInfoSupportController = Get.find<PetInfoSupportController>();
  final _appController = Get.find<AppController>();
  final _firebaseController = Get.find<FirebaseController>();

  Future<void> getPets() async {
    try {
      petsLs.clear();
      if (_appController.userModel == null) {
        await _appController
            .getUserData(_firebaseController.firebaseAuth.currentUser!.uid);
      }
      isChargingPets.value = true;
      log('se traen todas las mascotas');
      petsLs.addAll(await _petsProvider.getPets(
          lsPetsId: _appController.userModel!.pets));
      isChargingPets.value = false;
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
