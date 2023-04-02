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
  }

  String setDateText() {
    String date = dateToReminder.toString().split(' ').first;
    String year = date.split('-')[0];
    String month = date.split('-')[1];
    String day = date.split('-')[2];
    return '$day/$month/$year';
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
    // bool isSigned = await _googleSignIn.isSignedIn();
    if (calendarApi == null) {
      await _googleSignIn.signInSilently();
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
    }
  }

  // For creating a new calendar event
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
      log(e.toString());
      rethrow;
    }
  }

  // For patching an already-created calendar event
  Future<Map<String, String>> modifyReminder({
    required String id,
    required String title,
    required String description,
    required String location,
    // required List<EventAttendee> attendeeEmailList,
    required bool shouldNotifyAttendees,
    required bool hasConferenceSupport,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    return {};
  }

  // For deleting a calendar event
  Future<void> delete(String eventId, bool shouldNotify) async {}
}
