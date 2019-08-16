import 'package:flutter/material.dart';
import 'pages/perkPage.dart';

void main() {
  return runApp(MaterialApp(home: PerkPage()));
}


class PerkLight extends StatefulWidget {
  @override
  _PerkLightState createState() => _PerkLightState();
}

class _PerkLightState extends State<PerkLight> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PerkPage(),
    );
  }
}




