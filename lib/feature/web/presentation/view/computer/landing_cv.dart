import 'package:flutter/material.dart';
import 'package:mypets/feature/web/presentation/widgets/computer/footer_cv.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/computer/about_us_cv.dart';
import '../../widgets/computer/buttons_header_cv.dart';
import '../../widgets/computer/carousel_images_cv.dart';
import '../../widgets/computer/contact_us.dart';
import '../../widgets/computer/product_info_cv.dart';

class LadingPageCV extends StatefulWidget {
  const LadingPageCV({super.key});

  @override
  State<LadingPageCV> createState() => _LadingPageCVState();
}

class _LadingPageCVState extends State<LadingPageCV> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Column(
          children: const [
            ButtonsHeaderCV(),
            SizedBox(height: 20),
            CarouselImagesCV(),
            SizedBox(height: 40),
            ProductInfoCV(),
            SizedBox(height: 40),
            AboutUsCV(),
            SizedBox(height: 40),
            ContactWithUsCV(),
            SizedBox(height: 40),
            FooterCV(),
          ],
        ),
      ),
    );
  }
}
