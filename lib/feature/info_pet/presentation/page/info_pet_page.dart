import 'package:flutter/material.dart';
import '../../../../core/responsive/widget_tree.dart';
import '../view/info_pet_pv.dart';

class InfoPetPage extends StatelessWidget {
  const InfoPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WidgetTree(
          tiny: Text('tiny'),
          phone: InfoPetPV(),
          tablet: Text('tablet'),
          largeTablet: Text('largeTablet'),
          computer: Text('computer'),
        ),
      ),
    );
  }
}
