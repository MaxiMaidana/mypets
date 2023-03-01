import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:mypets/data/models/error_model.dart';

enum PetStep { selectSpecie, name, sex, birthDate, other, last, check }

class NewPetController extends GetxController {
  // File _imageFile;
  // final picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  Rx<PetStep> petStepToCreate = PetStep.selectSpecie.obs;
  Rx<XFile> petImage = XFile('').obs;

  ErrorModel? errorModel;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petImage.value = pickedFile;
    }
  }
}
