import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:perklight/classes/perk.dart';
import 'package:perklight/widgets/perkTile.dart';


class BuildDisplay extends StatelessWidget {

  final Function rollTileCallback;
  final List<Perk> selectedPerks;

  BuildDisplay({
    this.rollTileCallback,
    this.selectedPerks,
  }) {}


  @override
  Widget build(BuildContext context) {

    Map<int, IconData> perkListDirectionIcons = {
      0: Icons.arrow_upward,
      1: Icons.arrow_downward,
      2: Icons.arrow_back,
      3: Icons.arrow_forward,
    };

    List<Map<String, double>> perkTileOffsets = [
      { 'left': null, 'top': 20.0 },
      { 'left': null, 'top': 200.0 },
      { 'left': 40.0, 'top': 110.0 },
      { 'left': 220.0, 'top': 110.0 },
    ];

    return Column(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < perkTileOffsets.length; ++i)
                Positioned(
                  top: perkTileOffsets[i]['top'],
                  left: perkTileOffsets[i]['left'],
                  child: Container(
                    child: PerkTile(
                      perk: selectedPerks[i],
                      index: i,
                      onChanged: rollTileCallback,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(Color.getAlphaFromOpacity(0.5), 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Column(
            children: [
              for (int i = 0; i < selectedPerks.length; ++i)
                ListTile(
                  leading: Icon(perkListDirectionIcons[i]),
                  title: Text(selectedPerks[i].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.list),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.lock_open),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 60.0,
        ),
      ],
    );
  }
}
