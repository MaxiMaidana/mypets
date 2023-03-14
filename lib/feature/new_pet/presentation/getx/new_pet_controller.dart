import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:mypets/data/models/error_model.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

import '../../../../data/models/pet/pet_model.dart';
import '../../../firebase/getx/firebase_controller.dart';
import '../../../home/presentation/getx/home_controller.dart';
import '../../domain/provider/new_pet_provider.dart';

enum PetStep { selectSpecie, name, sex, birthDate, other, last, check }

enum StepCreate { creating, getPets, allOkey, error }

class NewPetController extends GetxController {
  // File _imageFile;
  // final picker = ImagePicker();
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
    petModel.value.birthDate = res;
    petModel.refresh();
    return res;
  }

  Future<void> addPet() async {
    try {
      petModel.value.owners
          .add(_firebaseController.firebaseAuth.currentUser!.uid);
      await _newPetProvider.addNewPet(
          _firebaseController.firebaseAuth.currentUser!.uid, petModel.value);
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
}
