import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mypets/feature/firebase/firebase_controller.dart';

import '../../feature/app/controller/app_controller.dart';
import 'local_storage.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  Get.put(FirebaseController(), permanent: true);
  Get.put(AppController(), permanent: true);
  await LocalStorage.configPrefs();
  // locator.registerLazySingleton(() => NavigationService());
}
