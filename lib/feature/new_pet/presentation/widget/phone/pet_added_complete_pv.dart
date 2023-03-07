import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/pages/page_with_widget_at_end.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/button_custom.dart';
import '../../getx/new_pet_controller.dart';

class PetAddedCompletePV extends StatelessWidget {
  const PetAddedCompletePV({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithWitgetAtEnd(
      bodyText:
          'Buenisimo !!!!!! Ya tenes tu pefil creado !! Ahora ya podes agregar a tu primer mascota, queres?',
      widgetEnd: Column(
        children: [
          ButtonCustom.principal(
            text: 'Agregar Datos',
            onPress: () {},
          ),
          ButtonCustom.principal(
            text: 'Omitir',
            onPress: () {
              context.go(Routes.home);
              Get.delete<NewPetController>();
            },
          ),
        ],
      ),
    );
  }
}
