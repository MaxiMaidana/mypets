import 'dart:io';

import '../models/response_model.dart';

abstract class FirebaseDatasourceRepository {
  Future<ResponseModel> getAllData();
  Future<ResponseModel> getDataById({required String id});
  Future<ResponseModel> postData(
      {String? uid, required Map<String, dynamic> data});
  Future<ResponseModel> putData(
      {required String uid, required Map<String, dynamic> data});
  Future<ResponseModel> deleteData({required String id});
  Future<ResponseModel> urlImageStorage(
      {required String folderName, required String imageName});
  Future<ResponseModel> postImageFile(
      {required File file, required String filePath});
}
