import 'package:flutter/material.dart';


class PerkTile extends StatelessWidget {
  PerkTile ({Key key, this.name, this.iconPath, this.textColor});

  final String name;
  final String iconPath;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(color: textColor),
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
