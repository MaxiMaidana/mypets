import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/widgets/dialog_custom.dart';
import '../../getx/register_controller.dart';

class RegisterPV extends GetWidget<RegisterController> {
  const RegisterPV({super.key});

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
                onTap: () {
                  controller.emailController.text = '';
                  controller.passController.text = '';
                  controller.confirmPassController.text = '';
                  context.go(Routes.main);
                  // await Get.delete<RegisterController>(force: true);
                },
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
                'Registro',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.emailController,
                hint: 'Email*',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.passController,
                hint: 'Controseña*',
                isPassword: true,
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.confirmPassController,
                hint: 'Repetir Contraseña*',
                isPassword: true,
              ),
              const Spacer(),
              ButtonCustom.principal(
                  text: 'Registrarme',
                  onPress: () async {
                    bool res = false;
                    if (controller.validateInputs()) {
                      context.loaderOverlay.show();
                      res = await controller.registerWithEmail();
                      context.loaderOverlay.hide();
                    }
                    if (!res) {
                      DialogCustom.infoDialog(
                        context,
                        title: controller.errorModel!.code,
                        message: controller.errorModel!.message,
                      );
                    }
                  }),
              ButtonCustom.loginGoogle(
                text: 'Registrarme con Google',
                onPress: () async {
                  bool res = false;
                  context.loaderOverlay.show();
                  res = await controller.registerWithGoogle();
                  context.loaderOverlay.hide();
                  if (controller.completedDataStatus.value ==
                      CompletedDataStatus.completed) {
                    context.go(Routes.home);
                    // Get.delete<RegisterController>(force: true);
                  }
                  if (!res) {
                    DialogCustom.infoDialog(
                      context,
                      title: controller.errorModel!.code,
                      message: controller.errorModel!.message,
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ya tenes cuenta?'),
                  ButtonCustom.text(
                    text: 'Logueate',
                    onPress: () {
                      context.go(Routes.main);
                      Get.delete<RegisterController>(force: true);
                    },
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
