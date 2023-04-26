import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/responsive/widget_tree.dart';

import '../getx/reminder_controller.dart';
import '../view/reminders_pv.dart';

class ReminderPage extends GetWidget<ReminderController> {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny reminder'),
        largeTablet: Text('large tablet reminder'),
        tablet: Text('tablet reminder'),
        phone: RemindersPV(),
        computer: Text('computer reminder'),
      ),
    );
  }
}
