import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AboutUsCV extends StatelessWidget {
  const AboutUsCV({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          children: [
            SizedBox(
              width: 25.w,
              child: Image.asset('assets/about-us.png'),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About Us',
                    style: const TextStyle().copyWith(
                      color: Colors.black,
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge!.fontSize,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.',
                    style: const TextStyle().copyWith(
                      color: Colors.black,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
