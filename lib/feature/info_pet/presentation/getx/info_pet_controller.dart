import 'dart:developer';
import 'dart:io';

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

class PetInfoController extends GetxController {
  late String petId;
  final PetsController petsController = Get.find();
  final AppController appController = Get.find();
  final ReminderController reminderController = Get.find();
  final InfoPetProvider _infoPetProvider = InfoPetProvider();

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
      _petModel.photoUrl = petUrlImage;
      await _infoPetProvider.updatePetData(selectPet.id, _petModel);
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
      _petModel.photoUrl = '';
      await _infoPetProvider.deleteImagePetFirebase(
          '${appController.userModel!.dni}${_petModel.id}${_petModel.name}');
      await _infoPetProvider.updatePetData(selectPet.id, _petModel);
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

  Future<void> addReminterInPet(String idReminder) async {
    try {
      PetModel newPetModel = selectPet;
      newPetModel.reminders.add(idReminder);
      _infoPetProvider.updatePetData(selectPet.id, newPetModel);
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

  Future<void> getAlEvents() async {
    try {
      List<String> remindersToDelete = [];
      if (selectPet.reminders.isNotEmpty) {
        isSearchingReminder.value = true;
        for (String reminderId in selectPet.reminders) {
          Event eventRes = await reminderController.getReminderData(reminderId);
          if (checkIfISValidDateTime(eventRes.end!.dateTime!)) {
            lsEvents.add(eventRes);
          } else {
            remindersToDelete.add(reminderId);
          }
        }
        if (remindersToDelete.isNotEmpty) {
          for (var reminderId in remindersToDelete) {
            selectPet.reminders.removeWhere((element) => element == reminderId);
          }
          await _infoPetProvider.updatePetData(selectPet.id, selectPet);
        }
        isSearchingReminder.value = false;
      }
    } catch (e) {
      return;
    }
  }

  bool checkIfISValidDateTime(DateTime toEvaluate) {
    DateTime now = DateTime.now();
    if (toEvaluate.year > now.year) {
      return true;
    }
    if (toEvaluate.day > now.day && toEvaluate.month <= now.month) {
      return true;
    }
    if (toEvaluate.day < now.day && toEvaluate.month >= now.month) {
      return true;
    }
    return false;
  }

  @override
  void onReady() {
    getUrlImage();
    getAlEvents();
    petYears.value = calculateYars();
    reminderController.idReminderCreated.listen((reminderEvent) async {
      switch (reminderEvent.type) {
        case ReminderType.create:
          log('id nuevo, se creo un nuevo evento');
          await addReminterInPet(reminderEvent.reminderId);
          Event eventRes = await reminderController
              .getReminderData(reminderEvent.reminderId);
          lsEvents.add(eventRes);
          break;
        case ReminderType.delete:
          log('id existente, se elimino el id ${reminderEvent.reminderId}');
          _petModel.reminders
              .removeWhere((element) => element == reminderEvent.reminderId);
          await _infoPetProvider.updatePetData(selectPet.id!, _petModel);
          lsEvents.clear();
          getAlEvents();
          break;
        case ReminderType.update:
          log('id existente, se edito el id ${reminderEvent.reminderId}');
          lsEvents.clear();
          getAlEvents();
          break;
        default:
      }
    });
    super.onReady();
  }
}
