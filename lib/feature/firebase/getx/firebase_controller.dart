import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mypets/data/models/user/user_model.dart';

class FirebaseController extends GetxController {
  late FirebaseAuth _firebaseAuth;

  late CollectionReference _collectionReference;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? _googleSignInAccount;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  late UserModel userModel;

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
        await getUserData();
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
      await getUserData();
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

  Future<bool> sendEmailToResetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot res =
          await _collectionReference.doc(firebaseAuth.currentUser!.uid).get();
      if (res.exists) {
        userModel = UserModel.fromJson(res.data() as Map<String, dynamic>);
      } else {
        print('Document does not exist on the database');
      }
    } catch (e) {
      log('rompio al traer el usuario de la base');
    }
  }

  Future<void> addUSer(UserModel userModel) async {
    try {
      await _collectionReference
          .doc(_firebaseAuth.currentUser!.uid)
          .set(userModel.toJson());
      log('se creo el usuario');
    } catch (e) {
      log('no se creo el usuario');
      rethrow;
    }
  }

  Future<void> updateUSer(UserModel userModel) async {
    try {
      _collectionReference
          .doc(_firebaseAuth.currentUser!.uid)
          .update(userModel.toJson());
      log('se actualizo el usuario');
    } catch (e) {
      log('no se actualizo el usuario');
      rethrow;
    }
  }

  @override
  void onInit() {
    _firebaseAuth = FirebaseAuth.instance;
    _collectionReference = FirebaseFirestore.instance.collection('users');
    if (_firebaseAuth.currentUser != null) {
      getUserData();
    } else {
      // getUserData('aa');
    }
    super.onInit();
  }
}
