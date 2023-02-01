import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sizer/sizer.dart';

import '../getx/auth_controller.dart';
import '../widget/login_column.dart';

class AuthComputeView extends GetWidget<AuthController> {
  const AuthComputeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Row(
          children: [
            SizedBox(
              width: 50.w,
              child: Image.network(
                'https://s3.amazonaws.com/files.lafm.com.co/assets/public/styles/image_1200x1200/public/2022-12/polemica_celebracion_de_dibu_martinez_al_ser_premiado_con_guante_de_oro.jpg.webp?7R5.gCqn7D0leI8wXCFjs0b5CZfGam1u&itok=mybS_y_i',
              ),
            ),
            SizedBox(
              width: 50.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: const LoginColumn(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
