import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../routes/go_routes.dart';

class MyPetsApp extends StatelessWidget {
  const MyPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp.router(
        title: 'My Pets',
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}
