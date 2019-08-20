import 'package:flutter/material.dart';

import 'router.dart' as router;
import 'widgets/perk.dart';


void main() {
  return runApp(PerkLight());
}

class PerkLight extends StatefulWidget {
  @override
  _PerkLightState createState() => _PerkLightState();
}

class _PerkLightState extends State<PerkLight> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}
