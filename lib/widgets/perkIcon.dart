import 'dart:math' as Math;
import 'package:flutter/material.dart';

class PerkIcon extends StatelessWidget {
  PerkIcon(this.iconPath, this.iconSize) :
    boxSize = iconSize * 0.7;

  final String iconPath;
  final double iconSize;
  final double boxSize;

  @override
  Widget build(BuildContext context) {
    final Color boxColor1 = Theme.of(context).accentColor;
    final Color boxColor2 = HSVColor.fromColor(boxColor1).withValue(0.3).toColor();
    final Color boxBorderColor = Color.fromARGB(Color.getAlphaFromOpacity(1), 0, 0, 0);
    final double boxBorderWidth = 0.9 / 15 * iconSize;

    return Center(
      child: Stack(
        children: <Widget> [
          Transform.translate(
            offset: Offset(
              (iconSize - boxSize) / 2.0,
              (iconSize - boxSize) / 2.0
            ),
            child:Transform.rotate(
              angle: 45.0 * Math.pi / 180.0,
              child: Container(
                padding: EdgeInsets.all(iconSize - boxSize),
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [ boxColor1, boxColor2 ]),
                  border: Border.all(
                    color: boxBorderColor,
                    width: boxBorderWidth,
                  ),
                  color: boxColor1
                ),
              ),
            ),
          ),
          Image.asset(
            iconPath,
            height: iconSize,
            width: iconSize,
            fit: BoxFit.fill,
          ),
        ]
      ),
    );
  }
}
