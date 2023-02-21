import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

import 'login_button_sheet_p_v.dart';

class LoginColumnPV extends GetWidget<AuthController> {
  const LoginColumnPV({super.key});

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
                await controller.logIn(loginType: LoginType.credentials);
                context.loaderOverlay.hide();
                switch (controller.userStatus.value) {
                  case UserStatus.dataCompleted:
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
              googleFunction: () async {
                context.loaderOverlay.show();
                await controller.logIn(loginType: LoginType.google);
                context.loaderOverlay.hide();
                switch (controller.userStatus.value) {
                  case UserStatus.dataCompleted:
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
