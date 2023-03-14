import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';

import '../../../../../core/pages/page_with_widget_at_end.dart';
import '../../../../../core/routes/routes.dart';
import '../../getx/register_controller.dart';

class RegisterCompletePV extends StatelessWidget {
  const RegisterCompletePV({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithWitgetAtEnd(
      textWidget: const Text(
          'Buenisimo !!!!!! Ya tenes tu pefil creado !! Ahora ya podes agregar a tu primer mascota, queres?'),
      widgetEnd: Column(
        children: [
          ButtonCustom.principal(
            text: 'Vamos!',
            onPress: () {},
          ),
          ButtonCustom.principal(
            text: 'Mas tarde',
            onPress: () {
              context.go(Routes.home);
              Get.delete<RegisterController>();
            },
          ),
        ],
      ),
    );
  }
}
