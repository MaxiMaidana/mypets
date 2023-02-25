import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../getx/ads_controller.dart';
import 'ad_item.dart';

class AdsPV extends GetView<AdsController> {
  const AdsPV({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          height: 17.h,
          enableInfiniteScroll: false,
        ),
        items: controller.adsList.map((item) => AdItem(adModel: item)).toList(),
      ),
    );
  }
}
