import 'package:get/get.dart';

import '../../../../data/models/pet/pet_model.dart';

class EditInfoPetController extends GetxController {
  late PetModel _petModel;
  setPetModel(PetModel petModel) => _petModel = petModel;
}
