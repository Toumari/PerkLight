import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {

  CharacterTile({@required this.name, @required this.description, @required this.characterImage});

  final String name;
  final String description;
  final String characterImage;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            color: Colors.white24,
              child: Image.asset(characterImage, height: 100,)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              Text(description, textAlign: TextAlign.left, overflow: TextOverflow.clip, style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w400),)
            ],
          ),
        ),
      ],
    );
  }
}
