import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

import '../../widget/buttons_steps_crate_user.dart';

class StepsToCompleteDataPV extends GetWidget<RegisterController> {
  const StepsToCompleteDataPV({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SizedBox(
                height: 40,
                width: 40,
                child: GestureDetector(
                  onTap: () {
                    DialogCustom.infoDialogWhitOptionsCustom(
                      context,
                      title: 'Cancelar?',
                      actions: [
                        SizedBox(
                          width: 26.w,
                          child: ButtonCustom.text(
                            text: 'Cancelar',
                            onPress: () async => _goToMain(context),
                          ),
                        ),
                        ButtonCustom.principalShort(
                          text: 'Continuar',
                          onPress: () => context.pop(),
                        ),
                      ],
                      content: [
                        Text(
                          'Si cancelas perderas todo tu progreso y deberas volver a arrancar desde el pricipio la proxima vez.',
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
                  child: const Center(
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Center(child: Icon(Icons.graphic_eq_outlined, size: 220)),
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
              child: Obx(
                  () => step(context, controller.completedDataStatus.value)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToMain(BuildContext context) async {
    context.go(Routes.main);
    Get.delete<RegisterController>(force: true);
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
            const ButtonsStepsCreateUser(),
            SizedBox(height: 2.h),
          ],
        ),
      );

  String titleToCompleteData(CompletedDataStatus completedDataStatus) =>
      completedDataStatus == CompletedDataStatus.firstStep
          ? 'Nombre y  Apellido'
          : completedDataStatus == CompletedDataStatus.secondStep
              ? 'DNI'
              : completedDataStatus == CompletedDataStatus.thirtStep
                  ? 'Telefono'
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
