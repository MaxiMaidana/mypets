import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:mypets/data/models/error_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/pet/pet_model.dart';
import '../../../firebase/getx/firebase_controller.dart';
import '../../../home/presentation/getx/home_controller.dart';
import '../../../info_pet_support/presentation/getx/pet_info_support_controller.dart';
import '../../domain/provider/new_pet_provider.dart';

enum PetStep { selectSpecie, name, sex, birthDate, other, last, check }

enum StepCreate { creating, getPets, allOkey, error }

class NewPetController extends GetxController {
  final _firebaseController = Get.find<FirebaseController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController furController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController weigthController = TextEditingController();

  final CarouselController carouselController = CarouselController();

  final NewPetProvider _newPetProvider = NewPetProvider();

  final _petController = Get.find<PetsController>();
  final _homeController = Get.find<HomeController>();
  final _petInfoSupportController = Get.find<PetInfoSupportController>();
  final _appController = Get.find<AppController>();

  Rx<PetStep> petStepToCreate = PetStep.selectSpecie.obs;
  Rx<XFile> petImage = XFile('').obs;
  Rx<PetModel> petModel = PetModel.init().obs;
  Rx<DateTime?> dateTimeToBirthDate = DateTime(2000).obs;
  ErrorModel? errorModel;
  RxString textWaithing =
      'Muy bien ! estamos agregando a tu mascota, aguarde un momento !'.obs;
  RxString textMoreWaithing = ''.obs;
  RxString textCompleteGood = ''.obs;
  RxString textError = ''.obs;
  RxDouble sizeIcon = 25.h.obs;
  RxDouble sizeInputData = 55.h.obs;
  RxString specieSelected = ''.obs;
  RxString sexSelected = ''.obs;

  final List<String> _lsBreeds = [];
  final List<String> _lsFurs = [];
  final List<String> _lsSizes = [];

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    furController.dispose();
    sizeController.dispose();
    weigthController.dispose();
    super.dispose();
  }

  String convertDateTimeToString() {
    String res = '';
    String temp = dateTimeToBirthDate.toString().split(' ').first;
    String year = temp.split('-')[0];
    String month = temp.split('-')[1];
    String day = temp.split('-')[2];
    res = '$day/$month/$year';
    // petModel.value.birthDate = res;
    PetModel newPetModel = petModel.value.copyWith(birthDate: res);
    petModel.value = newPetModel;
    petModel.refresh();
    return res;
  }

  PetModel _createPetModel(String uidUser) => petModel.value.copyWith(
        name: nameController.text,
        birthDate: convertDateTimeToString(),
        breed: breedController.text,
        fur: furController.text,
        size: sizeController.text,
        sex: sexSelected.value,
        species: specieSelected.value,
        weigth: weigthController.text,
        owners: [uidUser],
        remindersId: [],
        vaccine: null,
      );

  Future<void> addPet() async {
    try {
      String uidUser = _firebaseController.firebaseAuth.currentUser!.uid;
      PetModel newPetModel = _createPetModel(uidUser);
      PetModel petModelRes =
          await _newPetProvider.addNewPet(uidUser, newPetModel);
      _appController.userModel!.pets.add(petModelRes.id!);
      await _newPetProvider.updateUserData(
          _firebaseController.firebaseAuth.currentUser!.uid,
          _appController.userModel!);
      await Future.delayed(const Duration(seconds: 2));
      textWaithing.value = '';
      textMoreWaithing.value = 'Un momento mas, retoques finales :P';
      carouselController.nextPage();
      await Future.delayed(const Duration(seconds: 2));
      await _petController.getPets();
      textMoreWaithing.value = '';
      textCompleteGood.value =
          'Buenisimo !!!!!! Ya agregaste a tu mascota !! Ahora podes agregar sus datos veterinarios, queres?';
      carouselController.nextPage();
      _homeController.index.value = 0;
    } catch (e) {
      _homeController.index.value = 0;
      textWaithing.value = '';
      textMoreWaithing.value = '';
      textCompleteGood.value = '';
      textError.value = 'Ohhhh, algo anduvo mal :(';
      carouselController.nextPage();
    }
  }

  List<String> chargeListBreeds() {
    _lsBreeds.clear();
    switch (specieSelected.value) {
      case 'Perro':
        for (var element in _petInfoSupportController.lsSpecies) {
          if (element.type == 'Perro') {
            _lsBreeds.addAll(element.breeds);
          }
        }
        break;
      case 'Gato':
        for (var element in _petInfoSupportController.lsSpecies) {
          if (element.type == 'Gato') {
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
          if (element.type == 'Perro') {
            _lsFurs.addAll(element.furs);
          }
        }
        break;
      case 'Gato':
        for (var element in _petInfoSupportController.lsFurs) {
          if (element.type == 'Gato') {
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
          if (element.type == 'Perro') {
            _lsSizes.addAll(element.sizes);
          }
        }
        break;
      case 'Gato':
        for (var element in _petInfoSupportController.lsSizes) {
          if (element.type == 'Gato') {
            _lsSizes.addAll(element.sizes);
          }
        }
        break;
    }

    return _lsSizes;
  }
}
