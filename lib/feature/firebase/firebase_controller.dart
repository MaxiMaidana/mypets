import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? googleSignInAccount;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  late UserCredential userFirebase;

  Future<bool> loginWithGoogle() async {
    bool res = false;
    try {
      googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleAuth =
            await googleSignInAccount!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        userFirebase = await firebaseAuth.signInWithCredential(credential);
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
      userFirebase = await _firebaseAuth.signInWithPopup(authProvider);
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
      userFirebase = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
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
      googleSignInAccount = null;
    } catch (e) {
      rethrow;
    }
  }
}
