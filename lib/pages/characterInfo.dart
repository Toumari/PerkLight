import 'package:flutter/material.dart';

class CharacterInfo extends StatefulWidget {
  CharacterInfo(arguments):
        characterName = arguments['name'],
        characterIcon = arguments['characterImage'],
        characterDescription = arguments['characterDescription'];

  final String characterName;
  final String characterIcon;
  final String characterDescription;

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      widget.characterIcon,
                      height: 150,
                    ),
                  ),
                  Text(
                    widget.characterName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    widget.characterDescription,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      wordSpacing: 1.2,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
