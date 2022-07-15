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
        title: Text('${widget.perk.name}'.toUpperCase()),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: PerkIcon(widget.perk.iconPath, 200.0)
              ),
              Text(
                widget.perk.name,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
              ),
              SizedBox(height: 15),
              Text(
                widget.perk.description,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left
              ),
            ],
          ),
        ),
      ),
    );
  }
}
