import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

class InfoPetController extends GetxController {
  late int petId;
  final PetsController petsController = Get.find();

  late PetModel _petModel;

  void setPetId(String id) => petId = int.parse(id);

  setPetModel() => _petModel = petsController.petsLs[petId - 1];

  PetModel get selectPet => _petModel;

  @override
  void onInit() {
    super.onInit();
  }
}
