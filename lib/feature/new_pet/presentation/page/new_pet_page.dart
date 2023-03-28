import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/new_pet_pv.dart';

class NewPetPage extends GetWidget<NewPetController> {
  const NewPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // resizeToAvoidBottomInset: false,
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: NewPetsPV(),
        tablet: Text('tablet'),
        largeTablet: Text('largeTablet'),
        computer: Text('computer'),
      ),
    );
  }
}
