import 'package:mypets/data/datasource/firebase_datasource.dart';

import '../../../../data/models/response_model.dart';
import '../../../../data/models/user/user_model.dart';

class RegisterProvider {
  Future<UserModel> addUSer(String uid, UserModel userModel) async {
    try {
      ResponseModel responseModel =
          await FirebaseDatasource(collection: 'users')
              .postData(uid: uid, data: userModel.toJson());
      Map<String, dynamic> res = responseModel.data as Map<String, dynamic>;
      return UserModel.fromJson(res);
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
