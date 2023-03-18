import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

import '../../domain/provider/info_pet_provider.dart';

class PetInfoController extends GetxController {
  late String petId;
  final PetsController petsController = Get.find();
  final AppController appController = Get.find();
  final InfoPetProvider _infoPetProvider = InfoPetProvider();

  late PetModel _petModel;
  RxBool isSearchPhoto = false.obs;
  RxString urlImagePet = ''.obs;

  void setPetId(String id) => petId = id;

  setPetModel(PetModel petModel) => _petModel = petModel;

  PetModel get selectPet => _petModel;

  Future<void> getUrlImage() async {
    try {
      isSearchPhoto.value = true;
      urlImagePet.value = await _infoPetProvider
          .urlImagePet('${appController.userModel!.dni}$petId');
      isSearchPhoto.value = false;
    } catch (e) {
      isSearchPhoto.value = false;
      return;
    }
  }

  @override
  void onInit() {
    getUrlImage();
    super.onInit();
  }
}
