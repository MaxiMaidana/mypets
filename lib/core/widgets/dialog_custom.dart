import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';

class DialogCustom {
  static void infoDialog(
    BuildContext context, {
    required String title,
    String? message,
    // List<Widget> content = const [],
    Function()? aceptar,
  }) =>
      showDialog(
        context: context,
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

  static void infoDialogWhitOptions(
    BuildContext context, {
    required String title,
    required List<Widget> actions,
    String? message,
    List<Widget> content = const [],
    Function()? aceptar,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: actions,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
        ),
      );
}
