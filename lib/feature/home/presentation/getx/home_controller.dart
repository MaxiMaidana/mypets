import 'dart:developer';

import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;

  void setIndex(int value) {
    index.value = value;
    log(index.value.toString());
  }
}
