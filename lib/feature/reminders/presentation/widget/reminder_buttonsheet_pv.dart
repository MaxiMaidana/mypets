import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:mypets/feature/reminders/presentation/widget/row_item_date.dart';
import 'package:mypets/feature/reminders/presentation/widget/row_item_time.dart';
import 'package:sizer/sizer.dart';

import '../../../new_pet/presentation/widget/drop_down_menu_custom.dart';
import '../getx/reminder_controller.dart';

class ReminderButtonSheetPV extends GetWidget<ReminderController> {
  final String petName;
  const ReminderButtonSheetPV({super.key, required this.petName});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: controller.heightTotal.value,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      controller.isEdit.value
                          ? 'Editar recordatorio'
                          : 'Agregar recordatorio',
                      textAlign: TextAlign.center,
                      style: const TextStyle().copyWith(
                        color: Colors.black,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  RowItemDate(
                    textController: controller.dateController,
                    hint: 'Fecha del recordatorio*',
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      size: 40,
                    ),
                    function: () async {
                      controller.dateToReminder.value = await showDatePicker(
                        context: context,
                        locale: const Locale("es", "ES"),
                        initialDate: controller.dateController.text == ''
                            ? DateTime.now()
                            : controller.dateToReminder.value!,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1, 12, 31),
                      );
                      controller.dateController.text = controller.setDateText();
                    },
                  ),
                  const SizedBox(height: 10),
                  RowItemTime(
                    textInit: controller.timeInitController,
                    textFinish: controller.timeFinishController,
                    icon: const Icon(
                      Icons.watch_later,
                      size: 40,
                    ),
                    functionInit: () async {
                      controller.timeInitToReminder.value =
                          await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.input,
                        helpText: 'Hora de inicio',
                        initialTime: controller.timeInitController.text == ''
                            ? TimeOfDay(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute,
                              )
                            : controller.timeInitToReminder.value!,
                      );
                      controller.timeInitController.text =
                          controller.setTimeText(TypeTime.init);
                    },
                    functionFinish: () async {
                      controller.timeFinishToReminder.value =
                          await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.input,
                        helpText: 'Hora de fin',
                        initialTime: controller.timeInitToReminder.value!,
                      );
                      controller.timeFinishController.text =
                          controller.setTimeText(TypeTime.finish);
                    },
                  ),
                  const SizedBox(height: 10),
                  DropDownMenuCustom(
                    initTitle: controller.typeController.text,
                    valueCharged: controller.typeController.text,
                    items: controller.types,
                    function: (v) => controller.typeController.text = v,
                  ),
                  const SizedBox(height: 10),
                  InputCustom.base(
                    controller: controller.descController,
                    hint: 'Descripcion',
                    cantLines: 4,
                  ),
                  const SizedBox(height: 30),
                  controller.isEdit.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonCustom.text(
                              text: 'Eliminar',
                              onPress: () async {
                                context.loaderOverlay.show();
                                bool res = await controller.deleteReminder();
                                if (context.mounted) {
                                  context.loaderOverlay.hide();
                                  if (res) {
                                    DialogCustom.infoDialog(
                                      context,
                                      title: 'Genial!',
                                      message:
                                          'Ya eliminaste tu recordatorio para $petName.',
                                      barrierDismissible: true,
                                      aceptar: () => context.pop(),
                                    );
                                  }
                                }
                              },
                            ),
                            ButtonCustom.principalShort(
                              text: 'Guardar',
                              onPress: () async {
                                context.loaderOverlay.show();
                                bool res = await controller.editReminder(
                                    petName: petName);
                                if (context.mounted) {
                                  context.loaderOverlay.hide();
                                  if (res) {
                                    DialogCustom.infoDialog(
                                      context,
                                      title: 'Genial!',
                                      message:
                                          'Ya editaste tu recordatorio de $petName.',
                                      barrierDismissible: true,
                                      aceptar: () => context.pop(),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      : ButtonCustom.principal(
                          text: 'Confirmar',
                          onPress: () async {
                            context.loaderOverlay.show();
                            bool res = await controller.insertReminder(
                                petName: petName);
                            if (context.mounted) {
                              context.loaderOverlay.hide();
                              if (res) {
                                DialogCustom.infoDialog(
                                  context,
                                  title: 'Genial!',
                                  message:
                                      'Ya creaste tu recordatorio para $petName.',
                                  barrierDismissible: true,
                                  aceptar: () => context.pop(),
                                );
                              }
                            }
                          },
                        ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _rowItemDate({
  //   required TextEditingController textController,
  //   required String hint,
  //   required Icon icon,
  //   required Function() function,
  // }) {
  //   return GestureDetector(
  //     onTap: function,
  //     child: Row(
  //       children: [
  //         icon,
  //         const Spacer(),
  //         SizedBox(
  //           width: 70.w,
  //           child: InputCustom.base(
  //             controller: textController,
  //             hint: hint,
  //             isEnable: false,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _rowItemTime({
  //   required TextEditingController textControllerInit,
  //   required TextEditingController textControllerFinish,
  //   required Icon icon,
  //   required Function() functionInit,
  //   required Function() functionFinish,
  // }) {
  //   return Row(
  //     children: [
  //       GestureDetector(
  //         onTap: functionInit,
  //         child: Row(
  //           children: [
  //             icon,
  //             SizedBox(width: 10.w),
  //             SizedBox(
  //               width: 30.w,
  //               child: InputCustom.base(
  //                 controller: textControllerInit,
  //                 hint: 'Inicio',
  //                 isEnable: false,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const Spacer(),
  //       GestureDetector(
  //         onTap: functionFinish,
  //         child: SizedBox(
  //           width: 30.w,
  //           child: InputCustom.base(
  //             controller: textControllerFinish,
  //             hint: 'Fin',
  //             isEnable: false,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
