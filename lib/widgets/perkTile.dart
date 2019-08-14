import 'package:flutter/material.dart';


class PerkTile extends StatelessWidget {
  PerkTile ({Key key, this.name, this.iconPath});

  final String name;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        Image.asset(
          iconPath,
          height: 150,
          width: 150,
          fit: BoxFit.fill,
        ),
      ]
    );
  }
}
