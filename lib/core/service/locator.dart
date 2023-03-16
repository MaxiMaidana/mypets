import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mypets/feature/firebase/getx/firebase_controller.dart';

import '../../feature/app/presentation/getx/app_controller.dart';
import '../../feature/pet_info_support/presentation/getx/pet_info_support_controller.dart';
import 'local_storage.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  Get.put(FirebaseController(), permanent: true);
  Get.put(AppController(), permanent: true);
  Get.put(PetInfoSupportController(), permanent: true);
  // Get.put(AuthController(), permanent: true);
  await LocalStorage.configPrefs();
  // locator.registerLazySingleton(() => NavigationService());
}
