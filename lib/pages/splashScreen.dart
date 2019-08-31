import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:perklight/classes/perk.dart';
import 'package:perklight/classes/character.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  List<Future> _initSteps = List<Future>();

  List<KillerPerk> _killerPerks = List<KillerPerk>();
  List<SurvivorPerk> _survivorPerks = List<SurvivorPerk>();
  List<Character> _survivorCharacterPerks = List<Character>();
  List<Character> _killerCharacterPerks = List<Character>();

  _navigateToHomePage(List<dynamic> values) {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'killerPerks': _killerPerks,
        'survivorPerks': _survivorPerks,
        'survivorCharacterDetails': _survivorCharacterPerks,
        'killerCharacterDetails' : _killerCharacterPerks
      }
    );
  }


  Future _loadCharactersFromFile() async {
    String characterJson = await DefaultAssetBundle.of(context).loadString('assets/data/characters.json');
    Map<String, dynamic> characters = json.decode(characterJson);
    for(Map<String, dynamic> character in characters['survivors']){
      Character newCharacter = Character.fromJson(character);
      _survivorCharacterPerks.add(newCharacter);
    }
    for(Map<String, dynamic> character in characters['killers']){
      Character newCharacter = Character.fromJson(character);
      _killerCharacterPerks.add(newCharacter);
    }
  }

  Future _loadPerksFromFile() async {
    String perkJson = await DefaultAssetBundle.of(context).loadString('assets/data/perks.json');
    Map<String, dynamic> perks = json.decode(perkJson);
    for (Map<String, dynamic> perk in perks['killer']) {
      Perk newPerk = KillerPerk.fromJson(perk);
      _killerPerks.add(newPerk);
      await newPerk.loadPreference();
    }
    for (Map<String, dynamic> perk in perks['survivor']) {
      Perk newPerk = SurvivorPerk.fromJson(perk);
      _survivorPerks.add(newPerk);
      await newPerk.loadPreference();
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _initSteps.add(_loadPerksFromFile());
    _initSteps.add(_loadCharactersFromFile());
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
