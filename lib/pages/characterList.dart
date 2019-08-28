import 'package:flutter/material.dart';
import '../widgets/characterTile.dart';


class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        title: Text('PerkLight'),
        backgroundColor: Color(0xff21213b),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CharacterTile(name: 'Dwight FairField', description: "Dwight was geeky and scrawny through high school. He always wanted to be one of the cool kids, but somehow never had the charisma. he tried out for the football team but was cut, the basketball team didn't even take a look ", characterImage: 'assets/images/characters/Dwight.png'),
            CharacterTile(name: 'Meg Thomas', description: "Dwight was geeky and scrawny through high school. He always wanted to be one of the cool kids, but somehow never had the charisma. he tried out for the football team but was cut, the basketball team didn't even take a look ", characterImage: 'assets/images/characters/Meg.png' ),
          ],
        ),
      ),
    );
  }
}
