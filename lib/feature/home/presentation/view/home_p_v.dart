import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../ads/presentation/widget/ads_p_v.dart';
import '../../../pets/presentation/view/pets_phone_view.dart';
import '../../../profile/presentation/view/profile_phone_view.dart';
import '../../../reminders/presentation/page/reminder_page.dart';
import '../widget/bottom_nav_bar_pv.dart';

class HomePV extends GetWidget<HomeController> {
  const HomePV({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Home(),
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

class Home extends GetWidget<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
              Text(
                'My Pets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        const AdsPV(),
      ],
    );
  }
}
