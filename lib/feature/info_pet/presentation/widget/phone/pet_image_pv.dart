import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:sizer/sizer.dart';

import '../../getx/info_pet_controller.dart';

class PetImagePV extends GetWidget<PetInfoController> {
  const PetImagePV({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: Obx(
        () => controller.isSearchPhoto.value
            ? const SizedBox(
                width: double.infinity,
              )
            : controller.urlImagePet.value != ''
                ? CachedNetworkImage(
                    alignment: Alignment.topCenter,
                    imageUrl: controller.urlImagePet.value,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonCustom.principalShort(
                          text: 'Subir foto',
                          onPress: () async {
                            await controller.uploadImage();
                            showDialog(
                              context: context,
                              builder: (context) => Obx(
                                () => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      controller.croppedFile.value.path != ''
                                          ? Image.file(File(controller
                                              .croppedFile.value.path))
                                          : Image.file(File(
                                              controller.petImage.value.path)),
                                      SizedBox(height: 20),
                                      ButtonCustom.principalShort(
                                        text: 'Guardar',
                                        onPress: () async {
                                          context.pop();
                                          context.loaderOverlay.show();
                                          await controller.saveImage();
                                          context.loaderOverlay.hide();
                                        },
                                      ),
                                      SizedBox(height: 5),
                                      ButtonCustom.principalShort(
                                        text: 'Editar',
                                        onPress: () => _cropImage(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
      ),
    );
  }

  Future<void> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: controller.petImage.value.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    );
    if (croppedFile != null) {
      controller.croppedFile.value = croppedFile;
    }
  }
}
