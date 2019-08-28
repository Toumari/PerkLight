import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/buildConfigurator.dart';
import 'pages/perkPage.dart';
import 'pages/splashScreen.dart';
import 'pages/perkDetail.dart';
import 'pages/characterList.dart';

Map<String, Function> routeMap = {
  '/': (args) => MaterialPageRoute(builder: (context) => SplashScreen()),
  '/home': (args) => MaterialPageRoute(builder: (context) => PerkPage(args)),
  '/builder': (args) => MaterialPageRoute(builder: (context) => BuildConfiguration(args)),
  '/details': (args) => MaterialPageRoute(builder: (context) => PerkDetail(args)),
  '/characters': (args) => MaterialPageRoute(builder: (context) => CharacterList() )
};

Route<dynamic> generateRoute(RouteSettings settings) {

  Function routeFunc = routeMap[settings.name] ?? (args) {
    return MaterialPageRoute(builder: (context) {
      return Container(
        child: Text('Invalid Route "${settings.name}"')
      );
    });
  };

  return routeFunc(settings.arguments);
}
