import '../models/response_model.dart';

abstract class FirebaseDatasourceRepository {
  Future<ResponseModel> getAllData();
  Future<ResponseModel> getDataById({required String id});
  Future<ResponseModel> postData(
      {required String uid, required Map<String, dynamic> data});
  Future<ResponseModel> putData(
      {required String uid, required Map<String, dynamic> data});
  Future<ResponseModel> deleteData({required String id});
}
