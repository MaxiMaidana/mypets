import 'package:flutter/material.dart';

import '../../../../core/responsive/widget_tree.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: Text('phone'),
        tablet: Text('tablet'),
        largeTablet: Text('tablet large'),
        computer: Text('computer'),
      ),
    );
  }
}
