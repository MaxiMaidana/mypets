import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:mypets/feature/pets/presentation/view/pets_phone_view.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../../../profile/presentation/view/profile_phone_view.dart';
import '../view/home_c_v.dart';
import '../view/home_init_p_v.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WidgetTree(
          tiny: const Text('tiny'),
          phone: const HomeInitPV(),
          tablet: Obx(
            () => IndexedStack(
              index: controller.index.value,
              children: const [
                HomeInitPV(),
                PetsPhoneView(),
                ProfilePhoneView(),
              ],
            ),
          ),
          largeTablet: const Text('tablet large'),
          computer: const HomeCV(),
        ),
        drawer: GetPlatform.isWeb
            ? null
            : ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Center(
                        child: Text(
                          'PetBook',
                          style: GoogleFonts.sora(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Clinicas'),
                        leading: const Icon(Icons.local_hospital),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Info'),
                        leading: const Icon(Icons.info),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Mapa'),
                        leading: const Icon(Icons.map_outlined),
                        onTap: () {
                          context.pop();
                          context.push(Routes.map);
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
