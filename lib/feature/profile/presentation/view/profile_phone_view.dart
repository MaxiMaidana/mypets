import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../getx/profile_controller.dart';

class ProfilePhoneView extends GetWidget<ProfileController> {
  const ProfilePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.h),
              child: CachedNetworkImage(
                imageUrl: controller.userProfile!.photoURL!,
                height: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${controller.userProfile!.displayName}',
              style: GoogleFonts.roboto(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              '${controller.userProfile!.email}',
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
                      controller.logOut();

                      context.go(Routes.auth);
                    },
                    child: const ListTile(
                      title: Text('Cerrar Sesion'),
                      leading: FaIcon(Icons.logout),
                      trailing:
                          FaIcon(Icons.arrow_forward_ios_rounded, size: 15),
                    ),
                  ),
                ],
              ),
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
