import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/pet/pet_model.dart';

class PetsProvider {
  Future<List<PetModel>> getPets() async {
    List<PetModel> lsRes = [];
    final data =
        await rootBundle.loadString('lib/data/data_fake/mascotas.json');
    var dataMap = json.decode(data);
    lsRes = List<PetModel>.from(dataMap.map((x) => PetModel.fromJson(x)));
    return lsRes;
    // CredentialsModel credentialModels = PetModel.fromJson(dataMap);
  }

  Future<void> deleteNewPet(String uid, PetModel petModel) async {
    try {
      await FirebaseDatasource('pets')
          .postData(uid: uid, data: petModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNewPet(String uid, PetModel petModel) async {
    try {
      await FirebaseDatasource('pets')
          .postData(uid: uid, data: petModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
