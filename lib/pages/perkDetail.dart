import 'dart:math' as Math;

import 'package:flutter/material.dart';

import 'package:perklight/classes/perk.dart';
import 'package:perklight/widgets/perkIcon.dart';

class PerkDetail extends StatefulWidget {
  PerkDetail(this.perk);

  final Perk perk;

  @override
  _PerkDetailState createState() => _PerkDetailState();
}

class _PerkDetailState extends State<PerkDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perk - ${widget.perk.name}"),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    final double innerSquareWidth = Math.sqrt2 * constraints.maxWidth / 2.0;
                    return Container(
                      width: innerSquareWidth,
                      height: innerSquareWidth,
                      padding: EdgeInsets.all(innerSquareWidth * 0.25),
                      transformAlignment: Alignment.center,
                      transform: Matrix4.rotationZ(Math.pi / 4.0),
                      child: PerkIcon(widget.perk.iconPath, widget.perk.type),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  widget.perk.name,
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  widget.perk.description,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
