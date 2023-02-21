import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mypets/feature/firebase/data/model/user_model.dart';
import 'package:provider/provider.dart';

class FirebaseDatasource {
  final String collection;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseDatasource({required this.collection})
      : _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> getUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('3XhyrOrTM1aWOTZt0qhtte9B67I2')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document data: ${documentSnapshot.data()}');
        } else {
          print('Document does not exist on the database');
        }
      });

      // log(eee.);

      // UserModel userModel =
      //     UserModel.fromJson(snapshot.value as Map<String, dynamic>);
      // return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
