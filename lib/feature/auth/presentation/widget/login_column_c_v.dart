import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/button_custom.dart';
import '../../../../core/widgets/dialog_custom.dart';
import '../../../../core/widgets/input_custom.dart';

class LoginColumCV extends GetWidget<AuthController> {
  const LoginColumCV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text(
          'Bienvenido a My Pets',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5.h),
        InputCustom.base(
          controller: controller.emailController,
          hint: 'Email',
          textInputType: TextInputType.emailAddress,
        ),
        SizedBox(height: 1.h),
        InputCustom.base(
          controller: controller.passController,
          hint: 'Contraseña',
          isPassword: true,
        ),
        ButtonCustom.text(
          text: 'Olvide mi contraseña.',
          onPress: () => context.push(Routes.changePassword),
        ),
        const Spacer(),
        ButtonCustom.principal(
          text: 'Ingresar',
          onPress: () async {
            context.loaderOverlay.show();
            await controller.logIn(loginType: LoginType.credentials);
            context.loaderOverlay.hide();
            switch (controller.userStatus.value) {
              case UserStatus.dataCompleted:
                Get.delete<AuthController>(force: true);
                context.go(Routes.home);
                break;
              case UserStatus.needCompleteData:
                context.push(Routes.register);
                break;
              case UserStatus.needValidateEmail:
                context.push(Routes.register);
                break;
              case UserStatus.error:
                DialogCustom.infoDialog(
                  context,
                  title: controller.errorModel!.code,
                  message: controller.errorModel!.message,
                );
                break;
              default:
            }
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
