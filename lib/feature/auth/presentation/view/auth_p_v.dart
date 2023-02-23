import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:mypets/feature/auth/presentation/widget/login_column_p_v.dart';
import 'package:sizer/sizer.dart';

class AuthPV extends GetWidget<AuthController> {
  const AuthPV({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.heightTotal.value = 0.0;
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        body: GestureDetector(
          onTap: () => controller.heightTotal.value = 0.0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: 100.h,
              child: const LoginColumnPV(),
            ),
          ),
        ),
      ),
    );
  }
}
