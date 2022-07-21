import 'package:flutter/material.dart';

final ColorScheme perkLightColorScheme = ColorScheme(
  primary: Color(0xff21213b),
  primaryVariant: Color(0xff21213b),
  secondary: Colors.redAccent,
  secondaryVariant: Colors.redAccent,
  surface: Color(0xff21213b),
  background: Color(0xff21213b),
  error: Colors.redAccent,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);

final ThemeData darkTheme = ThemeData(
    canvasColor: perkLightColorScheme.background,
    toggleableActiveColor: perkLightColorScheme.secondary,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
    colorScheme: perkLightColorScheme);
