import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:mypets/feature/edit_info_pet.dart/presentation/getx/edit_info_pet_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../new_pet/presentation/widget/custom_search_delegate.dart';
import '../../../new_pet/presentation/widget/drop_down_menu_custom.dart';

class EditInfoPetPV extends GetWidget<EditInfoPetController> {
  const EditInfoPetPV({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
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
                  Text(
                    'PetBook',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 40, width: 40),
                ],
              ),
              SizedBox(height: 2.h),
              CachedNetworkImage(
                imageUrl: controller.petModel.photoUrl ?? '',
                placeholder: (context, url) => SizedBox(
                  width: 150,
                  height: 150,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.h),
                      ),
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                errorWidget: (context, url, error) => SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/problemas_tecnicos.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              InputCustom.base(controller: controller.nameController),
              SizedBox(height: 1.5.h),
              DropDownMenuCustom(
                initTitle: controller.petModel.species,
                valueCharged: controller.petModel.species,
                items: controller.species,
                function: (v) => controller.editSpecie(v),
              ),
              SizedBox(height: 1.5.h),
              GestureDetector(
                onTap: () => showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    ls: controller.chargeListBreeds(),
                    function: (result) => result,
                  ),
                ),
                child: InputCustom.base(
                  controller: controller.breedController,
                  hint: 'Raza',
                  isEnable: false,
                  icon: const Icon(Icons.search),
                ),
              ),
              SizedBox(height: 1.5.h),
              GestureDetector(
                onTap: () async {
                  controller.dateTimeToBirthDate.value = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  controller.dateTimeController.value.text =
                      controller.convertDateTimeToString();
                },
                child: Obx(
                  () => InputCustom.base(
                    controller: controller.dateTimeController.value,
                    isEnable: false,
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              DropDownMenuCustom(
                initTitle: 'Tamaño',
                valueCharged: controller.sizeController.text,
                items: controller.chargeSizesList(),
                function: (v) => controller.sizeController.text = v,
              ),
              SizedBox(height: 1.5.h),
              DropDownMenuCustom(
                initTitle: 'Pelaje',
                valueCharged: controller.furController.text,
                items: controller.chargeFurList(),
                function: (v) => controller.furController.text = v,
              ),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  Expanded(
                    child: InputCustom.base(
                      controller: controller.weigthController,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Kg',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              ButtonCustom.principal(
                text: 'Guardar',
                onPress: () {
                  controller.editPet();
                },
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
