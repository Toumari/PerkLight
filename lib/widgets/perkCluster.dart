import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:perklight/widgets/perkTile.dart';
import 'package:perklight/classes/perk.dart';

class PerkCluster extends StatelessWidget {
  PerkCluster(List<Perk> availablePerks, Function onChanged)
      : availablePerks = availablePerks,
        onChanged = onChanged;

  final List<Perk> availablePerks;

  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // final double innerSquareWidth = Math.sqrt2 * constraints.maxWidth / 2.0;
            final double innerSquareWidth = constraints.maxWidth / Math.sqrt2;

            return Container(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                transform: Matrix4.rotationZ(Math.pi / 4.0),
                padding: EdgeInsets.all(42.0),
                width: innerSquareWidth,
                height: innerSquareWidth,
                child: Column(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(child: PerkTile(index: 0, perk: availablePerks[0], onChanged: onChanged)),
                        Expanded(child: PerkTile(index: 1, perk: availablePerks[1], onChanged: onChanged)),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(child: PerkTile(index: 2, perk: availablePerks[2], onChanged: onChanged)),
                        Expanded(child: PerkTile(index: 3, perk: availablePerks[3], onChanged: onChanged)),
                      ],
                    )),
                  ],
                ));
          },
        ));
  }
}
