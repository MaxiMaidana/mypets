import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypets/data/models/error_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/response_model.dart';
import '../repository/firebase_datasource_repository.dart';

class FirebaseDatasource implements FirebaseDatasourceRepository {
  final String? collection;
  late CollectionReference _collectionReference;

  FirebaseDatasource({this.collection}) {
    if (collection != null) {
      _collectionReference = FirebaseFirestore.instance.collection(collection!);
    }
  }

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
          if (map['id'] != item.id) {
            map['id'] = item.id;
            await putData(uid: item.id, data: map);
            lsRes.add(map);
          } else {
            lsRes.add(map);
          }
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
      {String? uid, required Map<String, dynamic> data}) async {
    try {
      if (uid != null) {
        await _collectionReference.doc(uid).set(data);
      } else {
        DocumentReference documentReference =
            await _collectionReference.add(data);
        Map<String, dynamic> newData = data;
        newData['id'] = documentReference.id;
        await putData(uid: documentReference.id, data: data);
      }
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

  @override
  Future<ResponseModel> urlImageStorage(
      {required String folderName, required String imageName}) async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('$folderName/$imageName');
      final String urlImage = await storageRef.getDownloadURL();
      return ResponseModel(code: 200, data: urlImage);
    } catch (e) {
      throw ErrorModel(
        code: 'Error',
        message: 'No se pudo traer la url de la imagen: $folderName/$imageName',
      );
    }
  }

  @override
  Future<ResponseModel> postImageFile(
      {required File file, required String filePath}) async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child(filePath);
      TaskSnapshot uploadTask = await storageRef.putFile(file);
      if (uploadTask.state == TaskState.success) {
        String urlDownload = await uploadTask.ref.getDownloadURL();
        return ResponseModel(code: 200, data: urlDownload);
      }
      throw ErrorModel(
        code: 'Error',
        message: 'No se pudo traer la data de la collection: $collection',
      );
    } catch (e) {
      throw ErrorModel(
        code: 'Error',
        message: 'No se pudo traer la url de la imagen: $filePath',
      );
    }
  }
}
