import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:mypets/feature/pets/presentation/view/pets_phone_view.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../../../profile/presentation/view/profile_phone_view.dart';
import '../view/home_computer_view.dart';
import '../view/home_phone_view.dart';
import '../widget/bottom_nav_bar_phone.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WidgetTree(
          tiny: const Text('tiny'),
          phone: Obx(
            () => IndexedStack(
              index: controller.index.value,
              children: const [
                HomePhoneView(),
                PetsPhoneView(),
                ProfilePhoneView(),
              ],
            ),
          ),
          tablet: const Text('tablet'),
          largeTablet: const Text('tablet large'),
          computer: const HomeComputerView(),
        ),
        bottomNavigationBar: GetPlatform.isWeb ? null : const BottomNavBar(),
      ),
    );
  }
}
