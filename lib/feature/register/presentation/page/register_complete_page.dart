import 'package:flutter/material.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/phone/register_complete_pv.dart';

class RegisterCompletePage extends StatelessWidget {
  const RegisterCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WidgetTree(
          computer: Text('computer register complete'),
          largeTablet: Text('largeTablet register complete'),
          tablet: Text('tablet register complete'),
          tiny: Text('tiny register complete'),
          phone: RegisterCompletePV(),
        ),
      ),
    );
  }
}
