import 'package:mypets/data/datasource/firebase_datasource.dart';

import '../../../../data/models/user/user_model.dart';

class RegisterProvider {
  Future<void> addUSer(String uid, UserModel userModel) async {
    try {
      await FirebaseDatasource(collection: 'users')
          .postData(uid: uid, data: userModel.toJson());
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
