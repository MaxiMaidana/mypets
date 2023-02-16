import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:mypets/feature/register/presentation/getx/register_controller.dart';
import 'package:sizer/sizer.dart';

class StepsToCompleteDataPV extends GetView<RegisterController> {
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
                SizedBox(height: 10.h),
                Icon(
                  Icons.graphic_eq_outlined,
                  size: 30.h,
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
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
            inputTextStep(completedDataStatus),
            const Spacer(),
            ButtonCustom.principal(
              text: controller.completedDataStatus.value ==
                      CompletedDataStatus.checkData
                  ? 'Finalizar'
                  : 'Siguiente',
              onPress: () {
                switch (completedDataStatus) {
                  case CompletedDataStatus.firstStep:
                    controller.completedDataStatus.value =
                        CompletedDataStatus.secondStep;
                    break;
                  case CompletedDataStatus.secondStep:
                    controller.completedDataStatus.value =
                        CompletedDataStatus.thirtStep;
                    break;
                  case CompletedDataStatus.thirtStep:
                    controller.completedDataStatus.value =
                        CompletedDataStatus.checkData;
                    break;
                  case CompletedDataStatus.checkData:
                    controller.completedDataStatus.value =
                        CompletedDataStatus.completed;
                    break;
                  default:
                }
              },
            ),
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
  Widget inputTextStep(CompletedDataStatus completedDataStatus) =>
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
                )
              : completedDataStatus == CompletedDataStatus.thirtStep
                  ? InputCustom.base(
                      controller: controller.phoneController,
                      hint: 'Telefono*',
                    )
                  : completedDataStatus == CompletedDataStatus.checkData
                      ? Column(
                          children: [
                            const Text('Nombre'),
                            SizedBox(height: 1.h),
                            const Text('Apellido'),
                            SizedBox(height: 1.h),
                            const Text('Dni'),
                            SizedBox(height: 1.h),
                            const Text('Telefono'),
                          ],
                        )
                      : Container();
} 


          // SizedBox(height: 2.h),
          // InputCustom.base(
          //   controller: controller.phoneController,
          //   hint: 'Telefono*',
          //   textInputType: TextInputType.phone,
          // ),