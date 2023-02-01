import 'package:flutter/material.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/register_phone_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: RegisterPhoneView(),
        tablet: Text('tablet'),
        largeTablet: Text('tablet large'),
        computer: Text('computer'),
      ),
    );
  }
}
