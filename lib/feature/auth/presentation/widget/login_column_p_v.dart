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
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
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
              ButtonCustom.loginGoogle(
                text: 'Ingresar con Google',
                onPress: () async {
                  context.loaderOverlay.show();
                  await controller.logIn(loginType: LoginType.google);
                  if (context.mounted) {
                    context.loaderOverlay.hide();
                  }
                  switch (controller.userStatus.value) {
                    case UserStatus.dataCompleted:
                      Get.delete<AuthController>(force: true);
                      if (context.mounted) {
                        context.go(Routes.home);
                      }
                      break;
                    case UserStatus.needCompleteData:
                      if (context.mounted) {
                        context.push(Routes.register);
                      }
                      break;
                    case UserStatus.needValidateEmail:
                      if (context.mounted) {
                        context.push(Routes.register);
                      }
                      break;
                    case UserStatus.error:
                      if (context.mounted) {
                        DialogCustom.infoDialog(
                          context,
                          title: controller.errorModel!.code,
                          message: controller.errorModel!.message,
                          aceptar: () {
                            controller.errorModel = null;
                            context.pop();
                          },
                        );
                      }
                      break;
                    default:
                  }
                },
              ),
              // ButtonCustom.principal(
              //   text: 'Ingresar',
              //   onPress: () => controller.heightTotal.value = 75.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'No tenes cuenta ?',
              //       style: const TextStyle().copyWith(
              //         color: Colors.black,
              //         fontSize:
              //             Theme.of(context).textTheme.bodyMedium!.fontSize,
              //       ),
              //     ),
              //     ButtonCustom.text(
              //       text: 'Registrate.',
              //       onPress: () => context.push(Routes.register),
              //     ),
              //   ],
              // ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
        const Positioned(
          bottom: 0.0,
          child: LoginButtonSheetPV(),
        ),
      ],
    );
  }
}
