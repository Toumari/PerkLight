import 'package:flutter/material.dart';

final Color _primaryColor = Color(0xff21213b);
final Color _accentColor = Colors.redAccent;

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor,
  primaryColorBrightness: Brightness.dark,
  accentColor: _accentColor,
  accentColorBrightness: Brightness.light,
  canvasColor: Color(0xff21213b),
  scaffoldBackgroundColor: Color(0xff21213b),
  buttonColor: _accentColor,
  toggleableActiveColor: _accentColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white
  ),
);
