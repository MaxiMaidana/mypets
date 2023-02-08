import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/theme/theme_provider.dart';
import 'package:mypets/feature/app/controller/app_controller.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../routes/go_routes.dart';
import '../theme/themes.dart';

class MyPetsApp extends StatelessWidget {
  const MyPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          final theme = Provider.of<ThemeProvider>(context);
          return MaterialApp.router(
            title: 'My Pets',
            debugShowCheckedModeBanner: false,
            routerConfig: goRouter,
            theme: theme.getTheme(),
          );
        },
      ),
    );
  }
}
