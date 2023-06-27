import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/core/widgets/button_custom.dart';

class TestCameraPage extends StatelessWidget {
  const TestCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ButtonCustom.principal(
              text: 'camara',
              onPress: () {
                context.push(Routes.camera);
              })),
    );
  }
}
