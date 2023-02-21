import 'package:shared_preferences/shared_preferences.dart';

enum SetPref { isFirstTime, auth, emailUser, passUser }

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configPrefs() async =>
      prefs = await SharedPreferences.getInstance();

  static Future<void> setPref(
      {required SetPref setPref, bool? dataBool, String? dataString}) async {
    switch (setPref) {
      case SetPref.isFirstTime:
        prefs.setBool('isFirstTime', dataBool!);
        break;
      case SetPref.auth:
        prefs.setBool('auth', dataBool!);
        break;
      case SetPref.emailUser:
        prefs.setString('emailUser', dataString!);
        break;
      case SetPref.passUser:
        prefs.setString('passUser', dataString!);
        break;
      default:
    }
  }

  static bool getPrefBool(SetPref setPref) {
    if (setPref == SetPref.isFirstTime) {
      return prefs.getBool('isFirstTime') ?? false;
    }
    if (setPref == SetPref.auth) {
      return prefs.getBool('auth') ?? false;
    }
    return false;
  }

  static String getPrefString(SetPref setPref) {
    if (setPref == SetPref.emailUser) {
      return prefs.getString('emailUser') ?? '';
    }
    if (setPref == SetPref.passUser) {
      return prefs.getString('passUser') ?? '';
    }
    return '';
  }
}
