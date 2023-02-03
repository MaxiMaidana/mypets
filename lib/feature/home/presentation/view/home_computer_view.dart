import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:sizer/sizer.dart';

class HomeComputerView extends GetWidget<HomeController> {
  const HomeComputerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            controller.authController.logOut();
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
    );
  }
}
