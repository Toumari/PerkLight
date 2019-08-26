import 'dart:math' as Math;
import 'package:flutter/material.dart';

class PerkIcon extends StatelessWidget {
  PerkIcon(this.iconPath, this.iconSize) :
    boxSize = iconSize * 0.7;

  final String iconPath;
  final double iconSize;
  final double boxSize;

  final Color boxColor = Colors.white12;
  final Color boxBorderColor = Colors.black54;
  final double boxBorderWidth = 10.0;

  @override
  Widget build(BuildContext context) {
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
            iconPath,
            height: iconSize,
            width: iconSize,
            fit: BoxFit.fill
          ),
        ]
      ),
    );
  }
}
