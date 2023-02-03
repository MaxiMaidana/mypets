import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePhoneView extends StatelessWidget {
  const ProfilePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 10.h,
          backgroundImage: Image.network(
            'https://i.blogs.es/5fca68/sanji/840_560.jpeg',
            loadingBuilder: (context, child, loadingProgress) =>
                const CircularProgressIndicator(),
          ).image,
        ),
      ],
    );
  }
}
