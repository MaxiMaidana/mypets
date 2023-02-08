import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/responsive/widget_tree.dart';
import '../getx/info_pet_controller.dart';
import '../view/info_pet_phone_view.dart';

class InfoPetPage extends GetWidget<InfoPetController> {
  const InfoPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WidgetTree(
          tiny: Text('tiny'),
          phone: InfoPetPhoneView(),
          tablet: Text('tablet'),
          largeTablet: Text('largeTablet'),
          computer: Text('computer'),
        ),
      ),
    );
  }
}
