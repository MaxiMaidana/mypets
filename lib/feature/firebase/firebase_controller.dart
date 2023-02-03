import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseController extends GetxController {
  late FirebaseAuth _firebaseAuth;

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
        // UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
        // chargeUserFirebase(userCredential);
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
      // UserCredential userCredential =
      await _firebaseAuth.signInWithPopup(authProvider);
      // chargeUserFirebase(userCredential);
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
      // UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // chargeUserFirebase(userCredential);
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
      _googleSignInAccount = null;
    } catch (e) {
      rethrow;
    }
  }

  // void chargeUserFirebase(UserCredential userCredential) async {
  //   userFirebase = userCredential.user;
  // }

  @override
  void onInit() {
    _firebaseAuth = FirebaseAuth.instance;
    if (_firebaseAuth.currentUser != null) {
      log('distinto de  null');
    } else {
      log('  null');
    }
    super.onInit();
  }
}
