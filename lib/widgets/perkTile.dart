import 'package:flutter/material.dart';
import './perk.dart';


class PerkTile extends StatelessWidget {
  PerkTile(this.perk);

  final Perk perk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          perk.name,
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: perk
            );
          },
          child: Image.asset(
            perk.iconPath,
            height: 150,
            width: 150,
            fit: BoxFit.fill,
          ),
        ),
      ]
    );
  }
}
