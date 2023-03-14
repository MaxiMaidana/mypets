import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:sizer/sizer.dart';

import '../getx/info_pet_controller.dart';
import '../widget/phone/row_pet_info_pv.dart';

class InfoPetPhoneView extends GetWidget<PetInfoController> {
  const InfoPetPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 110.h,
        child: Stack(
          children: [
            SizedBox(
              height: 100.h,
              child: CachedNetworkImage(
                alignment: Alignment.topCenter,
                imageUrl:
                    'https://www.mundoperro.net/wp-content/uploads/Cocker-Spaniel-Ingles-1200x900.jpg',
                height: 40.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w),
                      child: Row(
                        children: [
                          Text(
                            controller.selectPet.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 10),
                          controller.selectPet.species == 'Dog'
                              ? const FaIcon(FontAwesomeIcons.dog)
                              : const FaIcon(FontAwesomeIcons.cat),
                          const SizedBox(width: 10),
                          controller.selectPet.sex == 'Male'
                              ? const Icon(Icons.male)
                              : const Icon(Icons.female),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        controller.selectPet.birthDate,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.5),
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const RowPetInfoPV(),
                    const SizedBox(height: 10),
                    Divider(endIndent: 5.w, indent: 5.w, color: Colors.black),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        'Recordatorios',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: 5.w),
                          Container(
                            width: 60.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.greenAccent,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ButtonCustom.principal(
                        text: 'Datos Veterianrios',
                        onPress: () {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ButtonCustom.principal(
                        text: 'Editar Mascota',
                        onPress: () {},
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
