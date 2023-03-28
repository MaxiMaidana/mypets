import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mypets/feature/new_pet/presentation/getx/new_pet_controller.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../view/pet_added_complete_pv.dart';

class PetAddedCorrectPage extends GetWidget<NewPetController> {
  const PetAddedCorrectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        computer: Text('computer register complete'),
        largeTablet: Text('largeTablet register complete'),
        tablet: Text('tablet register complete'),
        tiny: Text('tiny register complete'),
        phone: PetAddedCompletePV(),
      ),
    );
  }
}
