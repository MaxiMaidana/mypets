import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:sizer/sizer.dart';

import '../../getx/register_controller.dart';

class RegisterPV extends GetView<RegisterController> {
  const RegisterPV({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 96.5.h,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => context.go(Routes.main),
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Registro',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.emailController,
                hint: 'Email*',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.passController,
                hint: 'Controseña*',
              ),
              SizedBox(height: 2.h),
              InputCustom.base(
                controller: controller.confirmPassController,
                hint: 'Repetir Contraseña*',
              ),
              const Spacer(),
              ButtonCustom.principal(
                text: 'Registrarme',
                onPress: () => controller.statusRegister.value =
                    StatusRegister.emailSended,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ya tenes cuenta?'),
                  ButtonCustom.text(
                    text: 'Logueate',
                    onPress: () => context.go(Routes.main),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
