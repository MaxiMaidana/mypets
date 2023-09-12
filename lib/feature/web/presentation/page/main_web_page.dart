import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/computer/landing_cv.dart';

class WebMainPage extends StatelessWidget {
  const WebMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: WidgetTree(
          tiny: Text('tiny'),
          phone: Text('phone'),
          tablet: Text('tablet chica'),
          largeTablet: LadingPageCV(),
          computer: LadingPageCV(),
        ),
      ),
    );
  }
}
