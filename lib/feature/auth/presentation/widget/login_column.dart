import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

class LoginColumn extends GetWidget<AuthController> {
  const LoginColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        FaIcon(FontAwesomeIcons.cat, size: 20.h),
        SizedBox(height: 10.h),
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
                Text('Ingresar con credenciales'),
              ],
            ),
          ),
          onPressed: () async {
            await controller.logIn(loginType: LoginType.credentials);
            context.go(Routes.home);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(Colors.black45),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Ingresar con credenciales con '),
              FaIcon(FontAwesomeIcons.google),
            ],
          ),
          onPressed: () async {
            await controller.logIn(loginType: LoginType.google);
            context.go(Routes.home);
          },
        ),
        TextButton(
          onPressed: () => context.push(Routes.register),
          child: const Text('Registrarse'),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
