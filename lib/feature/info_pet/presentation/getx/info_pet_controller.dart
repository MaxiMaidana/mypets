import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

import '../../../../core/utils/image_compress.dart';
import '../../domain/provider/info_pet_provider.dart';

class PetInfoController extends GetxController {
  late String petId;
  final PetsController petsController = Get.find();
  final AppController appController = Get.find();
  final InfoPetProvider _infoPetProvider = InfoPetProvider();

  late PetModel _petModel;
  Rx<CroppedFile> croppedFile = CroppedFile('').obs;
  Rx<XFile> petImage = XFile('').obs;
  final picker = ImagePicker();
  RxBool isSearchPhoto = false.obs;
  RxBool isChargingPhoto = false.obs;
  RxString urlImagePet = ''.obs;
  RxInt petYears = 0.obs;

  void setPetId(String id) => petId = id;

  setPetModel(PetModel petModel) => _petModel = petModel;

  PetModel get selectPet => _petModel;

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petImage.value = pickedFile;
    }
  }

  Future<void> saveImage() async {
    try {
      isChargingPhoto.value = true;
      String newName =
          '${appController.userModel!.dni}${_petModel.id}${_petModel.name}'
              .replaceAll(' ', '');
      File? file;
      if (croppedFile.value.path != '') {
        file = await ImageCompress.compressAndGetFile(
            File(croppedFile.value.path), newName);
      } else {
        file = await ImageCompress.compressAndGetFile(
            File(petImage.value.path), newName);
      }
      String petUrlImage =
          await _infoPetProvider.postImagePetFirebase(file!, newName);
      _petModel.photoUrl = petUrlImage;
      await _infoPetProvider.updatePetData(selectPet.id, _petModel);
      await getUrlImage();
      isChargingPhoto.value = false;
    } catch (e) {
      isChargingPhoto.value = false;
      rethrow;
    }
  }

  Future<void> getUrlImage() async {
    try {
      if (selectPet.photoUrl == '') {
        isSearchPhoto.value = true;
        urlImagePet.value = await _infoPetProvider.urlImagePet(
            '${appController.userModel!.dni}${_petModel.id}${_petModel.name}');
        _petModel.photoUrl = urlImagePet.value;
        await _infoPetProvider.updatePetData(selectPet.id, _petModel);
        isSearchPhoto.value = false;
      } else {
        urlImagePet.value = selectPet.photoUrl!;
      }
    } catch (e) {
      isSearchPhoto.value = false;
      return;
    }
  }

  int calculateYars() {
    String year = selectPet.birthDate.split('/').last;
    String month = selectPet.birthDate.split('/')[1];
    String day = selectPet.birthDate.split('/').first;

    int difDays =
        DateTime.now().difference(DateTime.parse('$year-$month-$day')).inDays;

    double difYears = difDays / 365;
    return difYears.round();
  }

  @override
  void onReady() {
    getUrlImage();
    petYears.value = calculateYars();
    super.onReady();
  }
}
