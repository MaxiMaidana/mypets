import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/data/models/response_model.dart';

import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/user/user_model.dart';

class NewPetProvider {
  Future<PetModel> addNewPet(String uid, PetModel petModel) async {
    try {
      ResponseModel responseModel = await FirebaseDatasource(collection: 'pets')
          .postData(data: petModel.toJson());
      Map<String, dynamic> res = responseModel.data as Map<String, dynamic>;
      return PetModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserData(uid, UserModel userModel) async {
    try {
      await FirebaseDatasource(collection: 'users')
          .putData(uid: uid, data: userModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
