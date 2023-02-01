import 'package:flutter/material.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/home_phone_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: HomePhoneView(),
        tablet: Text('tablet'),
        largeTablet: Text('tablet large'),
        computer: Text('computer'),
      ),
    );
  }
}
