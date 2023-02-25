import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/ads/presentation/getx/ads_controller.dart';
import 'package:sizer/sizer.dart';

import '../../domain/model/ad_model.dart';

class AdItem extends GetWidget<AdsController> {
  final AdModel adModel;
  const AdItem({super.key, required this.adModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 7),
        child: Container(
          height: 15.h,
          width: 80.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4.0,
                  offset: const Offset(0, 4),
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: adModel.imageUrl,
              errorWidget: (context, url, error) => Icon(Icons.percent),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
