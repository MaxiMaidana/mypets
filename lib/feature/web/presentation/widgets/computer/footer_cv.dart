import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FooterCV extends StatelessWidget {
  const FooterCV({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      height: 35.h,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/playstore.png', height: 30),
              Image.asset('assets/appstore.png', height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
