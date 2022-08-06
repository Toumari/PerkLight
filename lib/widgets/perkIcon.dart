import 'dart:math' as Math;
import 'package:flutter/material.dart';

import 'package:perklight/utilities.dart';
import 'package:perklight/classes/perk.dart';

class PerkIcon extends StatelessWidget {
  PerkIcon(this.iconPath, this.perkType)
      : boxBackgroundColorBase = perkType == PerkType.survivor ? Colors.amberAccent : Colors.red;

  final String iconPath;
  final PerkType perkType;
  final Color boxBackgroundColorBase;

  @override
  Widget build(BuildContext context) {
    final Color boxBackgroundColorDark = darkenColor(boxBackgroundColorBase, 0.4);
    final LinearGradient boxGradient = LinearGradient(
      colors: [boxBackgroundColorBase, boxBackgroundColorDark],
      transform: GradientRotation(45.0 * Math.pi / 180.0),
    );

    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final double imageWidth = 1.04 * Math.sqrt2 * constraints.maxWidth;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Perk Background - Black Outline + Gradient Fill
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.07 * constraints.maxWidth),
                gradient: boxGradient,
              ),
            ),
            // Perk Foreground - Icon
            Container(
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              transform: Matrix4.rotationZ(-Math.pi / 4.0),
              child: OverflowBox(
                alignment: Alignment.center,
                maxWidth: imageWidth,
                maxHeight: imageWidth,
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  width: imageWidth,
                  height: imageWidth,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
