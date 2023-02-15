import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/service/local_storage.dart';
// import '../../../auth/presentation/getx/auth_controller.dart';
import '../../../app/controller/app_controller.dart';
import '../../../firebase/firebase_controller.dart';
import '../../../home/presentation/getx/home_controller.dart';

class ProfileController extends GetxController {
  final FirebaseController _firebaseController = Get.find();
  final HomeController _homeController = Get.find();
  final AppController _appController = Get.find();

  User? userProfile;
  String appVersion = '';

  RxBool get themeMode => _appController.isDarkMode;

  Future<void> logOut() async {
    try {
      await _firebaseController.logoutGoogle();
      LocalStorage.setPref(SetPref.auth, false);
      _homeController.index.value = 0;
    } catch (e) {
      rethrow;
    }
  }

  void chargeImage() {
    if (_firebaseController.firebaseAuth.currentUser != null) {
      userProfile = _firebaseController.firebaseAuth.currentUser;
    }
  }

  void initialSettings() {
    chargeImage();
    appVersion = _appController.packageInfo?.version ?? '';
  }

  void changeTheme(bool value) {
    _appController.isDarkMode.value = value;
  }

  @override
  void onInit() {
    initialSettings();
    super.onInit();
  }
}
