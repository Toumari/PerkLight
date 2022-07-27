import 'package:flutter/material.dart';

import 'package:perklight/classes/perk.dart';
import 'package:perklight/widgets/perkIcon.dart';

class PerkTile extends StatelessWidget {
  PerkTile({@required this.perk, @required this.index, @required this.onChanged});

  final Perk perk;
  final int index;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Text(
          perk.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
      InkResponse(
          radius: 105.0,
          onTap: () {
            onChanged([index], context);
          },
          onLongPress: () {
            Navigator.pushNamed(context, '/details', arguments: perk);
          },
          child: PerkIcon(perk.iconPath, 150.0)),
    ]);
  }
}
