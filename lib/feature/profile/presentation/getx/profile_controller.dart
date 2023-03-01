import 'package:get/get.dart';
import 'package:mypets/data/models/user/user_model.dart';

import '../../../../core/service/local_storage.dart';
import '../../../app/presentation/getx/app_controller.dart';
import '../../../firebase/getx/firebase_controller.dart';

class ProfileController extends GetxController {
  final FirebaseController _firebaseController = Get.find();
  final _appController = Get.find<AppController>();

  Rx<UserModel> userModel = UserModel.initEmpty().obs;
  String appVersion = '';

  RxBool get themeMode => _appController.isDarkMode;

  Future<void> logOut() async {
    try {
      await _firebaseController.logoutGoogle();
      LocalStorage.setPref(setPref: SetPref.auth, dataBool: false);
      // _homeController.index.value = 0;
    } catch (e) {
      rethrow;
    }
  }

  // void chargeImage() {
  //   userModel = _appController.userModel;
  //   log('se cargo el user Model en profile controller');
  // if (_firebaseController.firebaseAuth.currentUser != null) {
  // userProfile = _firebaseController.firebaseAuth.currentUser;
  // }
  // }

  Future<void> initialSettings() async {
    appVersion = _appController.packageInfo?.version ?? '';
    await _appController
        .getUserData(_firebaseController.firebaseAuth.currentUser!.uid);
    userModel.value = _appController.userModel!;
  }

  void changeTheme(bool value) {
    _appController.isDarkMode.value = value;
  }

  @override
  void onInit() async {
    initialSettings();
    super.onInit();
  }
}
