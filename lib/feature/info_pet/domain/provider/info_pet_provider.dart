import 'dart:developer';
import 'dart:io';

import 'package:mypets/data/models/pet/pet_model.dart';

import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/response_model.dart';

class InfoPetProvider {
  Future<String> urlImagePet(String imageName) async {
    try {
      String urlImage = '';
      ResponseModel responseModel = await FirebaseDatasource()
          .urlImageStorage(folderName: 'pets', imageName: '$imageName.jpeg');
      if (responseModel.data != null) {
        urlImage = responseModel.data as String;
      }
      log(urlImage);
      return urlImage;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> postImagePetFirebase(File file, String filePath) async {
    try {
      String urlImage = '';
      ResponseModel responseModel = await FirebaseDatasource()
          .postImageFile(file: file, filePath: 'pets/$filePath');
      if (responseModel.data != null) {
        urlImage = responseModel.data as String;
      }
      log(urlImage);
      return urlImage;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImagePetFirebase(String filePath) async {
    try {
      ResponseModel responseModel = await FirebaseDatasource()
          .deleteImageFile(filePath: 'pets/$filePath');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePetData(String uid, PetModel petModel) async {
    try {
      await FirebaseDatasource(collection: 'pets')
          .putData(uid: uid, data: petModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
