import 'package:flutter/material.dart';


class PerkDetail extends StatefulWidget {

  final String perkName;
  final String perkDescription;
  final String perkIconPath;

  PerkDetail(Map<String, dynamic> arguments) :
    perkName = arguments['perkName'],
    perkDescription = arguments['perkDescription'],
    perkIconPath = arguments['perkIconPath'];

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
    title: Text("Perk - ${widget.perkName}", style: TextStyle(color: Colors.white)),
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(widget.perkIconPath, height: 200, scale: 0.8,),
          Text(widget.perkName, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          SizedBox(
            height: 15,
          ),
          Text(widget.perkDescription, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
