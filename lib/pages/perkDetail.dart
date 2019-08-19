import 'package:flutter/material.dart';


class PerkDetail extends StatefulWidget {

  final String perkName;
  final String perkDescription;
  final String perkIconPath;

  PerkDetail({Key key, @required this.perkName, @required this.perkDescription, @required this.perkIconPath});

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
    title: Text('Perk Configuration', style: TextStyle(color: Colors.white)),
    ),
      body: Column(
        children: <Widget>[
          Image.asset(widget.perkIconPath),
          Text(widget.perkName, style: TextStyle(color: Colors.white, fontSize: 32),)
        ],
      ),
    );
  }
}
