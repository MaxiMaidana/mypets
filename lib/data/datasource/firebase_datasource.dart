import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypets/data/models/error_model.dart';

import '../models/response_model.dart';
import '../repository/firebase_datasource_repository.dart';

class FirebaseDatasource implements FirebaseDatasourceRepository {
  final String collection;
  final CollectionReference _collectionReference;

  FirebaseDatasource(this.collection)
      : _collectionReference =
            FirebaseFirestore.instance.collection(collection);

  @override
  Future<ResponseModel> deleteData({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> getAllData() async {
    try {
      List lsRes = [];
      QuerySnapshot res = await _collectionReference.get();
      if (res.docs.isNotEmpty) {
        for (var item in res.docs) {
          Map<String, dynamic> map = item.data() as Map<String, dynamic>;
          map['id'] = item.id;
          lsRes.add(map);
        }
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
  Future<ResponseModel> postData(
      {required String uid, required Map<String, dynamic> data}) async {
    try {
      // await _collectionReference.doc(uid).set(data);
      await _collectionReference.add(data);
      return ResponseModel(
          code: 200, data: 'Se creo el registro de manera correcta');
    } catch (e) {
      log('No se pudo agregar el registro');
      rethrow;
    }
  }

  @override
  Future<ResponseModel> putData(
      {required String uid, required Map<String, dynamic> data}) async {
    try {
      await _collectionReference.doc(uid).update(data);
      return ResponseModel(
          code: 200, data: 'Se modifico el registro de manera correcta');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> getDataById({required String id}) async {
    try {
      DocumentSnapshot res = await _collectionReference.doc(id).get();
      if (res.exists) {
        return ResponseModel(code: 200, data: res.data());
      }
      throw ErrorModel(
        code: 'Error',
        message: 'No se pudo traer la data de la collection: $collection',
      );
    } catch (e) {
      rethrow;
    }
  }
}
