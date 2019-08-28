import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {

  CharacterTile({@required this.name, @required this.description, @required this.characterImage});

  final String name;
  final String description;
  final String characterImage;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: Image.asset(characterImage, fit: BoxFit.fill,),
        title: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),),
        subtitle: Text(description, style: TextStyle(color: Colors.white, fontSize: 14),)
      ),
    );
  }
}
