import 'package:shared_preferences/shared_preferences.dart';

enum SetPref { isFirstTime, auth }

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configPrefs() async =>
      prefs = await SharedPreferences.getInstance();

  static Future<void> setPref(SetPref setPref, bool value) async {
    switch (setPref) {
      case SetPref.isFirstTime:
        prefs.setBool('isFirstTime', value);
        break;
      case SetPref.auth:
        prefs.setBool('auth', value);
        break;
      default:
    }
  }

  static bool getPref(SetPref setPref) {
    switch (setPref) {
      case SetPref.isFirstTime:
        return prefs.getBool('isFirstTime') ?? false;
      case SetPref.auth:
        return prefs.getBool('auth') ?? false;
    }
  }
}
