import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/image_compress.dart';
import '../../../../data/models/pet/pet_model.dart';
import '../../../app/presentation/getx/app_controller.dart';
import '../../../info_pet/presentation/getx/info_pet_controller.dart';
import '../../../info_pet_support/presentation/getx/pet_info_support_controller.dart';
import '../../../pets/presentation/getx/pets_controller.dart';

class EditInfoPetController extends GetxController {
  late PetModel _petModel;

  setPetModel(PetModel petModel) => _petModel = petModel;

  PetModel get petModel => _petModel;
  PetModel? petModelEdited;

  final _petInfoSupportController = Get.find<PetInfoSupportController>();
  final _infoPetController = Get.find<InfoPetController>();
  final _appController = Get.find<AppController>();
  final _petsController = Get.find<PetsController>();

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

  List<String> speciesList = ['Perro', 'Gato'];
  List<String> sexList = ['Macho', 'Hembra'];

  RxString specieSelected = ''.obs;
  RxString sexSelected = ''.obs;
  RxString photoUrl = ''.obs;
  Rx<CroppedFile> croppedFile = CroppedFile('').obs;
  Rx<XFile> petImage = XFile('').obs;
  RxBool havePhotoEdited = false.obs;
  final picker = ImagePicker();

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
    specieSelected.value = _petModel.species;
    sexSelected.value = _petModel.sex;
    dateTimeToBirthDate.value = DateTime.parse(convertStringToDateTimeFormat());
    dateTimeController.value.text = convertDateTimeToString();
    breedController.text = _petModel.breed ?? '';
    sizeController.text = _petModel.size ?? '';
    furController.text = _petModel.fur ?? '';
    weigthController.text = _petModel.weigth ?? '0.0';
    photoUrl.value = _petModel.photoUrl ?? '';
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

  PetModel _petEdited() => _petModel.copyWith(
        name: nameController.text,
        species: specieSelected.value,
        birthDate: dateTimeController.value.text,
        sex: sexSelected.value,
        breed: breedController.text,
        fur: furController.text,
        weigth: weigthController.text,
        size: sizeController.text,
        photoUrl: photoUrl.value,
      );

  Future<void> editPet() async {
    String newUrl = '';
    PetModel newPetModelEdited;
    try {
      petModelEdited = _petEdited();
      if (havePhotoEdited.value) {
        newUrl = await saveImage();
        newPetModelEdited = petModelEdited!.copyWith(photoUrl: newUrl);
      } else {
        newPetModelEdited = petModelEdited!;
      }
      await _infoPetController.updatePetInfo(petModel.id!, newPetModelEdited);
      if (havePhotoEdited.value) {
        _infoPetController.isSearchPhoto.value = true;
        _infoPetController.urlImagePet.value = newUrl;
        _infoPetController.isSearchPhoto.value = false;
      }
      _infoPetController.setPetModel(newPetModelEdited);
      _infoPetController.selectPet.refresh();
      setPetModel(newPetModelEdited);
      _petsController.petsLs
          .removeWhere((element) => element.id == newPetModelEdited.id);
      _petsController.petsLs.add(newPetModelEdited);
      _petsController.petsLs.refresh();
      // Get.delete<InfoPetController>();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImage() async {
    try {
      photoUrl.value = '';
      // await _infoPetController.deleteImage();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petImage.value = pickedFile;
    }
  }

  Future<String> saveImage() async {
    try {
      _infoPetController.isChargingPhoto.value = true;
      photoUrl.value = '';
      String newName =
          '${_appController.userModel!.dni}${petModelEdited!.id}${petModelEdited!.name}${Random().nextInt(100)}'
              .replaceAll(' ', '');
      File? file;
      if (croppedFile.value.path != '') {
        file = await ImageCompress.compressAndGetFile(
            File(croppedFile.value.path), newName);
      } else {
        file = await ImageCompress.compressAndGetFile(
            File(petImage.value.path), newName);
      }
      String res =
          await _infoPetController.postImagePetFirebase(file!, newName);
      // PetModel newPetModel = _petModel.value.copyWith(photoUrl: petUrlImage);
      // await _infoPetProvider.updatePetData(selectPet.value.id!, newPetModel);
      // setPetModel(newPetModel);
      // photoUrl.value = petUrlImage;
      // _petModel.photoUrl = petUrlImage;
      // await _infoPetProvider.updatePetData(selectPet.id!, _petModel);
      // await getUrlImage();
      _infoPetController.isChargingPhoto.value = false;
      return res;
    } catch (e) {
      _infoPetController.isChargingPhoto.value = false;
      rethrow;
    }
  }

  List<String> chargeListBreeds() {
    _lsBreeds.clear();
    switch (specieSelected.value) {
      case 'Perro':
        for (var element in _petInfoSupportController.lsSpecies) {
          if (element.type == 'Dog') {
            _lsBreeds.addAll(element.breeds);
          }
        }
        break;
      case 'Gato':
        for (var element in _petInfoSupportController.lsSpecies) {
          if (element.type == 'Cat') {
            _lsBreeds.addAll(element.breeds);
          }
        }
        break;
    }
    return _lsBreeds;
  }

  List<String> chargeFurList() {
    _lsFurs.clear();
    switch (specieSelected.value) {
      case 'Perro':
        for (var element in _petInfoSupportController.lsFurs) {
          if (element.type == 'Dog') {
            _lsFurs.addAll(element.furs);
          }
        }
        break;
      case 'Gato':
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
    switch (specieSelected.value) {
      case 'Perro':
        for (var element in _petInfoSupportController.lsSizes) {
          if (element.type == 'Dog') {
            _lsSizes.addAll(element.sizes);
          }
        }
        break;
      case 'Gato':
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
