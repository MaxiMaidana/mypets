import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../routes/go_routes.dart';

class MyPetsApp extends StatelessWidget {
  const MyPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          final theme = Provider.of<ThemeProvider>(context);
          return GlobalLoaderOverlay(
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: Center(
                child: CircularProgressIndicator(
                  color: theme.getTheme().primaryColor,
                ),
              ),
              child: MaterialApp.router(
                title: 'PetBook',
                debugShowCheckedModeBanner: false,
                routerConfig: goRouter,
                theme: theme.getTheme(),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  // GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('es', 'ES'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
