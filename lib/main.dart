import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red.shade900,
      appBar: AppBar(
        title: Text('PerkLight'),
        backgroundColor: Colors.red.shade900,
      ),
      body: PerkPage(),
    ),
  ));
}

class PerkPage extends StatefulWidget {
  @override
  _PerkPageState createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  int topLeft = 1;
  int topRight = 1;
  int bottomLeft = 3;
  int bottomRight = 4;

  var list = new List<int>.generate(7, (int index) => index);

  void checkNumbers() {
    list.remove(0);
    list.shuffle();
    topLeft = list[0];
    topRight = list[1];
    bottomLeft = list[2];
    bottomRight = list[3];
    print(list);
  }

  var perkDesc = [
    'Adrenaline',
    'Hope',
    'Decisive Strike',
    'Adrenaline',
    'Hope',
    'Decisive Strike',
    'Adrenaline',
    'Hope',
    'Decisive Strike'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  "Adrenaline",
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset('images/$topLeft.png'),
              ],
            )),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  "Adrenaline",
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset('images/$topRight.png'),
              ],
            )),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  perkDesc[bottomLeft],
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset('images/$bottomLeft.png'),
              ],
            )),
            Expanded(
                child: Column(
              children: <Widget>[
                Text(
                  "Adrenaline",
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset('images/$bottomRight.png'),
              ],
            )),
          ],
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              checkNumbers();
            });
          },
          child: Text('Press to randomize'),
          color: Colors.white,
        ),
        FlatButton(
          onPressed: () {},
          child: Text('Switch to Killer'),
          color: Colors.white,
        )
      ],
    );
  }
}
