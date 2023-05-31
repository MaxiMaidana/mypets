import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/button_custom.dart';
import '../../../../core/widgets/dialog_custom.dart';
import '../../../../core/widgets/input_custom.dart';

class LoginButtonSheetPV extends GetWidget<AuthController> {
  const LoginButtonSheetPV({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {},
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
              child: SizedBox(
                height: 75.h,
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
                      controller: controller.emailController,
                      hint: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 1.h),
                    InputCustom.base(
                      controller: controller.passController,
                      hint: 'Contraseña',
                      isPassword: true,
                    ),
                    ButtonCustom.text(
                      text: 'Olvide mi contraseña.',
                      onPress: () => context.push(Routes.changePassword),
                    ),
                    const Spacer(),
                    ButtonCustom.principal(
                      text: 'Entremos',
                      onPress: () async {
                        context.loaderOverlay.show();
                        await controller.logIn(
                            loginType: LoginType.credentials);
                        if (context.mounted) {
                          context.loaderOverlay.hide();
                        }
                        switch (controller.userStatus.value) {
                          case UserStatus.dataCompleted:
                            if (context.mounted) {
                              context.go(Routes.home);
                            }
                            Get.delete<AuthController>(force: true);
                            break;
                          case UserStatus.needCompleteData:
                            if (context.mounted) {
                              context.push(Routes.register);
                            }
                            break;
                          case UserStatus.needValidateEmail:
                            if (context.mounted) {
                              context.push(Routes.register);
                            }
                            break;
                          case UserStatus.error:
                            if (context.mounted) {
                              DialogCustom.infoDialog(
                                context,
                                title: controller.errorModel!.code,
                                message: controller.errorModel!.message,
                              );
                            }
                            break;
                          default:
                        }
                      },
                    ),
                    SizedBox(height: 0.5.h),
                    ButtonCustom.loginGoogle(
                      text: 'Ingresar con Google',
                      onPress: () async {
                        context.loaderOverlay.show();
                        await controller.logIn(loginType: LoginType.google);
                        if (context.mounted) {
                          context.loaderOverlay.hide();
                        }
                        switch (controller.userStatus.value) {
                          case UserStatus.dataCompleted:
                            Get.delete<AuthController>(force: true);
                            if (context.mounted) {
                              context.go(Routes.home);
                            }
                            break;
                          case UserStatus.needCompleteData:
                            if (context.mounted) {
                              context.push(Routes.register);
                            }
                            break;
                          case UserStatus.needValidateEmail:
                            if (context.mounted) {
                              context.push(Routes.register);
                            }
                            break;
                          case UserStatus.error:
                            if (context.mounted) {
                              DialogCustom.infoDialog(
                                context,
                                title: controller.errorModel!.code,
                                message: controller.errorModel!.message,
                              );
                            }
                            break;
                          default:
                        }
                      },
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// void buttonSheetLogin(
//   BuildContext context, {
//   required TextEditingController emailController,
//   required TextEditingController passController,
//   required Function() credentialsFunction,
//   required Function() googleFunction,
//   required Function() changePassword,
// }) =>
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       builder: (context) => Container(
//         color: Colors.transparent,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 SizedBox(height: 2.h),
//                 SizedBox(
//                   width: 100.w,
//                   child: Text(
//                     'Ingresar',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle().copyWith(
//                       color: Colors.black,
//                       fontSize:
//                           Theme.of(context).textTheme.titleLarge!.fontSize,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 3.h),
//                 InputCustom.base(
//                   controller: emailController,
//                   hint: 'Email',
//                   textInputType: TextInputType.emailAddress,
//                 ),
//                 SizedBox(height: 1.h),
//                 InputCustom.base(
//                   controller: passController,
//                   hint: 'Contraseña',
//                   isPassword: true,
//                 ),
//                 ButtonCustom.text(
//                   text: 'Olvide mi contraseña.',
//                   onPress: changePassword,
//                 ),
//                 const Spacer(),
//                 ButtonCustom.principal(
//                   text: 'Entremos',
//                   onPress: credentialsFunction,
//                 ),
//                 SizedBox(height: 1.h),
//                 ButtonCustom.loginGoogle(
//                   text: 'Ingresar con Google',
//                   onPress: googleFunction,
//                 ),
//                 SizedBox(height: 2.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
