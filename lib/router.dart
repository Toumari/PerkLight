import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:perklight/pages/buildConfigurator.dart';
import 'package:perklight/pages/perkPage.dart';
import 'package:perklight/pages/splashScreen.dart';
import 'package:perklight/pages/perkDetail.dart';
import 'package:perklight/pages/characterList.dart';
import 'package:perklight/pages/characterInfo.dart';

Map<String, Function> routeMap = {
  '/': (args) => MaterialPageRoute(builder: (context) => SplashScreen()),
  '/home': (args) => MaterialPageRoute(builder: (context) => PerkPage(args)),
  '/builder': (args) => MaterialPageRoute(builder: (context) => BuildConfiguration(args)),
  '/details': (args) => MaterialPageRoute(builder: (context) => PerkDetail(args)),
  '/characters': (args) => MaterialPageRoute(builder: (context) => CharacterList(args) ),
  '/characterInfo': (args) => MaterialPageRoute(builder: (context) => CharacterInfo(args) )
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
