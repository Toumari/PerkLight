import 'package:flutter/material.dart';


class PerkDetail extends StatefulWidget {
  @override
  _PerkDetailState createState() => _PerkDetailState();
}

class _PerkDetailState extends State<PerkDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff21213b),
    appBar: AppBar(
    bottom: TabBar(tabs: [
    Tab(text: 'Survivor'),
    Tab(text: 'Killer'),
    ]),
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xff21213b),
    title: Text('Perk Configuration', style: TextStyle(color: Colors.white)),
    ),
      body: Column(
        children: <Widget>[
          Image.asset('killer/0.png'),
          Text('Hello')
        ],
      ),
    );
  }
}
