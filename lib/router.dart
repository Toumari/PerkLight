import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/buildConfigurator.dart';
import 'pages/perkPage.dart';
import 'pages/splashScreen.dart';

final Map<String, MaterialPageRoute<dynamic>> routeMap = {
  '/': MaterialPageRoute(builder: (context) => SplashScreen()),
  '/home': MaterialPageRoute(builder: (context) => PerkPage()),
  '/builder': MaterialPageRoute(builder: (context) => BuildConfiguration())
};

Route<dynamic> generateRoute(RouteSettings settings) {
  return routeMap[settings.name] ??
    MaterialPageRoute(builder: (context) {
      return Container(
        child: Text('Invalid Route "$settings.name"')
      );
    });
}
