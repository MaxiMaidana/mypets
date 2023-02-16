import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

import 'login_button_sheet_phone.dart';

class LoginColumnPhone extends GetWidget<AuthController> {
  const LoginColumnPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text(
          'Bienvenido a',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.left,
        ),
        Center(
          child: Icon(Icons.pets, size: 30.h),
        ),
        const Spacer(),
        ButtonCustom.principal(
          text: 'Ingresar',
          onPress: () {
            buttonSheetLogin(
              context,
              emailController: controller.emailController,
              passController: controller.passController,
              credentialsFunction: () async {
                context.loaderOverlay.show();
                await Future.delayed(Duration(seconds: 2));
                // await controller.logIn(loginType: LoginType.credentials);
                context.loaderOverlay.hide();
                if (controller.isLogued.value) {
                  context.go(Routes.home);
                }
              },
              googleFunction: () async {
                context.loaderOverlay.show();
                await controller.logIn(loginType: LoginType.google);
                if (controller.isLogued.value) {
                  context.loaderOverlay.hide();
                  context.go(Routes.home);
                }
              },
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No tenes cuenta ?',
              style: const TextStyle().copyWith(
                color: Colors.black,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
            ButtonCustom.text(
              text: 'Registrate.',
              onPress: () => context.push(Routes.register),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
