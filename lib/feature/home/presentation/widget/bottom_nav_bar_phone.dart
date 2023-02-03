import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';

class BottomNavBar extends GetWidget<HomeController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        elevation: 0,
        currentIndex: controller.index.value,
        onTap: (value) => controller.setIndex(value),
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.house_outlined),
            activeIcon: Icon(Icons.house),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.pets_outlined),
            activeIcon: Icon(Icons.pets),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person_2),
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
