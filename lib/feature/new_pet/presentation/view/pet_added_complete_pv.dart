import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/pages/page_with_widget_at_end.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/button_custom.dart';
import '../getx/new_pet_controller.dart';

class PetAddedCompletePV extends GetWidget<NewPetController> {
  const PetAddedCompletePV({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PageWithWitgetAtEnd(
        bodyText: controller.petMessage.value,
        widgetEnd: Column(
          children: [
            controller.petMessage.value.contains('estamos agregando') ||
                    controller.petMessage.value.contains('retoques finales') ||
                    controller.petMessage.value.contains('algo anduvo mal')
                ? Container()
                : controller.errorModel == null
                    ? ButtonCustom.principal(
                        text: 'Agregar Datos',
                        onPress: () {},
                      )
                    : Container(),
            controller.petMessage.value.contains('estamos agregando') ||
                    controller.petMessage.value.contains('retoques finales')
                ? Container()
                : ButtonCustom.principal(
                    text:
                        controller.petMessage.value.contains('algo anduvo mal')
                            ? 'Ir al Home :/'
                            : 'Omitir',
                    onPress: () {
                      context.go(Routes.home);
                      Get.delete<NewPetController>(force: true);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
