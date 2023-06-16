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
  late PetModel _petModel;
  Rx<CroppedFile> croppedFile = CroppedFile('').obs;
  Rx<XFile> petImage = XFile('').obs;
  final picker = ImagePicker();
  RxBool isSearchPhoto = false.obs;
  RxBool isChargingPhoto = false.obs;
  RxString urlImagePet = ''.obs;
  RxString petYears = ''.obs;
  Stream<ReminderEvent>? idRememberCreated;

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
      urlImagePet.value = '';
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
      PetModel newPetModel = _petModel.copyWith(photoUrl: petUrlImage);
      await _infoPetProvider.updatePetData(selectPet.id!, newPetModel);
      // _petModel.photoUrl = petUrlImage;
      // await _infoPetProvider.updatePetData(selectPet.id!, _petModel);
      await getUrlImage();
      isChargingPhoto.value = false;
    } catch (e) {
      isChargingPhoto.value = false;
      rethrow;
    }
  }

  Future<void> deleteImage() async {
    try {
      urlImagePet.value = '';
      isChargingPhoto.value = true;
      // _petModel.photoUrl = '';
      PetModel newPetModel = _petModel.copyWith(photoUrl: '');
      await _infoPetProvider.deleteImagePetFirebase(
          '${appController.userModel!.dni}${newPetModel.id}${newPetModel.name}');
      await _infoPetProvider.updatePetData(selectPet.id!, newPetModel);
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
        // _petModel.photoUrl = urlImagePet.value;
        PetModel newPetModel = _petModel.copyWith(photoUrl: urlImagePet.value);
        await _infoPetProvider.updatePetData(selectPet.id!, newPetModel);
        isSearchPhoto.value = false;
      } else {
        urlImagePet.value = selectPet.photoUrl!;
      }
    } catch (e) {
      isSearchPhoto.value = false;
      return;
    }
  }

  Future<void> addReminterInPet(String idReminder) async {
    try {
      // PetModel newPetModel = selectPet;
      selectPet.reminders.add(idReminder);
      // newPetModel.reminders.add(idReminder);
      // _infoPetProvider.updatePetData(selectPet.id, newPetModel);
      // _infoPetProvider.updatePetData(selectPet.id!, selectPet);
      await updatePetInfo(selectPet.id!, selectPet);
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
    String year = selectPet.birthDate.split('/')[2];
    String month = selectPet.birthDate.split('/')[1];
    String day = selectPet.birthDate.split('/')[0];

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
    if (reminderController.petsReminders[selectPet] != null) {
      lsEvents.addAll(reminderController.petsReminders[selectPet]!);
    }
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
    // idRememberCreated = reminderController.idReminderCreated.stream;
    // idRememberCreated!.listen((reminderEvent) async {
    //   switch (reminderEvent.type) {
    //     case ReminderType.create:
    //       log('id nuevo, se creo un nuevo evento ${reminderEvent.reminderId}');
    //       await addReminterInPet(reminderEvent.reminderId);
    //       Event eventRes = await reminderController
    //           .getReminderData(reminderEvent.reminderId);
    //       lsEvents.add(eventRes);
    //       reminderController.petsReminders[selectPet]!.add(eventRes);
    //       break;
    //     case ReminderType.delete:
    //       log('id existente, se elimino el id ${reminderEvent.reminderId}');
    //       _petModel.reminders
    //           .removeWhere((element) => element == reminderEvent.reminderId);
    //       isSearchingReminder.value = true;
    //       await _infoPetProvider.updatePetData(selectPet.id!, _petModel);
    //       lsEvents
    //           .removeWhere((element) => element.id == reminderEvent.reminderId);
    //       isSearchingReminder.value = false;
    //       break;
    //     case ReminderType.update:
    //       log('id existente, se edito el id ${reminderEvent.reminderId}');
    //       isSearchingReminder.value = true;
    //       Event eventRes = await reminderController
    //           .getReminderData(reminderEvent.reminderId);
    //       lsEvents
    //           .removeWhere((element) => element.id == reminderEvent.reminderId);
    //       lsEvents.add(eventRes);
    //       isSearchingReminder.value = false;
    //       break;
    //     default:
    //   }
    // });

    super.onReady();
  }
}
