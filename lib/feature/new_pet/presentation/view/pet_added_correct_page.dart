import 'package:flutter/material.dart';

import '../../../../core/responsive/widget_tree.dart';
import '../widget/phone/pet_added_complete_pv.dart';

class PetAddedCorrectPage extends StatelessWidget {
  const PetAddedCorrectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WidgetTree(
          computer: Text('computer register complete'),
          largeTablet: Text('largeTablet register complete'),
          tablet: Text('tablet register complete'),
          tiny: Text('tiny register complete'),
          phone: PetAddedCompletePV(),
        ),
      ),
    );
  }
}
