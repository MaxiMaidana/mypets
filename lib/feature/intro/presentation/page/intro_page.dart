import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/service/local_storage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('aca va el carousel del intro'),
            ElevatedButton(
              child: Text('Ingresar  :)'),
              onPressed: () {
                LocalStorage.setPref(SetPref.isFirstTime, true);
                context.go(Routes.auth);
              },
            )
          ],
        ),
      ),
    );
  }
}
