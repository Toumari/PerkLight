import 'dart:math' as Math;
import 'package:flutter/material.dart';
import './perk.dart';


class PerkTile extends StatelessWidget {
  PerkTile(this.perk);

  final Perk perk;

  final double imageSize = 150.0;
  final double boxSize = 100.0;
  final Color boxColor = Colors.white12;
  final Color boxBorderColor = Colors.black54;
  final double boxBorderWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5.0),
          child: Text(
            perk.name,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: perk
            );
          },
          child: Stack(
            children: <Widget> [
              Transform.translate(
                offset: Offset(
                  (imageSize - boxSize) / 2.0,
                  (imageSize - boxSize) / 2.0
                ),
                child:Transform.rotate(
                  angle: 45.0 * Math.pi / 180.0,
                  child: Container(
                    padding: EdgeInsets.all(imageSize - boxSize),
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: boxBorderColor,
                        width: boxBorderWidth
                      ),
                      color: boxColor
                    ),
                  ),
                ),
              ),
              Image.asset(
                perk.iconPath,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.fill
              ),
            ]
          ),
        ),
      ]
    );
  }
}
