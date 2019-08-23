import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/buildConfigurator.dart';
import 'pages/perkPage.dart';
import 'pages/splashScreen.dart';

Map<String, Function> routeMap = {
  '/': (args) => MaterialPageRoute(builder: (context) => SplashScreen()),
  '/home': (args) => MaterialPageRoute(builder: (context) => PerkPage(args)),
  '/build': (args) => MaterialPageRoute(builder: (context) => BuildConfiguration(args)),
};

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {
    case ('/'):
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case ('/home'):
      return MaterialPageRoute(builder: (context) => PerkPage(settings.arguments));
    case ('/builder'):
      return MaterialPageRoute(builder: (context) => BuildConfiguration(settings.arguments));
    default:
      return MaterialPageRoute(builder: (context) {
        return Container(
          child: Text('Invalid Route "$settings.name"')
        );
      });
  }
}
