// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/app/app.dart';
import 'core/service/local_storage.dart';
import 'core/service/locator.dart';
import 'firebase_options.dart';

// import 'firebase_options.dart';
// import 'package:flutter_web_plugins/src/navigation_non_web/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await LocalStorage.configPrefs();
  setupLocator();
  runApp(const MyPetsApp());
}
