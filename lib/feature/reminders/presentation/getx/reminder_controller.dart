import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:mypets/feature/info_pet/presentation/getx/info_pet_controller.dart';

import '../../../../data/models/pet/pet_model.dart';
import '../../domain/model/reminder_event.dart';

enum TypeTime { init, finish }

class ReminderController extends GetxController {
  RxDouble heightTotal = 0.0.obs;
  Rx<ReminderEvent> idReminderCreated = ReminderEvent.init().obs;
  RxBool isEdit = false.obs;
  String? eventId;
  RxMap<PetModel, List<Event>> petsReminders = <PetModel, List<Event>>{}.obs;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeInitController = TextEditingController();
  final TextEditingController timeFinishController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController typeController =
      TextEditingController(text: 'Tipo de recordatorio');
  StreamController<ReminderEvent>? reminderEventController =
      StreamController<ReminderEvent>();

  List<String> types = [
    'Veterinario',
    'Remedio',
    'Paseo',
    'Control',
    'Peluqueria'
  ];

  String calendarId = "primary";
  Rx<DateTime?> dateToReminder = DateTime(2000).obs;
  Rx<TimeOfDay?> timeInitToReminder = const TimeOfDay(hour: 0, minute: 0).obs;
  Rx<TimeOfDay?> timeFinishToReminder = const TimeOfDay(hour: 0, minute: 0).obs;

  AuthClient? httpClient;
  CalendarApi? calendarApi;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email', CalendarApi.calendarScope]);

  void cleanAllData() {
    heightTotal.value = 0.0;
    dateToReminder.value = DateTime(2000);
    timeInitToReminder.value = const TimeOfDay(hour: 0, minute: 0);
    timeFinishToReminder.value = const TimeOfDay(hour: 0, minute: 0);
    dateController.text = '';
    timeInitController.text = '';
    timeFinishController.text = '';
    descController.text = '';
    typeController.text = 'Tipo de recordatorio';
    eventId = null;
    isEdit.value = false;
    idReminderCreated.value = ReminderEvent.init();
  }

  void closeStream() {
    reminderEventController?.close();
    // reminderEventController = null;
    reminderEventController = StreamController<ReminderEvent>();
  }

  void openStream() {
    reminderEventController?.stream.listen((reminderEvent) async {
      final infoPetController = Get.find<InfoPetController>();
      switch (reminderEvent.type) {
        case ReminderType.create:
          log('se creo con exito el recordatorio');
          await infoPetController.addReminterInPet(reminderEvent.reminderId);
          Event eventRes = await getReminderData(reminderEvent.reminderId);
          infoPetController.lsEvents.add(eventRes);
          petsReminders[infoPetController.selectPet]!.add(eventRes);
          break;
        case ReminderType.delete:
          log('se elimino con exito el recordatorio');
          infoPetController.selectPet.reminders
              .removeWhere((element) => element == reminderEvent.reminderId);
          infoPetController.isSearchingReminder.value = true;
          await infoPetController.updateReminterInPet();
          infoPetController.lsEvents
              .removeWhere((element) => element.id == reminderEvent.reminderId);
          infoPetController.isSearchingReminder.value = false;
          break;
        case ReminderType.update:
          log('se actualizo con exito el recordatorio');
          infoPetController.isSearchingReminder.value = true;
          Event eventRes = await getReminderData(reminderEvent.reminderId);
          infoPetController.lsEvents
              .removeWhere((element) => element.id == reminderEvent.reminderId);
          infoPetController.lsEvents.add(eventRes);
          infoPetController.isSearchingReminder.value = false;
          break;
        default:
      }
    });
  }

  String setDateText() {
    String date = dateToReminder.toString().split(' ').first;
    String year = date.split('-')[0];
    String month = date.split('-')[1];
    String day = date.split('-')[2];
    return '$day/$month/$year';
  }

  String transformDateTime(String dateToTransform) {
    String date = dateToTransform.split(' ').first;
    String month = date.split('-')[1];
    String day = date.split('-')[2];
    String year = date.split('-')[0];
    if (int.parse(day) == DateTime.now().day) {
      return 'Hoy';
    }
    if (isTomorrow(DateTime.parse(date))) {
      return 'Manaña';
    }
    if (int.parse(year) > DateTime.now().year) {
      return '$day de ${transformToMonth(month)} del $year';
    }
    return '$day de ${transformToMonth(month)}';
  }

  bool isTomorrow(DateTime date) {
    Duration dif = DateTime.now().difference(date);
    return dif.inDays == 1;
  }

  void chargeDataToEdit(Event event, PetModel pet) {
    isEdit.value = true;
    eventId = event.id;
    dateToReminder.value = event.start!.dateTime;
    dateController.text = setDateText();

    timeInitToReminder.value = TimeOfDay(
        hour: event.start!.dateTime!.hour,
        minute: event.start!.dateTime!.minute);
    timeInitController.text = setTimeText(TypeTime.init);

    timeFinishToReminder.value = TimeOfDay(
        hour: event.end!.dateTime!.hour, minute: event.end!.dateTime!.minute);
    timeFinishController.text = setTimeText(TypeTime.finish);

    typeController.text = event.summary!.split(' ').first;
  }

  String transformToMonth(String monthNumber) {
    switch (int.parse(monthNumber)) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
    }
    return '';
  }

  String setTimeText(TypeTime typeTime) {
    String hour = '';
    String minute = '';
    switch (typeTime) {
      case TypeTime.init:
        hour = timeInitToReminder.value!.hour.toString();
        minute = timeInitToReminder.value!.minute == 0
            ? '00'
            : timeInitToReminder.value!.minute.toString();
        break;
      case TypeTime.finish:
        hour = timeFinishToReminder.value!.hour.toString();
        minute = timeFinishToReminder.value!.minute == 0
            ? '00'
            : timeFinishToReminder.value!.minute.toString();
        break;
    }
    return '$hour:$minute';
  }

  Future<void> initCalendarApi() async {
    if (httpClient == null) {
      await _googleSignIn.signInSilently();
      httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient!);
    }
  }

  Future<bool> insertReminder({required String petName}) async {
    try {
      await initCalendarApi();
      Event eventRes = await calendarApi!.events.insert(
        Event(
          summary: '${typeController.text} - $petName',
          description: descController.text,
          start: EventDateTime(
            dateTime: DateTime(
              dateToReminder.value!.year,
              dateToReminder.value!.month,
              dateToReminder.value!.day,
              timeInitToReminder.value!.hour,
              timeInitToReminder.value!.minute,
            ),
            timeZone: "America/Argentina/Buenos_Aires",
          ),
          end: EventDateTime(
            dateTime: DateTime(
              dateToReminder.value!.year,
              dateToReminder.value!.month,
              dateToReminder.value!.day,
              timeFinishToReminder.value!.hour,
              timeFinishToReminder.value!.minute,
            ),
            timeZone: "America/Argentina/Buenos_Aires",
          ),
        ),
        calendarId,
        sendUpdates: 'all',
      );
      if (eventRes.status == 'confirmed') {
        reminderEventController?.add(ReminderEvent(
          type: ReminderType.create,
          reminderId: eventRes.id!,
        ));
        cleanAllData();
      }
      return true;
    } catch (e) {
      log('error al crear recordatorio = ${e.toString()}');
      return false;
    }
  }

  Future<Event> getReminderData(String id) async {
    try {
      log('se trae la info de las mascotas desde reminder controller');
      String calendarId = "primary";
      await initCalendarApi();
      Event eventRes = await calendarApi!.events.get(calendarId, id);
      return eventRes;
    } catch (e) {
      log('fallo traer reminder con id $id');
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> deleteReminder() async {
    try {
      String calendarId = "primary";
      await initCalendarApi();
      await calendarApi!.events.delete(calendarId, eventId!);
      reminderEventController?.add(ReminderEvent(
        type: ReminderType.delete,
        reminderId: eventId!,
      ));
      cleanAllData();
      return true;
    } catch (e) {
      log('fallo eliminar reminder');
      return false;
    }
  }

  Future<bool> editReminder({required String petName}) async {
    try {
      String calendarId = "primary";
      await initCalendarApi();
      Event eventRes = await calendarApi!.events.update(
        Event(
          summary: '${typeController.text} - $petName',
          description: descController.text,
          start: EventDateTime(
            dateTime: DateTime(
              dateToReminder.value!.year,
              dateToReminder.value!.month,
              dateToReminder.value!.day,
              timeInitToReminder.value!.hour,
              timeInitToReminder.value!.minute,
            ),
            timeZone: "America/Argentina/Buenos_Aires",
          ),
          end: EventDateTime(
            dateTime: DateTime(
              dateToReminder.value!.year,
              dateToReminder.value!.month,
              dateToReminder.value!.day,
              timeFinishToReminder.value!.hour,
              timeFinishToReminder.value!.minute,
            ),
            timeZone: "America/Argentina/Buenos_Aires",
          ),
        ),
        calendarId,
        eventId!,
      );
      if (eventRes.status == 'confirmed') {
        reminderEventController?.add(ReminderEvent(
          type: ReminderType.update,
          reminderId: eventId!,
        ));
        cleanAllData();
      }
      return true;
    } catch (e) {
      log('No se pudo editar el reminder $e');
      return false;
    }
  }
}
