import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypets/data/models/error_model.dart';

import '../models/response_model.dart';
import '../repository/firebase_datasource_repository.dart';

class FirebaseDatasource implements FirebaseDatasourceRepository {
  final String collection;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseDatasource(this.collection)
      : _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ResponseModel> deleteData({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> getAllData() async {
    try {
      List lsRes = [];
      CollectionReference collectionReference =
          _firebaseFirestore.collection(collection);
      QuerySnapshot res = await collectionReference.get();
      if (res.docs.isNotEmpty) {
        lsRes.addAll(res.docs);
        return ResponseModel(code: 200, data: lsRes);
      }
      throw ErrorModel(
        code: 'Error',
        message: 'No se pudo traer la data de la collection: $collection',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> postData({required Object data}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> putData({required Object data}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> getDataById({required String id}) {
    throw UnimplementedError();
  }
}
