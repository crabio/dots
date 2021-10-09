// External
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
  ),
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
  ),
  brightness: Brightness.dark,
);
