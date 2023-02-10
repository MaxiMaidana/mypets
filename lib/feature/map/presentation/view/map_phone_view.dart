import 'package:flutter/material.dart';

import '../widget/map_widget.dart';

class MapPhoneView extends StatelessWidget {
  const MapPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapWidget(),
        Container(
          color: Colors.red,
          height: 100,
          width: 200,
        ),
      ],
    );
  }
}
