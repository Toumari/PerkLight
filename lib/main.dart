import 'package:flutter/material.dart';

import 'package:perklight/router.dart' as router;
import 'package:perklight/themes/dark.dart';


void main() {
  PerkLight app = PerkLight();
  runApp(app);
}

class PerkLight extends StatefulWidget {
  @override
  _PerkLightState createState() => _PerkLightState();
}

class _PerkLightState extends State<PerkLight> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PerkLight',
      theme: darkTheme,
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}
