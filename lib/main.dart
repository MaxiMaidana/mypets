import 'package:flutter/material.dart';

import 'core/app/app.dart';
import 'core/service/local_storage.dart';
import 'core/service/locator.dart';
// import 'package:flutter_web_plugins/src/navigation_non_web/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configPrefs();
  setupLocator();
  runApp(const MyPetsApp());
}
