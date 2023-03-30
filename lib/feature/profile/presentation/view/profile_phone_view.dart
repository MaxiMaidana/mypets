import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/theme/theme_provider.dart';
import 'package:mypets/core/theme/themes.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../getx/profile_controller.dart';

class ProfilePhoneView extends GetWidget<ProfileController> {
  const ProfilePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            CachedNetworkImage(
              imageUrl: controller.userModel.value.urlPhoto,
              placeholder: (context, url) => SizedBox(
                width: 150,
                height: 150,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.h),
                    ),
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.h),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/problemas_tecnicos.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              controller.userModel.value.name,
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              controller.userModel.value.email,
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black38),
              ),
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Editar Datos'),
                    leading: FaIcon(Icons.edit),
                    trailing: FaIcon(Icons.arrow_forward_ios_rounded, size: 15),
                  ),
                  Divider(endIndent: 2.w, indent: 2.w),
                  const ListTile(
                    title: Text('Noticias'),
                    leading: FaIcon(Icons.newspaper),
                    trailing: FaIcon(Icons.arrow_forward_ios_rounded, size: 15),
                  ),
                  Divider(endIndent: 2.w, indent: 2.w),
                  const ListTile(
                    title: Text('Ayuda'),
                    leading: FaIcon(Icons.help),
                    trailing: FaIcon(Icons.arrow_forward_ios_rounded, size: 15),
                  ),
                  Divider(endIndent: 2.w, indent: 2.w),
                  InkWell(
                    onTap: () {
                      DialogCustom.infoDialogWhitOptions(
                        context,
                        title: 'Desloguearse',
                        message: 'Te estaremos esperado a que vuelvas :)',
                        aceptar: () {
                          controller.logOut();
                          context.go(Routes.auth);
                          Get.delete<HomeController>();
                          // Get.reload<AppController>();
                        },
                      );
                    },
                    child: const ListTile(
                      title: Text('Cerrar Sesion'),
                      leading: FaIcon(Icons.logout),
                      trailing: FaIcon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Text('tema osucro'),
                const Spacer(),
                Obx(
                  () => Switch(
                    value: controller.themeMode.value,
                    onChanged: (v) {
                      if (v) {
                        theme.setTheme(darkMode);
                      } else {
                        theme.setTheme(ligthMode);
                      }
                      controller.changeTheme(v);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('My Pets'),
                Text('Versión ${controller.appVersion}'),
              ],
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
