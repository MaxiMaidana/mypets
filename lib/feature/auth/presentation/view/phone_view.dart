import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:mypets/feature/auth/presentation/widget/login_column.dart';
import 'package:sizer/sizer.dart';

class AuthPhoneView extends GetWidget<AuthController> {
  const AuthPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: 100.h,
            child: const LoginColumn(),
          ),
        ),
      ),
    );
  }
}
