import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        title: Text('PerkLight'),
        backgroundColor: Color(0xff21213b),
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
  String selectedType = 'survivor/';
  bool isSwitched = false;
  bool perkArraySelector = true;

  void checkNumbers() {
    if(selectedType == 'survivor') {
      farLeft = Random().nextInt(65) + 1;
      left = Random().nextInt(65) + 1;
      right = Random().nextInt(65) + 1;
      farRight = Random().nextInt(65) + 1;
    }
    else {
      farLeft = Random().nextInt(60) + 1;
      left = Random().nextInt(60) + 1;
      right = Random().nextInt(60) + 1;
      farRight = Random().nextInt(60) + 1;
    }

    if (farLeft == farRight ||
        left == right ||
        farLeft == left ||
        farRight == right) {
      if(selectedType == 'survivor/') {
        print("matched Survivor");
        farLeft = Random().nextInt(65) + 1;
        left = Random().nextInt(65) + 1;
        right = Random().nextInt(65) + 1;
        farRight = Random().nextInt(65) + 1;
      }
      else {
        print("matched Killer");
        farLeft = Random().nextInt(60) + 1;
        left = Random().nextInt(60) + 1;
        right = Random().nextInt(60) + 1;
        farRight = Random().nextInt(60) + 1;
      }
    }
  }

  List<String> perkDesc = [
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

  List<String> perkDescKiller = [
    "A Nurse's Calling",
    'Agitation',
    'Bamboozle',
    'Barbecue & Chilli',
    'Beast of Prey',
    'Bitter Murmur',
    'Bloodhound',
    'Blood Warden',
    'Brutal Strength',
    'Corrupt Intervention',
    'Coulrophobia',
    'Dark Devotion',
    'Deerstalker',
    'Discordance',
    'Distressing',
    'Dying Light',
    'Enduring',
    'Fire Up',
    "Franklin's Demise",
    'Furtive Chase',
    "Hangman's Trick",
    'Hex: Devour Hope',
    'Hex: Haunted Grounds',
    'Hex: Huntress Lullaby',
    'Hex: No One Escapes Death',
    'Hex: Ruin',
    'Hex: The Third Seal',
    'Hex: Thrill of the Hunt',
    "I'm All Ears",
    'Infectious Fright',
    'Insidious',
    'Iron Grasp',
    'Iron Maiden',
    'Knock Out',
    'Lightborn',
    'Mad Grit',
    'Make Your Choice',
    'Monitor & Abuse',
    'Monstrous Shrine',
    'Overcharge',
    'Overwhelming Presence',
    'Play With Your Food',
    'Pop Goes the Weasel',
    'Predator',
    'Rancor',
    'Remember Me',
    'Save the Best for Last',
    'Shadowborn',
    'Sloppy Butcher',
    'Spies from the Shadows',
    'Spirit Fury',
    'Stridor',
    'Surveillance',
    'Territorial Imperative',
    'Tinkerer',
    'Thanataphobia',
    'Thrilling Tremors',
    'Unnerving Presence',
    'Unrelenting',
    'Whispers'
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
                      'images/$selectedType$farLeft.png',
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
                      'images/$selectedType$left.png',
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
                    'images/$selectedType$farRight.png',
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
                    'images/$selectedType$right.png',
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
                style: TextStyle(fontSize: 22.0, color: Colors.white),
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
                style: TextStyle(fontSize: 22.0, color: Colors.white),
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
                    if(!isSwitched) {
                      setState(() {
                        checkNumbers();
                        selectedType = 'survivor/';
                        perkDesc = [
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
                      });
                    }
                    else {
                      setState(() {
                        selectedType = 'killer/';
                        perkDesc = [
                          "A Nurse's Calling",
                          'Agitation',
                          'Bamboozle',
                          'Barbecue & Chilli',
                          'Beast of Prey',
                          'Bitter Murmur',
                          'Bloodhound',
                          'Blood Warden',
                          'Brutal Strength',
                          'Corrupt Intervention',
                          'Coulrophobia',
                          'Dark Devotion',
                          'Deerstalker',
                          'Discordance',
                          'Distressing',
                          'Dying Light',
                          'Enduring',
                          'Fire Up',
                          "Franklin's Demise",
                          'Furtive Chase',
                          "Hangman's Trick",
                          'Hex: Devour Hope',
                          'Hex: Haunted Grounds',
                          'Hex: Huntress Lullaby',
                          'Hex: No One Escapes Death',
                          'Hex: Ruin',
                          'Hex: The Third Seal',
                          'Hex: Thrill of the Hunt',
                          "I'm All Ears",
                          'Infectious Fright',
                          'Insidious',
                          'Iron Grasp',
                          'Iron Maiden',
                          'Knock Out',
                          'Lightborn',
                          'Mad Grit',
                          'Make Your Choice',
                          'Monitor & Abuse',
                          'Monstrous Shrine',
                          'Overcharge',
                          'Overwhelming Presence',
                          'Play With Your Food',
                          'Pop Goes the Weasel',
                          'Predator',
                          'Rancor',
                          'Remember Me',
                          'Save the Best for Last',
                          'Shadowborn',
                          'Sloppy Butcher',
                          'Spies from the Shadows',
                          'Spirit Fury',
                          'Stridor',
                          'Surveillance',
                          'Territorial Imperative',
                          'Tinkerer',
                          'Thanataphobia',
                          'Thrilling Tremors',
                          'Unnerving Presence',
                          'Unrelenting',
                          'Whispers'
                        ];
                        checkNumbers();
                      });
                    }
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
