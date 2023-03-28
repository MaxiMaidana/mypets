import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/feature/change_password/presentation/getx/change_password_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/button_custom.dart';
import '../../../../core/widgets/dialog_custom.dart';
import '../../../../core/widgets/input_custom.dart';

class ChangePasswordPV extends GetView<ChangePasswordController> {
  const ChangePasswordPV({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 96.5.h,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => context.go(Routes.main),
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Recuperemos tu password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              Text(
                'Vamos a enviarte un email a tu casilla para que puedas cambiar tu password para ingresar',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.emailController,
                hint: 'Email*',
                textInputType: TextInputType.emailAddress,
              ),
              const Spacer(),
              ButtonCustom.principal(
                text: 'Enviar',
                onPress: () async {
                  bool res = false;
                  context.loaderOverlay.show();
                  res = await controller.changePassword();
                  context.loaderOverlay.hide();
                  if (res) {
                    DialogCustom.infoDialog(
                      context,
                      barrierDismissible: true,
                      title: 'Genial !',
                      message:
                          'Revisa tu casilla de email para restablecer contraseña',
                      aceptar: () {
                        context.go(Routes.main);
                        Get.delete<ChangePasswordController>();
                      },
                    );
                  } else {
                    DialogCustom.infoDialog(
                      context,
                      title: controller.errorModel!.code,
                      message: controller.errorModel!.message,
                      aceptar: () => context.pop(),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ya recordaste tu password?'),
                  ButtonCustom.text(
                    text: 'Logueate',
                    onPress: () => context.go(Routes.main),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
