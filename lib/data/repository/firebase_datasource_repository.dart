import '../models/response_model.dart';

abstract class FirebaseDatasourceRepository {
  Future<ResponseModel> getAllData();
  Future<ResponseModel> getDataById({required String id});
  Future<ResponseModel> postData({required Object data});
  Future<ResponseModel> putData({required Object data});
  Future<ResponseModel> deleteData({required String id});
}
