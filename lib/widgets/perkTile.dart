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
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: {
                'perkName': name,
                'perkIconPath': iconPath,
                'perkDescription': 'Test Desription for the Perk. This will eventually be replaced by the actual description for the Perk.'
              }
            );
          },
          child: Image.asset(
            iconPath,
            height: 150,
            width: 150,
            fit: BoxFit.fill,
          ),
        ),
      ]
    );
  }
}
