import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mypets/feature/firebase/data/model/user_model.dart';

import '../data/datasource/firebase_datasource.dart';

class FirebaseController extends GetxController {
  late FirebaseAuth _firebaseAuth;

  late CollectionReference _collectionReference;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? _googleSignInAccount;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<bool> loginWithGoogle() async {
    bool res = false;
    try {
      _googleSignInAccount = await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        GoogleSignInAuthentication googleAuth =
            await _googleSignInAccount!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await firebaseAuth.signInWithCredential(credential);
        res = true;
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithGoogleWeb() async {
    bool res = false;
    try {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      await _firebaseAuth.signInWithPopup(authProvider);
      res = true;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithCredentials({
    required String email,
    required String pass,
  }) async {
    bool res = false;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      log('login con credenciales');
      res = true;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await firebaseAuth.signOut();
      log('nos deslogueamos');
      _googleSignInAccount = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerUserWithEmail(
      {required String email, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> sendVerifyEmail() async {
    try {
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://mypets-healthbook.firebaseapp.com/__/auth/action',
        iOSBundleId: 'ar.com.mypets',
        androidPackageName: 'ar.com.mypets',
        handleCodeInApp: true,
        // dynamicLinkDomain: 'https://mypetshealthbook.page.link',
      );
      await _firebaseAuth.currentUser!
          .sendEmailVerification(actionCodeSettings);
      log('se envio email para validar');
      return true;
    } on FirebaseAuthException catch (e) {
      await logoutGoogle();
      rethrow;
    } catch (e) {
      await logoutGoogle();
      rethrow;
    }
  }

  Future<void> verifyIfUserValidate({required String email}) async {
    try {
      await _firebaseAuth.signOut();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: 'asd123');
      log('se creo al user con pass generica');
    } on FirebaseAuthException catch (e) {
      await logoutGoogle();
      rethrow;
    } catch (e) {
      await logoutGoogle();
      rethrow;
    }
  }

  Future<bool> changePasswordUser({required String pass}) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(pass);
      log('se cambio la pass');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getUserData(String uid) async {
    try {
      DocumentSnapshot res = await _collectionReference.doc(uid).get();
      if (res.exists) {
        print('Document data: ${res.data()}');
      } else {
        print('Document does not exist on the database');
      }
    } catch (e) {}
  }

  Future<void> addUSer(UserModel userModel) async {
    try {
      _collectionReference
          .doc(_firebaseAuth.currentUser!.uid)
          .set(userModel.toJson());
    } catch (e) {}
  }

  @override
  void onInit() {
    _firebaseAuth = FirebaseAuth.instance;
    _collectionReference = FirebaseFirestore.instance.collection('users');
    if (_firebaseAuth.currentUser != null) {
      getUserData(_firebaseAuth.currentUser!.uid);
    } else {
      // getUserData('aa');
    }
    super.onInit();
  }
}
