import 'dart:developer';

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

  Future<void> loginWithGoogle() async {
    try {
      googleSignInAccount = await _googleSignIn.signIn();
      isLogued.value = true;
      log(googleSignInAccount!.email);
    } catch (e) {
      isLogued.value = false;
      rethrow;
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await _googleSignIn.signOut();
      googleSignInAccount = null;
      isLogued.value = false;
    } catch (e) {
      isLogued.value = false;
      rethrow;
    }
  }
}
