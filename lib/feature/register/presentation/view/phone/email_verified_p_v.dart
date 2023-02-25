import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/pages/page_with_widget_at_end.dart';

class EmailVerifiedPV extends GetWidget<RegisterController> {
  const EmailVerifiedPV({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithWitgetAtEnd(
      bodyText:
          'Genial ! Ya tenes tu cuenta validada, ahora vamos a pedirte unos datos para poder completar tu perfil =D',
      widgetEnd: Column(
        children: [
          ButtonCustom.principal(
            text: 'Vamos',
            onPress: () => controller.statusRegister.value =
                StatusRegister.needCompleteData,
          ),
          SizedBox(height: 1.h),
          ButtonCustom.principal(
            text: 'Despues :/',
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
