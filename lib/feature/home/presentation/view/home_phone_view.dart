import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';

import '../../../pets/presentation/view/pets_phone_view.dart';
import '../../../profile/presentation/view/profile_phone_view.dart';

class HomePhoneView extends GetWidget<HomeController> {
  const HomePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text('home phone view')),
      ],
    );
  }
}
