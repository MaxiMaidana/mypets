import 'package:mypets/data/models/pet/pet_model.dart';

import '../../../../data/datasource/firebase_datasource.dart';

class NewPetProvider {
  Future<void> addNewPet(String uid, PetModel petModel) async {
    try {
      await FirebaseDatasource(collection: 'pets')
          .postData(uid: uid, data: petModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
