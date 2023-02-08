import 'package:flutter/material.dart';

ThemeData ligthMode = ThemeData.light(useMaterial3: true).copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.purple[200],
    secondary: Colors.grey[300],
    background: Colors.white70,
  ),
);

ThemeData darkMode = ThemeData.dark(useMaterial3: true);
