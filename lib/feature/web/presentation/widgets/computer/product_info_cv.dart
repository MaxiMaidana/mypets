import 'package:flutter/material.dart';

class ProductInfoCV extends StatelessWidget {
  const ProductInfoCV({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Titulo de algo',
          style: const TextStyle().copyWith(
            color: Colors.black,
            fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
          ),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: 600,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla paria',
            style: const TextStyle().copyWith(
              color: Colors.black,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            ),
          ),
        ),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _item(context),
            _item(context),
            _item(context),
            _item(context),
          ],
        ),
      ],
    );
  }

  Widget _item(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 100,
              child: Text(
                'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.',
                style: const TextStyle().copyWith(
                  color: Colors.black,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                ),
              ),
            )
          ],
        ),
      );
}
