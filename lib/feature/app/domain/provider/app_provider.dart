import 'dart:developer';

import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/response_model.dart';
import '../../../../data/models/user/user_model.dart';

class AppProvider {
  Future<UserModel> getUserData(String uid) async {
    try {
      log('se trae la info del user');
      ResponseModel responseModel =
          await FirebaseDatasource('users').getDataById(id: uid);
      Map<String, dynamic> itemMap = responseModel.data as Map<String, dynamic>;
      return UserModel.fromJson(itemMap);
    } catch (e) {
      rethrow;
    }
  }
}
