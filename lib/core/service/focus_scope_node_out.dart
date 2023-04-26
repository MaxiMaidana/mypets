import 'package:flutter/material.dart';

void focusScopeNodeOut(BuildContext context) {
  final FocusScopeNode focus = FocusScope.of(context);
  if (!focus.hasPrimaryFocus && focus.hasFocus) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
