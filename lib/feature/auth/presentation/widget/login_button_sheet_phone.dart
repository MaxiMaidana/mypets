import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/button_custom.dart';
import '../../../../core/widgets/input_custom.dart';

void buttonSheetLogin(
  BuildContext context, {
  required TextEditingController emailController,
  required TextEditingController passController,
  required Function() credentialsFunction,
  required Function() googleFunction,
}) =>
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 2.h),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    'Ingresar',
                    textAlign: TextAlign.center,
                    style: const TextStyle().copyWith(
                      color: Colors.black,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                InputCustom.base(
                  controller: emailController,
                  hint: 'Email',
                ),
                SizedBox(height: 1.h),
                InputCustom.base(
                  controller: passController,
                  hint: 'Contraseña',
                  isPassword: true,
                ),
                ButtonCustom.text(
                  text: 'Olvide mi contraseña.',
                  onPress: () {},
                ),
                const Spacer(),
                ButtonCustom.principal(
                  text: 'Entremos',
                  onPress: credentialsFunction,
                ),
                SizedBox(height: 1.h),
                ButtonCustom.loginGoogle(
                  onPress: googleFunction,
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
