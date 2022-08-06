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
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return InkResponse(
        radius: 0.65 * constraints.maxWidth,
        onTap: () {
          onChanged([index], context);
        },
        onLongPress: () {
          Navigator.pushNamed(context, '/details', arguments: perk);
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          clipBehavior: Clip.none,
          child: PerkIcon(perk.iconPath, perk.type),
        ),
      );
    });
  }
}
