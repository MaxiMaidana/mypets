import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:mypets/core/widgets/input_custom.dart';
import 'package:mypets/feature/edit_info_pet.dart/presentation/getx/edit_info_pet_controller.dart';
import 'package:mypets/feature/info_pet/presentation/getx/info_pet_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/dialog_custom.dart';
import '../../../new_pet/presentation/widget/custom_search_delegate.dart';
import '../../../new_pet/presentation/widget/drop_down_menu_custom.dart';

class EditInfoPetPV extends GetWidget<EditInfoPetController> {
  const EditInfoPetPV({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        Get.delete<InfoPetController>();
        return true;
      },
      child: GestureDetector(
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
                      onTap: () {
                        context.pop();
                        Get.delete<InfoPetController>();
                      },
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
                Obx(
                  () => controller.havePhotoEdited.value &&
                          (controller.petImage.value.path != '' ||
                              controller.croppedFile.value.path != '')
                      ? Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 160,
                                height: 160,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: controller.croppedFile.value.path != ''
                                      ? Image.file(
                                          File(controller
                                              .croppedFile.value.path),
                                          width: 130,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(controller.petImage.value.path),
                                          width: 130,
                                          height: 130,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () => DialogCustom
                                        .infoDialogWhitOptionsCustom(
                                      context,
                                      title: 'Eliminar Foto',
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ButtonCustom.principalShort(
                                              text: 'Mejor no',
                                              onPress: () => context.pop(),
                                            ),
                                            ButtonCustom.principalShort(
                                              text: 'Eliminar',
                                              onPress: () async {
                                                controller.deleteImage();
                                                controller.havePhotoEdited
                                                    .value = false;
                                                controller.petImage.value =
                                                    XFile('');
                                                controller.croppedFile.value =
                                                    CroppedFile('');
                                                context.pop();
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                      message:
                                          'Estas seguro que quieres eliminar esta foto de perfil de tu mascota?',
                                      content: [],
                                    ),
                                    child: Container(
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
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _uploadFile(context, controller),
                                    child: Container(
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : controller.photoUrl.value == ''
                          ? Stack(
                              children: [
                                Container(
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
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.h),
                                    child: Image.asset(
                                      controller.specieSelected.value == 'Perro'
                                          ? 'assets/perro-sin-foto.jpg'
                                          : 'assets/gatito-sin-foto.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () =>
                                        _uploadFile(context, controller),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : CachedNetworkImage(
                              imageUrl: controller.photoUrl.value,
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
                                        borderRadius:
                                            BorderRadius.circular(25.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () => DialogCustom
                                              .infoDialogWhitOptionsCustom(
                                            context,
                                            title: 'Eliminar Foto',
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ButtonCustom.principalShort(
                                                    text: 'Mejor no',
                                                    onPress: () =>
                                                        context.pop(),
                                                  ),
                                                  ButtonCustom.principalShort(
                                                    text: 'Eliminar',
                                                    onPress: () async {
                                                      controller.deleteImage();
                                                      controller.havePhotoEdited
                                                          .value = false;
                                                      controller.petImage
                                                          .value = XFile('');
                                                      controller.croppedFile
                                                              .value =
                                                          CroppedFile('');
                                                      context.pop();
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                            message:
                                                'Estas seguro que quieres eliminar esta foto de perfil de tu mascota?',
                                            content: [],
                                          ),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              _uploadFile(context, controller),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              errorWidget: (context, url, error) => Container(
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
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25.h),
                                  child: Image.asset(
                                    'assets/problemas_tecnicos.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                ),
                SizedBox(height: 2.h),
                InputCustom.base(controller: controller.nameController),
                SizedBox(height: 1.5.h),
                DropDownMenuCustom(
                  initTitle: controller.petModel.species,
                  valueCharged: controller.petModel.species,
                  items: controller.speciesList,
                  function: (v) => controller.specieSelected.value = v,
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
                  initTitle: 'Sexo',
                  valueCharged: controller.sexSelected.value,
                  items: controller.sexList,
                  function: (v) => controller.sexSelected.value = v,
                ),
                SizedBox(height: 1.5.h),
                GestureDetector(
                  onTap: () => showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      ls: controller.chargeListBreeds(),
                      function: (result) =>
                          controller.breedController.text = result,
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
                        hint: controller.weigthController.text == ''
                            ? 'ej: 0.0'
                            : controller.weigthController.text,
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
                    context.pop();
                  },
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage(EditInfoPetController controller) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: controller.petImage.value.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      cropStyle: CropStyle.rectangle,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
    );
    if (croppedFile != null) {
      controller.croppedFile.value = croppedFile;
    }
  }

  Future<void> _uploadFile(
      BuildContext context, EditInfoPetController controller) async {
    controller.croppedFile.value = CroppedFile('');
    await controller.uploadImage();
    if (controller.petImage.value.path != '') {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => Obx(
            () => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.croppedFile.value.path != ''
                      ? Image.file(File(controller.croppedFile.value.path))
                      : controller.petImage.value.path != ''
                          ? Image.file(File(controller.petImage.value.path))
                          : Container(),
                  const SizedBox(height: 20),
                  ButtonCustom.principalShort(
                    text: 'Me gusta',
                    onPress: () {
                      controller.havePhotoEdited.value = true;
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 5),
                  ButtonCustom.principalShort(
                    text: 'Editar',
                    onPress: () => _cropImage(controller),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}
