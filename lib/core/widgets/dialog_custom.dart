import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:sizer/sizer.dart';

class DialogCustom {
  static void infoDialog(
    BuildContext context, {
    required String title,
    String? message,
    bool barrierDismissible = false,
    Function()? aceptar,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: [
            ButtonCustom.text(
              text: 'Aceptar',
              onPress: aceptar ?? () => context.pop(),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message ?? ''),
            ],
          ),
        ),
      );

  static void infoDialogWhitOptionsCustom(
    BuildContext context, {
    required String title,
    required List<Widget> actions,
    String? message,
    bool barrierDismissible = false,
    List<Widget> content = const [],
  }) =>
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: actions,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message ?? ''),
              ...content,
            ],
          ),
        ),
      );
  static void infoDialogWhitOptions(
    BuildContext context, {
    required String title,
    String? message,
    bool barrierDismissible = false,
    List<Widget> content = const [],
    required Function() aceptar,
    Function()? cancelar,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: [
            SizedBox(
              width: 30.w,
              child: ButtonCustom.text(
                text: 'Cancelar',
                onPress: cancelar ?? () => context.pop(),
              ),
            ),
            SizedBox(
              width: 30.w,
              child: ButtonCustom.principalShort(
                text: 'Aceptar',
                onPress: aceptar,
              ),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message ?? ''),
            ],
          ),
        ),
      );
}
