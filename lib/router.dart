import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/buildConfigurator.dart';
import 'pages/perkPage.dart';
import 'pages/splashScreen.dart';
import 'pages/perkDetail.dart';
import 'package:perklight/pages/sharePage.dart';

Map<String, Function> routeMap = {
  '/': _genRoute((args) => SplashScreen()),
  '/home': _genRoute((args) => PerkPage(args)),
  '/builder': _genRoute((args) => BuildConfiguration(args)),
  '/details': _genRoute((args) => PerkDetail(args)),
  '/share': _genRoute((args) => SharePage(args)),
};

Function _genRoute(Function generator) {
  return (args) => MaterialPageRoute(builder: (context) => generator(args));
}

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
