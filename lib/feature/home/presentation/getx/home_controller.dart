import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt index = 0.obs;
  RxInt indexWeb = 0.obs;

  void setIndex(int value) {
    // pageController = PageController(initialPage: value);
    // index.value = value;
    // log(index.value.toString());
  }
  // RxInt actualPage = 0.obs;

  void paginaActual(int value) {
    // if (pageController.hasClients) {
    index.value = value;
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 10),
      curve: Curves.linear,
    );
    update();
    // }
  }

  void setIndexWeb(int value) {
    indexWeb.value = value;
    log(indexWeb.value.toString());
  }
}
