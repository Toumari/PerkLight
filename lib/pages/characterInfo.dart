import 'package:flutter/material.dart';

class CharacterInfo extends StatefulWidget {
  CharacterInfo(arguments) :
    characterName = arguments['name'],
    characterDescription = arguments['description'],
    characterIcon = arguments['characterImage'];
  
  final String characterName;
  final String characterDescription;
  final String characterIcon;


  @override
  _CharacterInfoState createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        title: Text('Character Profiles'),
        backgroundColor: Color(0xff21213b),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(widget.characterIcon, height: 150,),
              ),
              Text(widget.characterName, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
              Text(widget.characterDescription, style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
