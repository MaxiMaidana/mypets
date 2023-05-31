import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';
import '../../../../data/models/pet/pet_model.dart';

class PetItem extends StatelessWidget {
  final PetModel petModel;
  const PetItem({Key? key, required this.petModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Uri(
          path: Routes.infoPet,
          queryParameters: {'id': petModel.id.toString()}).toString()),
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
                //   height: 5.h,
                //   imageUrl: petModel.photoUrl!,
                //   errorWidget:
                //       (context, url, error) =>
                //           const Icon(Icons.error),
                // ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    SizedBox(width: 5.w),
                    Text(
                      petModel.name[0].toUpperCase() +
                          petModel.name.substring(1),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: FaIcon(
                      petModel.species == 'Dog'
                          ? FontAwesomeIcons.dog
                          : FontAwesomeIcons.cat,
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
    );
  }
}
