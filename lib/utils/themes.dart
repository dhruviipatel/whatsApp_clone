import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    // ignore: deprecated_member_use
    backgroundColor: bgDark,
    scaffoldBackgroundColor: bgDark,
  );
}

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      // ignore: deprecated_member_use
      backgroundColor: bgLight,
      scaffoldBackgroundColor: bgLight);
}
