import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';
import 'package:sizer/sizer.dart';

class PetsPhoneView extends GetView<PetsController> {
  const PetsPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        controller.obx(
          (state) => SizedBox(
            height: 75.h,
            child: ListView(
              children: List.generate(
                state.length,
                (i) => InkWell(
                  onTap: () => context.push(Uri(
                          path: Routes.infoPet,
                          queryParameters: {'id': state[i].id.toString()})
                      .toString()),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        height: 20.h,
                        imageUrl: state[i].photoUrl!,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Text(state[i].name),
                      const SizedBox(height: 10),
                      Text(state[i].type),
                      const SizedBox(height: 10),
                      Text(state[i].race),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          onLoading: const CircularProgressIndicator(),
          onEmpty: const Icon(Icons.not_interested),
          onError: (error) => Text(error ?? 'Error'),
        ),
        ElevatedButton(
          onPressed: () => context.push(Routes.newPet),
          child: Column(
            children: [
              SizedBox(height: 0.5.h),
              const Text('Agregar mascota'),
              const Icon(Icons.add),
              SizedBox(height: 0.5.h),
            ],
          ),
        )
      ],
    );
  }
}
