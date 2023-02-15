import 'dart:developer';

import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;
  RxInt indexWeb = 0.obs;

  void setIndex(int value) {
    index.value = value;
    log(index.value.toString());
  }

  void setIndexWeb(int value) {
    indexWeb.value = value;
    log(indexWeb.value.toString());
  }
}
