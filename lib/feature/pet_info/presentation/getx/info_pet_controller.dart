import 'package:get/get.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

class PetInfoController extends GetxController {
  late String petId;
  final PetsController petsController = Get.find();

  late PetModel _petModel;

  void setPetId(String id) => petId = id;

  setPetModel(PetModel petModel) => _petModel = petModel;

  PetModel get selectPet => _petModel;

  @override
  void onInit() {
    super.onInit();
  }
}
