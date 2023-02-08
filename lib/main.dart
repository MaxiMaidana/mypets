// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import 'core/app/app.dart';
import 'core/service/local_storage.dart';
import 'core/service/locator.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

// import 'firebase_options.dart';
// import 'package:flutter_web_plugins/src/navigation_non_web/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  await setupLocator();
  usePathUrlStrategy();
  runApp(const MyPetsApp());
}
