import 'package:flutter/material.dart';
import 'package:mypets/feature/auth/presentation/view/computer_view.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/phone_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: AuthPhoneView(),
        tablet: Text('tablet'),
        largeTablet: Text('tablet large'),
        computer: AuthComputeView(),
      ),
    );
  }
}
