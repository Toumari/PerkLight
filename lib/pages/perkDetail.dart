import 'package:flutter/material.dart';

import '../widgets/perk.dart';
import '../widgets/perkIcon.dart';

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
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        backgroundColor: Color(0xff21213b),
        title: Text("Perk - ${widget.perk.name}", style: TextStyle(color: Colors.white)),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(margin: EdgeInsets.only(bottom: 15.0), child: PerkIcon(widget.perk.iconPath, 200.0)),
              Text(widget.perk.name, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SizedBox(height: 15),
              Text(widget.perk.description, overflow: TextOverflow.visible, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.left)
            ],
          ),
        ),
      ),
    );
  }
}
