import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('PerkLight'),
        backgroundColor: Colors.blueGrey.shade600,
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
  int farLeft = 1;
  int left = 1;
  int right = 3;
  int farRight = 4;

  var isSwitched = true;

  void checkNumbers() {
    farLeft = Random().nextInt(65) + 1;
    left = Random().nextInt(65) + 1;
    right = Random().nextInt(65) + 1;
    farRight = Random().nextInt(65) + 1;

    if (farLeft == farRight ||
        left == right ||
        farLeft == left ||
        farRight == right) {
      print("matched");
      farLeft = Random().nextInt(65) + 1;
      left = Random().nextInt(65) + 1;
      right = Random().nextInt(65) + 1;
      farRight = Random().nextInt(65) + 1;
    }
  }

  var perkDesc = [
    'Ace in the Hole',
    'Adrenaline',
    'Aftercare',
    'Alert',
    'Autodidact',
    'Balanced Landing',
    'Boil Over',
    'Bond',
    'Borrowed Time',
    'Botany Knowledge',
    'Breakdown',
    'Buckle Up',
    'Calm Spirit',
    'Dance With Me',
    'Dark Sense',
    'Dead Hard',
    'Decisive Strike',
    'Déja Vu',
    'Deliverance',
    "detective's Hunch",
    'Distortion',
    'Diversion',
    'Empathy',
    'Flip-Flop',
    'Head On',
    'Hope',
    'Iron Will',
    'Kindred',
    'Leader',
    'Left Behind',
    'Lightweight',
    'Lithe',
    'Mettle of Man',
    'No Mither',
    'No One Left Behind',
    'Object of Obsession',
    'Open-Handed',
    'Pharmacy',
    "Plunderer's Instinct",
    'Poised',
    'Premonition',
    'Prove Thyself',
    'Quick & Quiet',
    'Resilience',
    'Saboteur',
    'Self-Care',
    'Slippery Meat',
    'Small Game',
    'Sole Survivor',
    'Solidarity',
    'Spine Chill',
    'Sprint Burst',
    'Stake Out',
    'Streetwise',
    'This Is Not Happening',
    'Technician',
    'Tenacity',
    'Up the Ante',
    'Unbreakable',
    'Urban Evasion',
    'Vigil',
    'Wake Up!',
    "We'll Make It",
    "We're Gonna Live Forever",
    'Windows of Opportunity'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
          ),
          Container(
            alignment: Alignment(0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Text(
                      (perkDesc[farLeft - 1]),
                      style: TextStyle(color: Colors.white),
                    ),
                    Image.asset(
                      'images/$farLeft.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Text(
                      (perkDesc[left - 1]),
                      style: TextStyle(color: Colors.white),
                    ),
                    Image.asset(
                      'images/$left.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
              ],
            ),
          ),
          Container(
            height: 50,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                children: <Widget>[
                  Text(
                    (perkDesc[farRight - 1]),
                    style: TextStyle(color: Colors.white),
                  ),
                  Image.asset(
                    'images/$farRight.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Text(
                    (perkDesc[right - 1]),
                    style: TextStyle(color: Colors.white),
                  ),
                  Image.asset(
                    'images/$right.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Survivor',
                style: TextStyle(fontSize: 22.0),
              ),
              Transform.scale(
                scale: 1.5,
                child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;

                      print(value);
                    });
                  },
                  activeTrackColor: Colors.redAccent,
                  activeColor: Colors.black,
                ),
              ),
              Text(
                'Killer',
                style: TextStyle(fontSize: 22.0),
              )
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment(0, 1),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      checkNumbers();
                    });
                  },
                  child: Text(
                    'Press to generate a build',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
