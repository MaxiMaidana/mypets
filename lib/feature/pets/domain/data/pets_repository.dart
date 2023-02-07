import 'dart:convert';
import 'package:flutter/services.dart';

import '../model/pet_model.dart';

class PetsRepository {
  Future<List<PetModel>> getPets() async {
    List<PetModel> lsRes = [];
    final data =
        await rootBundle.loadString('lib/data/data_fake/mascotas.json');
    var dataMap = json.decode(data);
    lsRes = List<PetModel>.from(dataMap.map((x) => PetModel.fromJson(x)));
    return lsRes;
    // CredentialsModel credentialModels = PetModel.fromJson(dataMap);
  }
}
