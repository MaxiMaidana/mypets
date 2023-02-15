import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

enum ButtonType { principal, google, text }

class ButtonCustom extends StatelessWidget {
  final ButtonType type;
  final Function() onPress;
  final String? text;
  final TextStyle? style;

  const ButtonCustom({
    super.key,
    required this.type,
    required this.onPress,
    this.text,
    this.style,
  });

  factory ButtonCustom.principal({
    required String text,
    required Function() onPress,
  }) =>
      ButtonCustom(
        type: ButtonType.principal,
        text: text,
        onPress: onPress,
      );

  factory ButtonCustom.loginGoogle({
    required Function() onPress,
  }) =>
      ButtonCustom(
        type: ButtonType.google,
        text: 'Ingresar con Google',
        onPress: onPress,
      );
  factory ButtonCustom.text({
    required String text,
    required Function() onPress,
    TextStyle? style,
  }) =>
      ButtonCustom(
        type: ButtonType.text,
        text: text,
        onPress: onPress,
        style: style,
      );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.principal:
        return ElevatedButton(
          onPressed: onPress,
          child: SizedBox(
            height: 7.h,
            width: 100.w,
            child: Center(
              child: Text(text!),
            ),
          ),
        );
      case ButtonType.google:
        return ElevatedButton(
          onPressed: onPress,
          child: SizedBox(
            height: 7.h,
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.google),
                SizedBox(width: 2.w),
                const Text('Ingresar con Google')
              ],
            ),
          ),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPress,
          child: Text(
            text!,
            style: style,
          ),
        );
      default:
        return Container();
    }
  }
}
