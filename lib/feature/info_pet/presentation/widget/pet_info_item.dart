import 'package:flutter/material.dart';

class PetInfoItem extends StatelessWidget {
  final String title;
  final String info;
  const PetInfoItem({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 5),
              Text(
                info,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
