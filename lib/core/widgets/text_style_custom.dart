import 'package:flutter/material.dart';

class TextStyleCustom {
  static TextStyle titleLarge = TextStyle(
    fontSize: ThemeData.light()
        .copyWith(useMaterial3: true)
        .textTheme
        .displayLarge!
        .fontSize,
  );
}
