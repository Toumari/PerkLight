import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:perklight/classes/perk.dart';
import 'package:perklight/classes/character.dart';
import 'package:perklight/classes/item.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  List<Future> _initSteps = List<Future>();

  List<KillerPerk> _killerPerks = List<KillerPerk>();
  List<SurvivorPerk> _survivorPerks = List<SurvivorPerk>();
  List<Character> _survivorCharacterDetails = List<Character>();
  List<Character> _killerCharacterDetails = List<Character>();
  List<Item> _firecrackerItemDetails = List<Item>();
  List<Item> _flashlightItemDetails = List<Item>();
  List<Item> _keyItemDetails = List<Item>();
  List<Item> _mapItemDetails = List<Item>();
  List<Item> _medkitItemDetails = List<Item>();
  List<Item> _toolboxItemDetails = List<Item>();

  _navigateToHomePage(List<dynamic> values) {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'killerPerks': _killerPerks,
        'survivorPerks': _survivorPerks,
        'survivorCharacterDetails': _survivorCharacterDetails,
        'killerCharacterDetails' : _killerCharacterDetails,
        'firecrackerItemDetails' : _firecrackerItemDetails,
        'flashlightItemDetails' : _flashlightItemDetails,
        'keyItemDetails' : _keyItemDetails,
        'mapItemDetails' : _mapItemDetails,
        'medkitItemDetails' : _medkitItemDetails,
        'toolboxItemDetails' : _toolboxItemDetails
      }
    );
  }

  Future _loadCharactersFromFile() async {
    String characterJson = await DefaultAssetBundle.of(context).loadString('assets/data/characters.json');
    Map<String, dynamic> characters = json.decode(characterJson);
    for(Map<String, dynamic> character in characters['survivors']){
      Character newCharacter = Character.fromJson(character);
      _survivorCharacterDetails.add(newCharacter);
    }
    for(Map<String, dynamic> character in characters['killers']){
      Character newCharacter = Character.fromJson(character);
      _killerCharacterDetails.add(newCharacter);
    }
  }

  Future _loadItemsFromFile() async {
    String itemJson = await DefaultAssetBundle.of(context).loadString('assets/data/items.json');
    Map<String, dynamic> items = json.decode(itemJson);
    for(Map<String, dynamic> item in items['firecracker']) {
      Item newItem = Item.fromJson(item);
      _firecrackerItemDetails.add(newItem);
    }
    for(Map<String, dynamic> item in items['flashlight']) {
      Item newItem = Item.fromJson(item);
      _flashlightItemDetails.add(newItem);
    }
    for(Map<String, dynamic> item in items['key']) {
      Item newItem = Item.fromJson(item);
      _keyItemDetails.add(newItem);
    }
    for(Map<String, dynamic> item in items['map']) {
      Item newItem = Item.fromJson(item);
      _mapItemDetails.add(newItem);
    }
    for(Map<String, dynamic> item in items['medkit']) {
      Item newItem = Item.fromJson(item);
      _medkitItemDetails.add(newItem);
    }
    for(Map<String, dynamic> item in items['toolbox']) {
      Item newItem = Item.fromJson(item);
      _toolboxItemDetails.add(newItem);
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
  }

  @override
  void initState() {
    super.initState();
    _initSteps.add(_loadPerksFromFile());
    _initSteps.add(_loadCharactersFromFile());
    _initSteps.add(_loadItemsFromFile());
    Future.wait(_initSteps).then(_navigateToHomePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/icon/icon.png',
              fit: BoxFit.fitWidth
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.shortestSide * 0.2,
                height: MediaQuery.of(context).size.shortestSide * 0.2,
                child: CircularProgressIndicator()
              )
            ),
          ]
        )
      )
    );
  }
}
