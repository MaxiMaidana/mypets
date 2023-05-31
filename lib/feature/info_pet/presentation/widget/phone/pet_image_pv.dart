import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypets/core/widgets/button_custom.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/widgets/dialog_custom.dart';
import '../../getx/info_pet_controller.dart';

class PetImagePV extends GetWidget<InfoPetController> {
  const PetImagePV({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: double.infinity,
      child: Obx(
        () => controller.isSearchPhoto.value
            ? const SizedBox(
                width: double.infinity,
              )
            : controller.urlImagePet.value != ''
                ? GestureDetector(
                    onLongPress: () {
                      DialogCustom.infoDialogWhitOptionsCustom(context,
                          title: '¿Que hacemos?',
                          actions: [],
                          content: [
                            ButtonCustom.principal(
                              text: 'Eliminar Foto',
                              onPress: () {
                                controller.deleteImage();
                                if (context.mounted) {
                                  context.pop();
                                }
                              },
                            ),
                            ButtonCustom.principal(
                              text: 'Cambiar Foto',
                              onPress: () async {
                                context.pop();
                                _uploadFile(context, controller);
                              },
                            )
                          ]);
                    },
                    child: SizedBox(
                      height: 300,
                      child: CachedNetworkImage(
                        alignment: Alignment.topCenter,
                        imageUrl: controller.urlImagePet.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : controller.isChargingPhoto.value
                    ? const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()))
                    : SizedBox(
                        height: 230,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonCustom.principalShort(
                              text: 'Subir foto',
                              onPress: () async =>
                                  _uploadFile(context, controller),
                            )
                          ],
                        ),
                      ),
      ),
    );
  }

  Future<void> _cropImage(InfoPetController controller) async {
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
      BuildContext context, InfoPetController controller) async {
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
                    text: 'Guardar',
                    onPress: () {
                      controller.saveImage();
                      controller.petImage.value = XFile('');
                      controller.croppedFile.value = CroppedFile('');
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
