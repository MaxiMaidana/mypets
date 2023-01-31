import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mypets/feature/firebase/firebase_controller.dart';

import '../../feature/app/controller/app_controller.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  Get.put(FirebaseController(), permanent: true);
  Get.put(AppController(), permanent: true);
  // locator.registerLazySingleton(() => NavigationService());
}
