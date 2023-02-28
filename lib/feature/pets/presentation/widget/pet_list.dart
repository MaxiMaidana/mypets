import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';
import 'add_pet_button.dart';

class PetList extends GetWidget<PetsController> {
  const PetList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...List.generate(
            controller.petsLs.length,
            (i) => InkWell(
              onTap: () => context.push(Uri(
                  path: Routes.infoPet,
                  queryParameters: {
                    'id': controller.petsLs[i].id.toString()
                  }).toString()),
              child: Column(
                children: [
                  Container(
                    height: 17.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CachedNetworkImage(
                        //   height: 20.h,
                        //   imageUrl: controller
                        //       .petsLs[i].photoUrl!,
                        //   errorWidget:
                        //       (context, url, error) =>
                        //           const Icon(Icons.error),
                        // ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            SizedBox(width: 5.w),
                            Text(
                              controller.petsLs[i].name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Expanded(
                          child: Center(
                            child: Icon(
                              Icons.pets,
                              size: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
          const AddPetButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
