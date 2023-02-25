import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../ads/presentation/widget/ads_p_v.dart';

class HomePV extends GetWidget<HomeController> {
  const HomePV({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu),
              ),
              Text(
                'My Pets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          const AdsPV(),
        ],
      ),
    );
  }
}
