import 'package:flutter/material.dart';
import './perk.dart';


class PerkTile extends StatelessWidget {
  PerkTile({@required this.perk, @required this.index, @required this.onChanged, @required this.context});

  final Perk perk;
  final int index;
  final Function onChanged;
  final BuildContext context;

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
            onChanged(index, this.context);
          },
          onLongPress: () {
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
