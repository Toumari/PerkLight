import 'package:flutter/material.dart';


class CharacterInfo extends StatelessWidget {
  CharacterInfo(arguments) :
    characterName = arguments['name'],
    characterIcon = arguments['characterImage'],
    characterDescription = arguments['characterDescription'];

  final String characterName;
  final String characterIcon;
  final String characterDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$characterName'),
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
                      characterIcon,
                      height: 150,
                    ),
                  ),
                  Text(
                    characterName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    characterDescription,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                    ),
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
