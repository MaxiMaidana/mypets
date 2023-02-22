import 'package:flutter/material.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/change_password_pv.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: ChangePasswordPV(),
        tablet: Text('tablet'),
        largeTablet: Text('tablet large'),
        computer: Text('computer view'),
      ),
    );
  }
}
