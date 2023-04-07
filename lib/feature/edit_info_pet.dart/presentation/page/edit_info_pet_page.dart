import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../../../info_pet/presentation/getx/info_pet_controller.dart';
import '../view/edit_info_pet_pv.dart';

class EditInfoPetPage extends GetWidget<PetInfoController> {
  const EditInfoPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WidgetTree(
          tiny: Text('tiny'),
          phone: EditInfoPetPV(),
          tablet: Text('tablet'),
          largeTablet: Text('largeTablet'),
          computer: Text('computer'),
        ),
      ),
    );
  }
}
