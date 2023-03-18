import 'dart:developer';

import 'package:path/path.dart';

import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/response_model.dart';

class InfoPetProvider {
  Future<String> urlImagePet(String imageName) async {
    try {
      String urlImage = '';
      ResponseModel responseModel = await FirebaseDatasource()
          .urlImageStorage(folderName: 'pets', imageName: '$imageName.jpg');
      if (responseModel.data != null) {
        urlImage = responseModel.data as String;
      }
      log(urlImage);
      return urlImage;
    } catch (e) {
      rethrow;
    }
  }
}
