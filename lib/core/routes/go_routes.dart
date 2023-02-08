import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/firebase/firebase_controller.dart';
import 'package:mypets/feature/intro/presentation/page/intro_page.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

import '../../feature/auth/presentation/getx/auth_controller.dart';
import '../../feature/auth/presentation/page/auth_page.dart';
import '../../feature/home/presentation/getx/home_controller.dart';
import '../../feature/home/presentation/page/home_page.dart';
import '../../feature/new_pet/presentation/getx/new_pet_controller.dart';
import '../../feature/new_pet/presentation/page/new_pet_page.dart';
import '../../feature/pet_info/presentation/getx/info_pet_controller.dart';
import '../../feature/pet_info/presentation/page/info_pet_page.dart';
import '../../feature/profile/presentation/getx/profile_controller.dart';
import '../../feature/register/presentation/getx/register_controller.dart';
import '../../feature/register/presentation/page/register_page.dart';
import '../../feature/web/presentation/page/main_web_page.dart';
import '../service/local_storage.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'shell');
GoRouter goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Routes.main,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: Routes.main,
      redirect: (context, state) {
        if (!GetPlatform.isWeb) {
          if (!LocalStorage.getPref(SetPref.isFirstTime)) {
            return Routes.intro;
          } else if (LocalStorage.getPref(SetPref.auth)) {
            return Routes.home;
          } else {
            return Routes.auth;
          }
        }
        return Routes.main;
      },
      builder: (context, state) {
        if (GetPlatform.isAndroid || GetPlatform.isIOS) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
        return const WebMainPage();
      },
    ),
    GoRoute(
      path: Routes.intro,
      builder: (context, state) {
        return const IntroPage();
      },
    ),
    GoRoute(
      path: Routes.auth,
      builder: (context, state) {
        Get.put(AuthController());
        return const AuthPage();
      },
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) {
        Get.put(RegisterController());
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        Get.put(HomeController(), permanent: true);
        Get.put(ProfileController(), permanent: true);
        Get.put(PetsController(), permanent: true);
        return const HomePage();
      },
    ),
    GoRoute(
      path: Routes.newPet,
      builder: (context, state) {
        Get.put(NewPetController());
        return const NewPetPage();
      },
    ),
    GoRoute(
      path: Routes.infoPet,
      builder: (context, state) {
        final infoPetController = Get.put(InfoPetController());
        infoPetController.setPetId(state.queryParams['id']!);
        infoPetController.setPetModel();
        return const InfoPetPage();
      },
    ),
    // ShellRoute(
    //   navigatorKey: _shellNavigatorKey,
    //   builder: (BuildContext context, GoRouterState state, Widget child) {
    //     return HomeLayout(child: child);
    //   },
    //   routes: <RouteBase>[
    //     GoRoute(
    //       path: Routes.home,
    //       builder: (BuildContext context, GoRouterState state) {
    //         LocalStorage.setPref('inicio_pos', true);
    //         LocalStorage.setPref('products_pos', false);
    //         LocalStorage.setPref('sales_pos', false);
    //         LocalStorage.setPref('stock_pos', false);
    //         return const HomeView();
    //       },
    //     ),
    //     GoRoute(
    //       path: Routes.products,
    //       builder: (BuildContext context, GoRouterState state) {
    //         LocalStorage.setPref('products_pos', true);
    //         LocalStorage.setPref('inicio_pos', false);
    //         LocalStorage.setPref('sales_pos', false);
    //         LocalStorage.setPref('stock_pos', false);
    //         return const ProductsView();
    //       },
    //     ),
    //     GoRoute(
    //       path: '${Routes.products}/:id',
    //       builder: (BuildContext context, GoRouterState state) {
    //         return ProductsItemView(
    //             nailPolishId: state.params['id'] ?? 'Error');
    //       },
    //     ),
    //     GoRoute(
    //       path: Routes.sales,
    //       builder: (BuildContext context, GoRouterState state) {
    //         LocalStorage.setPref('sales_pos', true);
    //         LocalStorage.setPref('inicio_pos', false);
    //         LocalStorage.setPref('products_pos', false);
    //         LocalStorage.setPref('stock_pos', false);
    //         return const SalesView();
    //       },
    //     ),
    //     GoRoute(
    //       path: Routes.stock,
    //       builder: (BuildContext context, GoRouterState state) {
    //         LocalStorage.setPref('stock_pos', true);
    //         LocalStorage.setPref('inicio_pos', false);
    //         LocalStorage.setPref('products_pos', false);
    //         LocalStorage.setPref('sales_pos', false);
    //         return const StockView();
    //       },
    //     ),
    //   ],
    // ),
    // GoRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   path: Routes.errorPage,
    //   builder: (context, state) => const Page404(),
    // ),
  ],
);
