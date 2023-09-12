import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarouselImagesCV extends StatefulWidget {
  const CarouselImagesCV({super.key});

  @override
  State<CarouselImagesCV> createState() => _CarouselImagesCVState();
}

class _CarouselImagesCVState extends State<CarouselImagesCV> {
  List<String> lsImages = [
    'assets/banners/banner1.jpg',
    'assets/banners/banner2.jpg',
    'assets/banners/banner3.jpg',
    'assets/banners/banner4.jpg',
    // 'https://media.istockphoto.com/id/930281684/es/foto/perros-y-gatos-leerlo-sobre-banner-web.jpg?s=170667a&w=0&k=20&c=TIOdxnkz4mAbyWfgskoyJx6NpFmebwdbQaVrW5vT5mg=',
    // 'https://media.istockphoto.com/id/1162593054/es/foto/perros-y-gatos-j%C3%B3venes-por-encima-de-la-bandera-gris.jpg?s=1024x1024&w=is&k=20&c=zrPV_lE0gEydZTWgCFHIWRWvGD1a0fDajsKj7moKsCY=',
    // 'https://mva.org/wp-content/uploads/2022/08/pv-banner-1080x400-1.jpg',
    // 'https://www.bracebridge.ca/en/live-here/resources/Images/Banner--Animal-Services.jpg',
    // 'https://www.marathon.ca/en/living-here/resources/Images/Animal-Banner-3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: CarouselSlider.builder(
          itemCount: lsImages.length,
          options: CarouselOptions(
            height: 350,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
          ),
          itemBuilder: (context, index, realIndex) {
            return Image.asset(
              lsImages[index],
              fit: BoxFit.fitWidth,
            );
          }),
    );
  }
}
