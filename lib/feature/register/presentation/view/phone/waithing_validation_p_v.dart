import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/pages/page_with_widget_at_end.dart';

class WaithingValidationPV extends GetWidget<RegisterController> {
  const WaithingValidationPV({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithWitgetAtEnd(
      textWidget: const Text('Enviamos un email para validar tu cuenta.'),
      widgetEnd: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No te llego el email?'),
              ButtonCustom.text(
                text: 'Reenviar',
                onPress: () async => controller.sendEmailToValidate(),
              ),
            ],
          ),
          ButtonCustom.principal(
            text: 'Ya valide el email',
            onPress: () async {
              if (await controller.checkIfEmailIsVerify()) {
                controller.statusRegister.value = StatusRegister.emailVerified;
              } else {
                DialogCustom.infoDialogWhitOptionsCustom(
                  context,
                  title: controller.errorModel!.code,
                  message: controller.errorModel!.message,
                  barrierDismissible: false,
                  actions: [
                    ButtonCustom.text(
                      text: 'Ir al login',
                      onPress: () {
                        context.go(Routes.main);
                        Get.delete<RegisterController>();
                      },
                    ),
                    ButtonCustom.principalShort(
                      text: 'Volver a intentar',
                      onPress: () => context.pop(),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: 1.h),
          ButtonCustom.text(
            text: 'Ir al login',
            onPress: () async => goToMain(context),
          ),
        ],
      ),
    );
  }

  Future<void> goToMain(BuildContext context) async {
    // context.loaderOverlay.show();
    // await controller.clearData();
    // context.loaderOverlay.hide();
    Get.delete<RegisterController>(force: true);
    context.go(Routes.main);
  }
}
