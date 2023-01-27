import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

class PhoneView extends GetWidget<AuthController> {
  const PhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: 100.h,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Icon(
                  Icons.pets,
                  size: 30.h,
                ),
                SizedBox(height: 5.h),
                TextFormField(
                  controller: controller.usernameController,
                ),
                TextFormField(
                  controller: controller.passController,
                ),
                const Spacer(),
                ElevatedButton(
                  child: SizedBox(
                    height: 8.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.access_time_filled_rounded),
                        Text('Iniciar Sesion'),
                      ],
                    ),
                  ),
                  onPressed: () => controller.loginWithGoogle(),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => controller.isLogued.value
                      ? ElevatedButton(
                          child: SizedBox(
                            height: 8.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.access_time_filled_rounded),
                                Text('Cerrar Sesion'),
                              ],
                            ),
                          ),
                          onPressed: () => controller.logoutGoogle(),
                        )
                      : Container(),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
