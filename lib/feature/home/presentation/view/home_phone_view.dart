import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';

class HomePhoneView extends GetWidget<HomeController> {
  const HomePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        // SizedBox(height: 10.h),
        const Center(child: Text('home phone view')),
      ],
    );
  }
}
