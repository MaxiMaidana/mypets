import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/pages/page_with_widget_at_end.dart';

class WaithingValidationPV extends GetView<RegisterController> {
  const WaithingValidationPV({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithWitgetAtEnd(
      bodyText: 'Enviamos un email para validar tu cuenta.',
      widgetEnd: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No te llego el email?'),
              ButtonCustom.text(
                text: 'Reenviar',
                onPress: () {},
              ),
            ],
          ),
          ButtonCustom.principal(
            text: 'Ya valida el email',
            onPress: () =>
                controller.statusRegister.value = StatusRegister.emailVerified,
          ),
          SizedBox(height: 1.h),
          ButtonCustom.text(
            text: 'Ir al login',
            onPress: () => context.go(Routes.main),
          ),
        ],
      ),
    );
  }
}
