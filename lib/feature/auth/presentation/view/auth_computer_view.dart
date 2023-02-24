import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../getx/auth_controller.dart';
import '../widget/login_column_c_v.dart';

class AuthComputeView extends GetWidget<AuthController> {
  const AuthComputeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl:
                  'https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/10/Growlithe-and-Arcanine-Sword--Shield.jpg',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: const LoginColumCV(),
            ),
          )
        ],
      ),
    );
  }
}
