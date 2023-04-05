import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

// import 'package:googleapis/calendar/v3.dart';
enum TypeTime { init, finish }

class ReminderController extends GetxController {
// For storing the CalendarApi object, this can be used
  // for performing all the operations
  // static var calendar;
  RxDouble heightTotal = 0.0.obs;
  RxString idReminderCreated = ''.obs;
  RxBool isEdit = false.obs;
  String? eventId;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeInitController = TextEditingController();
  final TextEditingController timeFinishController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  List<String> types = [
    'Veterinario',
    'Remedio',
    'Paseo',
    'Control',
    'Peluqueria'
  ];

  Rx<DateTime?> dateToReminder = DateTime(2000).obs;
  Rx<TimeOfDay?> timeInitToReminder = const TimeOfDay(hour: 0, minute: 0).obs;
  Rx<TimeOfDay?> timeFinishToReminder = const TimeOfDay(hour: 0, minute: 0).obs;

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
    typeController.text = '';
    eventId = null;
    isEdit.value = false;
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

  void chargeDataToEdit(Event event) {
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
    if (calendarApi == null) {
      await _googleSignIn.signInSilently();
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
    }
  }

  Future<bool> insertReminder({required String petName}) async {
    try {
      String calendarId = "primary";
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
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
        idReminderCreated.value = eventRes.id!;
        cleanAllData();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Event> getReminderData(String id) async {
    try {
      String calendarId = "primary";
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
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
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
      await calendarApi!.events.delete(calendarId, eventId!);
      idReminderCreated.value = eventId!;
      // idReminderCreated.refresh();
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
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
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
        idReminderCreated.value = eventRes.id!;
        idReminderCreated.refresh();
        cleanAllData();
      }
      return true;
    } catch (e) {
      log('No se pudo editar el reminder');
      return false;
    }
  }
}
