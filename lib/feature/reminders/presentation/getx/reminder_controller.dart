import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

// import 'package:googleapis/calendar/v3.dart';

class ReminderController extends GetxController {
// For storing the CalendarApi object, this can be used
  // for performing all the operations
  // static var calendar;
  RxDouble heightTotal = 0.0.obs;

  CalendarApi? calendarApi;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', CalendarApi.calendarScope],
  );

  Future<void> initCalendarApi() async {
    // bool isSigned = await _googleSignIn.isSignedIn();
    if (calendarApi == null) {
      await _googleSignIn.signInSilently();
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      calendarApi = CalendarApi(httpClient);
    }
  }

  // For creating a new calendar event
  Future<void> insert(
      // {
      // required String title,
      // required String description,
      // required String location,
      // required List<EventAttendee> attendeeEmailList,
      // required bool shouldNotifyAttendees,
      // required bool hasConferenceSupport,
      // required DateTime startTime,
      // required DateTime endTime,
      // }
      ) async {
    String calendarId = "primary";
    var httpClient = (await _googleSignIn.authenticatedClient())!;
    calendarApi = CalendarApi(httpClient);
    Event eventRes = await calendarApi!.events.insert(
      Event(
        summary: 'titulo',
        description: 'descripcion ejemplo',
        start: EventDateTime(
          // dateTime: DateTime(2023, 3, 26, 19, 30),
          dateTime: DateTime(2023, 3, 26, 17, 30),
          timeZone: "America/Argentina/Buenos_Aires",
        ),
        end: EventDateTime(
          // dateTime: DateTime(2023, 3, 26, 20, 00),
          dateTime: DateTime(2023, 3, 26, 18, 30),
          timeZone: "America/Argentina/Buenos_Aires",
        ),
      ),
      calendarId,
    );
    log('se agrego el evento ? ${eventRes.status}');
    // return {};
  }

  // For patching an already-created calendar event
  Future<Map<String, String>> modify({
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
