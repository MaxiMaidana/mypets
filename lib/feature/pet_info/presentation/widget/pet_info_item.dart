import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PetInfoItem extends StatelessWidget {
  final String title;
  final String info;
  const PetInfoItem({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15.h,
          width: 30.w,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Text(info, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
