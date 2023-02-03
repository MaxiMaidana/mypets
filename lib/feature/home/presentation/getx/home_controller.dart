import 'dart:developer';

import 'package:get/get.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';

class HomeController extends GetxController {
  // quitas de aca esto
  final AuthController authController = Get.find();

  RxInt index = 0.obs;

  void setIndex(int value) {
    index.value = value;
    log(index.value.toString());
  }
}
