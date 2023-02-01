import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

class LoginColumn extends GetWidget<AuthController> {
  const LoginColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        FaIcon(FontAwesomeIcons.cat, size: 30.h),
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
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.access_time_filled_rounded),
                Text('Iniciar Sesion'),
              ],
            ),
          ),
          onPressed: () => controller.logIn(loginType: LoginType.credentials),
        ),
        ElevatedButton(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(Colors.black45),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: const FaIcon(FontAwesomeIcons.google),
          onPressed: () => controller.logIn(loginType: LoginType.google),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
