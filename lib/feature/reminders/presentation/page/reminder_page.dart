import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/responsive/widget_tree.dart';

import '../getx/reminder_controller.dart';

class ReminderPage extends GetWidget<ReminderController> {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WidgetTree(
          tiny: Text('tiny reminder'),
          largeTablet: Text('large tablet reminder'),
          tablet: Text('tablet reminder'),
          phone: Text('phone reminder'),
          computer: Text('computer reminder'),
        ),
      ),
    );
  }
}
