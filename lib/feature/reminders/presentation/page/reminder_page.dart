import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/core/responsive/widget_tree.dart';
import 'package:mypets/core/widgets/button_custom.dart';

import '../getx/reminder_controller.dart';

class ReminderPage extends GetWidget<ReminderController> {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetTree(
        tiny: const Text('tiny reminder'),
        largeTablet: const Text('large tablet reminder'),
        tablet: const Text('tablet reminder'),
        phone: Column(
          children: [
            Center(
              child: ButtonCustom.principal(
                  text: 'Add Event',
                  onPress: () =>
                      controller.insertReminder(petName: 'asdasdasd')),
            )
          ],
        ),
        computer: const Text('computer reminder'),
      ),
    );
  }
}
