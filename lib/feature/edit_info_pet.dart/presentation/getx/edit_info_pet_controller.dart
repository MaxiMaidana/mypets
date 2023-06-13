import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/pet/pet_model.dart';
import '../../../info_pet/presentation/getx/info_pet_controller.dart';
import '../../../info_pet_support/presentation/getx/pet_info_support_controller.dart';

class EditInfoPetController extends GetxController {
  late PetModel _petModel;

  setPetModel(PetModel petModel) => _petModel = petModel;

  PetModel get petModel => _petModel;
  PetModel? petModelEdited;
  RxString actualSpecie = ''.obs;

  final _petInfoSupportController = Get.find<PetInfoSupportController>();
  final _infoPetProvider = Get.find<InfoPetController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController weigthController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController furController = TextEditingController();
  final Rx<TextEditingController> dateTimeController =
      TextEditingController().obs;

  Rx<DateTime?> dateTimeToBirthDate = DateTime(2000).obs;
  final List<String> _lsBreeds = [];
  final List<String> _lsFurs = [];
  final List<String> _lsSizes = [];

  List<String> species = ['Perro', 'Gato'];

  @override
  void dispose() {
    nameController.dispose();
    weigthController.dispose();
    breedController.dispose();
    sizeController.dispose();
    furController.dispose();
    super.dispose();
  }

  void setData() {
    nameController.text = _petModel.name;
    breedController.text = _petModel.breed ?? '';
    sizeController.text = _petModel.size ?? '';
    furController.text = _petModel.fur ?? '';
    actualSpecie.value = _petModel.species;
    weigthController.text = _petModel.weigth ?? '';
    dateTimeToBirthDate.value = DateTime.parse(convertStringToDateTimeFormat());
    dateTimeController.value.text = convertDateTimeToString();
  }

  String convertStringToDateTimeFormat() {
    String res = '';
    String year = _petModel.birthDate.split('/')[2];
    String month = _petModel.birthDate.split('/')[1];
    String day = _petModel.birthDate.split('/')[1];
    res = '$year-$month-$day';
    return res;
  }

  String convertDateTimeToString() {
    String res = '';
    String temp = dateTimeToBirthDate.toString().split(' ').first;
    String year = temp.split('-')[0];
    String month = temp.split('-')[1];
    String day = temp.split('-')[2];
    res = '$day/$month/$year';
    return res;
  }

  Future<void> editPet() async {
    try {
      petModelEdited = _petModel.copyWith(
        birthDate: dateTimeController.value.text,
        breed: breedController.text,
        fur: furController.text,
        name: nameController.text,
        weigth: weigthController.text,
        species: sizeController.text,
        size: sizeController.text,
        sex: _petModel.sex,
        photoUrl: _petModel.photoUrl,
      );
      log(petModelEdited!.toString());
      // await _infoPetProvider.updatePetInfo(petModel.id!, petModelEdited!);
    } catch (e) {
      rethrow;
    }
  }

  List<String> chargeListBreeds() {
    _lsBreeds.clear();
    switch (petModelEdited!.species) {
      case 'Dog':
        for (var element in _petInfoSupportController.lsSpecies) {
          if (element.type == 'Dog') {
            _lsBreeds.addAll(element.breeds);
          }
        }
        break;
      case 'Cat':
        for (var element in _petInfoSupportController.lsSpecies) {
          if (element.type == 'Cat') {
            _lsBreeds.addAll(element.breeds);
          }
        }
        break;
    }
    return _lsBreeds;
  }

  void editSpecie(String specie) {
    if (specie == 'Perro') {
      petModelEdited = _petModel.copyWith(species: 'Dog');
    } else {
      petModelEdited = _petModel.copyWith(species: 'Cat');
      // petModelEdited!.copyWith(species: 'Cat');
      // petModelEdited!.species = 'Cat';
    }
  }

  List<String> chargeFurList() {
    _lsFurs.clear();
    switch (_petModel.species) {
      case 'Dog':
        for (var element in _petInfoSupportController.lsFurs) {
          if (element.type == 'Dog') {
            _lsFurs.addAll(element.furs);
          }
        }
        break;
      case 'Cat':
        for (var element in _petInfoSupportController.lsFurs) {
          if (element.type == 'Cat') {
            _lsFurs.addAll(element.furs);
          }
        }
        break;
    }

    return _lsFurs;
  }

  List<String> chargeSizesList() {
    _lsSizes.clear();
    switch (_petModel.species) {
      case 'Dog':
        for (var element in _petInfoSupportController.lsSizes) {
          if (element.type == 'Dog') {
            _lsSizes.addAll(element.sizes);
          }
        }
        break;
      case 'Cat':
        for (var element in _petInfoSupportController.lsSizes) {
          if (element.type == 'Cat') {
            _lsSizes.addAll(element.sizes);
          }
        }
        break;
    }

    return _lsSizes;
  }
}
