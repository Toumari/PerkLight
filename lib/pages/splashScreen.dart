import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/perk.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  List<Future> _initSteps = List<Future>();

  List<Perk> _killerPerks = List<Perk>();
  List<Perk> _survivorPerks = List<Perk>();

  _navigateToHomePage(List<dynamic> values) {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'killerPerks': _killerPerks,
        'survivorPerks': _survivorPerks,
      }
    );
  }

  Future _loadPerksFromFile() async {
    String perkJson = await DefaultAssetBundle.of(context).loadString('assets/data/perks.json');
    Map<String, dynamic> perks = json.decode(perkJson);
    for (Map<String, dynamic> perk in perks['killer']) {
      Perk newPerk = Perk.fromJson(perk, 'killer');
      _killerPerks.add(newPerk);
      await newPerk.loadPreference();
    }
    for (Map<String, dynamic> perk in perks['survivor']) {
      Perk newPerk = Perk.fromJson(perk, 'survivor');
      _survivorPerks.add(newPerk);
      await newPerk.loadPreference();
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _initSteps.add(_loadPerksFromFile());
    Future.wait(_initSteps).then(_navigateToHomePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/icon/icon.png', fit: BoxFit.fitWidth),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: CircularProgressIndicator()
          ),
        ]
      )
    );
  }
}