import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';

import '../../../pets/presentation/view/pets_phone_view.dart';
import '../../../profile/presentation/view/profile_phone_view.dart';
import '../../../reminders/presentation/page/reminder_page.dart';
import '../widget/bottom_nav_bar_pv.dart';
import 'home_p_v.dart';

class HomeInitPV extends GetWidget<HomeController> {
  const HomeInitPV({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePV(),
            ReminderPage(),
            PetsPhoneView(),
            ProfilePhoneView(),
          ],
        ),
        const Positioned(
          bottom: 0,
          child: ButtomNavBarPV(),
        ),
      ],
    );
  }
}
