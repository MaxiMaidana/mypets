import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../widget/buttons_steps.dart';

class StepsToCompleteDataPV extends GetWidget<RegisterController> {
  const StepsToCompleteDataPV({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 96.5.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SizedBox(
                    height: 10.h,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          DialogCustom.infoDialogWhitOptions(
                            context,
                            title: 'Importante!',
                            actions: [
                              ButtonCustom.text(
                                text: 'Seguir Despues',
                                onPress: () async => goToMain(context),
                              ),
                              ButtonCustom.principalShort(
                                text: 'Continuar',
                                onPress: () => context.pop(),
                              ),
                            ],
                            content: [
                              Text(
                                'Si no completas este formulario no vas a poder entrar al app',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize,
                                ),
                              ),
                            ],
                          );
                        },
                        child: const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(Icons.graphic_eq_outlined, size: 30.h),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Obx(() =>
                      step(context, controller.completedDataStatus.value)),
                )
              ],
            ),
          ),
        ),
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

  Widget step(BuildContext context, CompletedDataStatus completedDataStatus) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Text(
              titleToCompleteData(completedDataStatus),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              ),
            ),
            SizedBox(height: 2.h),
            inputTextStep(context, completedDataStatus),
            const Spacer(),
            const ButtonsSteps(),
            SizedBox(height: 2.h),
          ],
        ),
      );

  String titleToCompleteData(CompletedDataStatus completedDataStatus) =>
      completedDataStatus == CompletedDataStatus.firstStep
          ? 'Primero'
          : completedDataStatus == CompletedDataStatus.secondStep
              ? 'Segundo'
              : completedDataStatus == CompletedDataStatus.thirtStep
                  ? 'Tercero'
                  : completedDataStatus == CompletedDataStatus.checkData
                      ? 'Repasemos'
                      : '';

  Widget inputTextStep(
          BuildContext context, CompletedDataStatus completedDataStatus) =>
      completedDataStatus == CompletedDataStatus.firstStep
          ? Column(
              children: [
                InputCustom.base(
                  controller: controller.nameController,
                  hint: 'Nombre*',
                ),
                SizedBox(height: 1.h),
                InputCustom.base(
                  controller: controller.lastNameController,
                  hint: 'Apellido*',
                )
              ],
            )
          : completedDataStatus == CompletedDataStatus.secondStep
              ? InputCustom.base(
                  controller: controller.dniController,
                  hint: 'DNI*',
                  textInputType: TextInputType.number,
                )
              : completedDataStatus == CompletedDataStatus.thirtStep
                  ? InputCustom.base(
                      controller: controller.phoneController,
                      hint: 'Telefono*',
                      textInputType: TextInputType.phone,
                    )
                  : completedDataStatus == CompletedDataStatus.checkData
                      ? Column(
                          children: [
                            Text(
                              '${controller.nameController.text} ${controller.lastNameController.text}',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.badge, size: 10.h),
                                    SizedBox(height: 1.h),
                                    const Icon(Icons.arrow_downward),
                                    Text(
                                      controller.dniController.text,
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.phone_android_outlined,
                                        size: 10.h),
                                    SizedBox(height: 1.h),
                                    const Icon(Icons.arrow_downward),
                                    Text(
                                      controller.phoneController.text,
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container();
}
