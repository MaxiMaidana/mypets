import 'package:flutter/material.dart';
import 'package:mypets/core/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _themeData;

  // ThemeProvider(this._themeData);

  ThemeData getTheme() => _themeData ?? ligthMode;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
