import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/firebase/getx/firebase_controller.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

import '../../../../core/utils/image_compress.dart';
import '../../domain/provider/info_pet_provider.dart';

class PetInfoController extends GetxController {
  late String petId;
  final PetsController petsController = Get.find();
  final AppController appController = Get.find();
  final FirebaseController _firebaseController = Get.find();
  final InfoPetProvider _infoPetProvider = InfoPetProvider();

  late PetModel _petModel;
  File? _imageFile;
  Rx<XFile> petImage = XFile('').obs;
  final picker = ImagePicker();
  RxBool isSearchPhoto = false.obs;
  RxString urlImagePet = ''.obs;

  void setPetId(String id) => petId = id;

  setPetModel(PetModel petModel) => _petModel = petModel;

  PetModel get selectPet => _petModel;

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petImage.value = pickedFile;
      String newName =
          '${appController.userModel!.dni}${_petModel.id}${_petModel.name}'
              .replaceAll(' ', '');
      File? file = await ImageCompress.compressAndGetFile(
          File(pickedFile.path), newName);
      String petUrlImage =
          await _infoPetProvider.postImagePetFirebase(file!, newName);
      _petModel.photoUrl = petUrlImage;
      await _infoPetProvider.updatePetData(selectPet.id, _petModel);
      await getUrlImage();
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

  @override
  void onReady() {
    getUrlImage();
    super.onReady();
  }
}
