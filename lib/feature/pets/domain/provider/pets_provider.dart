import 'package:mypets/data/models/response_model.dart';

import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/pet/pet_model.dart';

class PetsProvider {
  Future<List<PetModel>> getPets({required List<String> lsPetsId}) async {
    List<PetModel> lsRes = [];
    // final data =
    //     await rootBundle.loadString('lib/data/data_fake/mascotas.json');
    // var dataMap = json.decode(data);
    // lsRes = List<PetModel>.from(dataMap.map((x) => PetModel.fromJson(x)));
    for (var id in lsPetsId) {
      ResponseModel responseModel =
          await FirebaseDatasource(collection: 'pets').getDataById(id: id);
      Map<String, dynamic> res = responseModel.data as Map<String, dynamic>;
      lsRes.add(PetModel.fromJson(res));
    }
    // if (responseModel.data != null) {
    //   List res = responseModel.data as List;
    //   for (var item in res) {
    //     lsRes.add(PetModel.fromJson(item));
    //   }
    // }
    return lsRes;
    // CredentialsModel credentialModels = PetModel.fromJson(dataMap);
  }

  Future<void> deleteNewPet(String uid, PetModel petModel) async {
    try {
      await FirebaseDatasource(collection: 'pets')
          .postData(uid: uid, data: petModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNewPet(String uid, PetModel petModel) async {
    try {
      await FirebaseDatasource(collection: 'pets')
          .postData(uid: uid, data: petModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
