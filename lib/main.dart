// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypets/core/utils/connection/check_internet_connection.dart';

import 'core/app/app.dart';
import 'core/service/locator.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

// import 'firebase_options.dart';
// import 'package:flutter_web_plugins/src/navigation_non_web/url_strategy.dart';
final internetChecker = CheckInternetConnection();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (GetPlatform.isWeb) {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // } else {
  //   await Firebase.initializeApp();
  // }
  // var _clientID = ClientId(Secret.getId(), "");
  // const _scopes = const [cal.CalendarApi.CalendarScope];
  // const _scopes = const [cal.CalendarApi];
  // await clientViaUserConsent(_clientID, _scopes, prompt)
  //     .then((AuthClient client) async {
  //   CalendarClient.calendar = cal.CalendarApi(client);
  // });
  await setupLocator();
  usePathUrlStrategy();
  runApp(const MyPetsApp());
}

// void prompt(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
