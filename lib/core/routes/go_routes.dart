import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/auth/presentation/getx/auth_controller.dart';
import 'package:mypets/feature/firebase/firebase_controller.dart';
import 'package:mypets/feature/splash/presentation/page/intro_page.dart';

import '../../feature/app/controller/app_controller.dart';
import '../../feature/auth/presentation/page/auth_page.dart';
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
        if (GetPlatform.isAndroid || GetPlatform.isIOS) {
          if (!LocalStorage.getPref('isFirstTime')) {
            return Routes.intro;
          } else if (LocalStorage.getPref('auth')) {
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
