import 'package:flutter/material.dart';
import '../../../../core/responsive/widget_tree.dart';
import '../view/map_phone_view.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WidgetTree(
        tiny: Text('tiny'),
        phone: MapPhoneView(),
        tablet: Text('tablet'),
        largeTablet: Text('tablet large'),
        computer: Text('pc'),
      ),
    );
  }
}
