import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypets/data/models/pet/pet_model.dart';
import 'package:mypets/feature/app/presentation/getx/app_controller.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';

import '../../../../core/utils/image_compress.dart';
import '../../../reminders/domain/model/reminder_event.dart';
import '../../../reminders/presentation/getx/reminder_controller.dart';
import '../../domain/provider/info_pet_provider.dart';

class InfoPetController extends GetxController {
  final PetsController petsController = Get.find();
  final AppController appController = Get.find();
  final ReminderController reminderController = Get.find();
  final InfoPetProvider _infoPetProvider = InfoPetProvider();

  late String petId;

  RxList<Event> lsEvents = RxList<Event>();
  RxBool isSearchingReminder = false.obs;
  Rx<PetModel> _petModel = PetModel.init().obs;
  Rx<CroppedFile> croppedFile = CroppedFile('').obs;
  Rx<XFile> petImage = XFile('').obs;
  final picker = ImagePicker();
  RxBool isSearchPhoto = false.obs;
  RxBool isChargingPhoto = false.obs;
  RxString urlImagePet = ''.obs;
  RxString petYears = ''.obs;
  Stream<ReminderEvent>? idRememberCreated;

  void setPetId(String id) => petId = id;

  void setPetModel(PetModel petModel) => _petModel.value = petModel;

  Rx<PetModel> get selectedPet => _petModel;

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
      urlImagePet.value = '';
      String newName =
          '${appController.userModel!.dni}${_petModel.value.id}${_petModel.value.name}'
              .replaceAll(' ', '');
      File? file;
      if (croppedFile.value.path != '') {
        file = await ImageCompress.compressAndGetFile(
            File(croppedFile.value.path), newName);
      } else {
        file = await ImageCompress.compressAndGetFile(
            File(petImage.value.path), newName);
      }
      String petUrlImage = await postImagePetFirebase(file!, newName);
      PetModel newPetModel = _petModel.value.copyWith(photoUrl: petUrlImage);
      await _infoPetProvider.updatePetData(selectedPet.value.id!, newPetModel);
      setPetModel(newPetModel);
      urlImagePet.value = petUrlImage;
      // _petModel.photoUrl = petUrlImage;
      // await _infoPetProvider.updatePetData(selectPet.id!, _petModel);
      await getUrlImage();
      isChargingPhoto.value = false;
    } catch (e) {
      isChargingPhoto.value = false;
      rethrow;
    }
  }

  Future<String> postImagePetFirebase(File file, String newName) async {
    try {
      String res = await _infoPetProvider.postImagePetFirebase(file, newName);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImage() async {
    try {
      urlImagePet.value = '';
      isChargingPhoto.value = true;
      PetModel newPetModel = _petModel.value.copyWith(photoUrl: '');
      await _infoPetProvider.deleteImagePetFirebase(
          '${appController.userModel!.dni}${newPetModel.id}${newPetModel.name}');
      await _infoPetProvider.updatePetData(selectedPet.value.id!, newPetModel);
      isChargingPhoto.value = false;
    } catch (e) {
      isChargingPhoto.value = false;
      rethrow;
    }
  }

  Future<void> getUrlImage() async {
    try {
      // if (selectPet.value.photoUrl == '') {
      //   isSearchPhoto.value = true;
      //   urlImagePet.value = await _infoPetProvider.urlImagePet(
      //       '${appController.userModel!.dni}${_petModel.value.id}${_petModel.value.name}');
      //   // _petModel.photoUrl = urlImagePet.value;
      //   PetModel newPetModel =
      //       _petModel.value.copyWith(photoUrl: urlImagePet.value);
      //   await _infoPetProvider.updatePetData(selectPet.value.id!, newPetModel);
      //   isSearchPhoto.value = false;
      // } else {
      urlImagePet.value = selectedPet.value.photoUrl!;
      // }
    } catch (e) {
      isSearchPhoto.value = false;
      return;
    }
  }

  Future<void> addReminterInPet(String idReminder) async {
    try {
      // PetModel newPetModel = selectPet;
      selectedPet.value.remindersId.add(idReminder);
      // newPetModel.reminders.add(idReminder);
      // _infoPetProvider.updatePetData(selectPet.id, newPetModel);
      // _infoPetProvider.updatePetData(selectPet.id!, selectPet);
      await updatePetInfo(selectedPet.value.id!, selectedPet.value);
    } catch (e) {
      log('Rompio agregar reminder $e');
      return;
    }
  }

  Future<void> updatePetInfo(String id, PetModel petModel) async {
    try {
      await _infoPetProvider.updatePetData(id, petModel);
    } catch (e) {
      log('Rompio agregar reminder $e');
      return;
    }
  }

  String calculateYars() {
    String year = selectedPet.value.birthDate.split('/')[2];
    String month = selectedPet.value.birthDate.split('/')[1];
    String day = selectedPet.value.birthDate.split('/')[0];

    int difDays =
        DateTime.now().difference(DateTime.parse('$year-$month-$day')).inDays;

    double difYears = difDays / 365;
    if (difYears < 0.12) {
      double difWeeks = difYears * 7;
      int dif = int.parse(difWeeks.toString().split('.').last.substring(0, 1));
      return dif == 1 ? '${dif.round()} semana' : '${dif.round()} semanas';
    }
    if (difYears < 1) {
      double difMonths = difYears * 12;
      String months = difMonths.toString().split('.').first;
      return months == '1' ? '$months mes' : '$months meses';
    }
    String dif = difYears.toString().split('.').first;
    return dif == '1' ? '$dif año' : '$dif años';
  }

  void chargeEvents() {
    if (selectedPet.value.lsEvents!.isNotEmpty) {
      lsEvents.addAll(selectedPet.value.lsEvents!);
    }
    // if (reminderController.petsReminders[selectPet.value] != null) {
    //   lsEvents.addAll(reminderController.petsReminders[selectPet.value]!);
    // }
  }

  bool checkISValidDateTimeEvent(DateTime toEvaluate) {
    DateTime now = DateTime.now();
    if (toEvaluate.year > now.year) {
      return true;
    }
    if (toEvaluate.day > now.day && toEvaluate.month <= now.month) {
      return true;
    }
    if (toEvaluate.day < now.day && toEvaluate.month < now.month) {
      return true;
    }
    TimeOfDay timeNow = TimeOfDay.now();
    if (timeNow.hour > toEvaluate.hour) {
      return true;
    }
    if (timeNow.minute > toEvaluate.hour) {
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    reminderController.closeStream();
    super.onClose();
  }

  @override
  void onReady() {
    getUrlImage();
    chargeEvents();
    petYears.value = calculateYars();
    reminderController.openStream();
    super.onReady();
  }
}
