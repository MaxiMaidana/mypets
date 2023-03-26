import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:mypets/feature/reminders/presentation/getx/reminder_controller.dart';
// import 'package:mypets/data/models/user/user_model.dart';

// import '../../app/controller/app_controller.dart';

class FirebaseController extends GetxController {
  final reminderController = Get.find<ReminderController>();
  late FirebaseAuth _firebaseAuth;

  late FirebaseFirestore _firebaseFirestore;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      CalendarApi.calendarScope,
    ],
  );

  GoogleSignInAccount? _googleSignInAccount;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  bool logued = false;

  Future<bool> loginWithGoogle() async {
    bool res = false;
    try {
      _googleSignInAccount = await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        var httpClient = (await _googleSignIn.authenticatedClient())!;
        CalendarApi calendarApi = CalendarApi(httpClient);
        reminderController.calendarApi = calendarApi;
        log('desde firebase controller ${calendarApi!.events.toString()}');
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
      // await getUserData();
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
    } on FirebaseAuthException catch (_) {
      await logoutGoogle();
      rethrow;
    } catch (e) {
      await logoutGoogle();
      rethrow;
    }
  }

  Future<void> verifyIfUserValidate(
      {required String email, String? pass}) async {
    try {
      await _firebaseAuth.signOut();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: 'asd123');
      log('se desloguea de firebase');
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'wrong-password') {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: pass!);
        log('se loguea otra vez para refrescar datos');
        return;
      } else {
        await logoutGoogle();
      }
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

  CollectionReference connectWithFirebaseCollection(String collection) =>
      _firebaseFirestore.collection(collection);

  @override
  void onInit() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFirestore = FirebaseFirestore.instance;
    if (_firebaseAuth.currentUser != null) {
      logued = true;
    }
    super.onInit();
  }
}
