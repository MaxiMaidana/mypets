import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

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
        textWidget: CarouselSlider(
          carouselController: controller.carouselController,
          options: CarouselOptions(
            autoPlay: false,
            pauseAutoPlayOnManualNavigate: true,
            enableInfiniteScroll: false,
            pauseAutoPlayInFiniteScroll: true,
          ),
          items: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 100.w,
              child: Center(
                child: Text(
                  controller.textWaithing.value,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 100.w,
              child: Center(
                child: Text(
                  controller.textMoreWaithing.value,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 100.w,
              child: Center(
                child: Text(
                  controller.textCompleteGood.value,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        widgetEnd: Column(
          children: [
            controller.textCompleteGood.value == ''
                ? Container()
                : controller.errorModel == null
                    ? ButtonCustom.principal(
                        text: 'Agregar Datos',
                        onPress: () {},
                      )
                    : Container(),
            controller.textWaithing.value != '' ||
                    controller.textMoreWaithing.value != ''
                ? Container()
                : ButtonCustom.principal(
                    text: controller.textError.value != ''
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
