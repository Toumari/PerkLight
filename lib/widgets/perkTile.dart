import 'package:flutter/material.dart';
import './perk.dart';


class PerkTile extends StatelessWidget {
  PerkTile({Key key, @required this.perk, @required this.index, this.onChanged}) : super(key: key);

  final Perk perk;
  final int index;
  final ValueChanged<int> onChanged;

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
            onChanged(index);
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
