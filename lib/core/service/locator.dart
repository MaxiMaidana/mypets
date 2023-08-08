import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mypets/feature/firebase/getx/firebase_controller.dart';

import '../../feature/app/presentation/getx/app_controller.dart';
import '../../feature/info_pet_support/presentation/getx/pet_info_support_controller.dart';
import '../../feature/reminders/presentation/getx/reminder_controller.dart';
import '../utils/connection/connection_status_service.dart';
import 'local_storage.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  Get.put(ReminderController(), permanent: true);
  Get.put(FirebaseController(), permanent: true);
  Get.put(AppController(), permanent: true);
  Get.put(PetInfoSupportController(), permanent: true);
  Get.put(ConnectionStatusController(), permanent: true);
  await LocalStorage.configPrefs();
}
