import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:sizer/sizer.dart';

class HomeCV extends GetWidget<HomeController> {
  const HomeCV({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          NavigationRail(
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: const Icon(Icons.house_outlined),
                selectedIcon: const Icon(Icons.house),
                label: Container(),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.pets_outlined),
                selectedIcon: const Icon(Icons.pets),
                label: Container(),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.person_2_outlined),
                selectedIcon: const Icon(Icons.person_2),
                label: Container(),
              ),
            ],
            selectedIndex: controller.indexWeb.value,
            onDestinationSelected: (value) => controller.indexWeb(value),
          ),
          const VerticalDivider(),
          controller.indexWeb.value == 0
              ? const Text('Home')
              : controller.indexWeb.value == 1
                  ? const Text('Pets')
                  : Column(
                      children: [
                        const Text('settings'),
                        ElevatedButton(
                          onPressed: () {
                            // controller.authController.logOut();
                            context.go(Routes.auth);
                          },
                          child: SizedBox(
                            height: 5.h,
                            width: 7.w,
                            child: const Center(
                              child: Text(
                                'Cerrar sesion',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        ],
      ),
    );
    // Column(
    //   children: [
    //     ElevatedButton(
    //       onPressed: () {
    //         // controller.authController.logOut();
    //         // context.go(Routes.auth);
    //       },
    //       child: SizedBox(
    //         height: 5.h,
    //         width: 7.w,
    //         child: const Center(
    //           child: Text(
    //             'Cerrar sesion',
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
