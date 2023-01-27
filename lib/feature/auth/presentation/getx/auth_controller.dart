import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isLogued = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  GoogleSignInAccount? googleSignInAccount;
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> loginWithGoogle() async {
    try {
      googleSignInAccount = await _googleSignIn.signIn();
      log(googleSignInAccount!.email);
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final fireUser = await firebaseAuth.signInWithCredential(credential);
      isLogued.value = true;
      log(fireUser.user!.uid);
    } catch (e) {
      isLogued.value = false;
      rethrow;
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await firebaseAuth.signOut();
      googleSignInAccount = null;
      isLogued.value = false;
    } catch (e) {
      isLogued.value = false;
      rethrow;
    }
  }
}
