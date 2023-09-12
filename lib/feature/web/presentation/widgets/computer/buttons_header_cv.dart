import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/button_custom.dart';

class ButtonsHeaderCV extends StatelessWidget {
  const ButtonsHeaderCV({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonCustom.text(
            text: 'Inicio',
            onPress: () {},
          ),
          SizedBox(width: 1.w),
          ButtonCustom.text(
            text: 'Beneficios',
            onPress: () {},
          ),
          SizedBox(width: 1.w),
          ButtonCustom.text(
            text: 'Nosotros',
            onPress: () {},
          ),
          SizedBox(width: 1.w),
          ButtonCustom.text(
            text: 'Descargarnos',
            onPress: () {},
          ),
          ButtonCustom.text(
            text: 'Contactos',
            onPress: () {},
          ),
          SizedBox(width: 1.w),
          ElevatedButton(
            onPressed: () {},
            child: SizedBox(
              height: 5.h,
              child: const Center(
                child: Text('Soy Veterinaria', textAlign: TextAlign.center),
              ),
            ),
          ),
          SizedBox(width: 1.w),
          ElevatedButton(
            onPressed: () => context.go(Routes.auth),
            child: SizedBox(
              height: 5.h,
              child: const Center(
                child: Text('Ir a mi libreta'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
