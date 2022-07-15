import 'package:flutter/material.dart';

// Color _primaryColor = Color(0xff21213b);
 Color _primaryColor = Color.fromARGB(255, 32, 32, 32);
// Color _accentColor = Colors.redAccent;
Color _accentColor = Colors.red[600];
// Color _accentColor = Colors.redAccent[700];

Color _secondaryColor = Color(0xff242e37);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor,
  primaryColorBrightness: Brightness.dark,
  accentColor: _accentColor,
  accentColorBrightness: Brightness.light,
  canvasColor: _secondaryColor,
  scaffoldBackgroundColor: _primaryColor,
  buttonColor: _accentColor,
  toggleableActiveColor: _accentColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _secondaryColor,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w100,
    )
  )
);
