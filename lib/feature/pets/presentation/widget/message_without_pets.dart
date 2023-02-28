import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageWithoutPets extends StatelessWidget {
  const MessageWithoutPets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.donut_large_rounded,
            size: 180,
          ),
          SizedBox(height: 1.h),
          Text(
            ' Aca vas a poder ver a todas las mascotas que tengas.',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
