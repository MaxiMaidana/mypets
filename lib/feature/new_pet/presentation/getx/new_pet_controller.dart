import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:mypets/data/models/error_model.dart';

import '../../../../data/models/pet/pet_model.dart';

enum PetStep { selectSpecie, name, sex, birthDate, other, last, check }

class NewPetController extends GetxController {
  // File _imageFile;
  // final picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController furController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController weigthController = TextEditingController();

  Rx<PetStep> petStepToCreate = PetStep.selectSpecie.obs;
  Rx<XFile> petImage = XFile('').obs;
  Rx<PetModel> petModel = PetModel.init().obs;
  Rx<DateTime?> dateTimeToBirthDate = DateTime(2000).obs;
  ErrorModel? errorModel;

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    furController.dispose();
    sizeController.dispose();
    weigthController.dispose();
    super.dispose();
  }

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petImage.value = pickedFile;
    }
  }

  String convertDateTimeToString() {
    String res = '';
    String temp = dateTimeToBirthDate.toString().split(' ').first;
    String year = temp.split('-')[0];
    String month = temp.split('-')[1];
    String day = temp.split('-')[2];
    res = '$day/$month/$year';
    petModel.value.birthday = res;
    petModel.refresh();
    return res;
  }
}
