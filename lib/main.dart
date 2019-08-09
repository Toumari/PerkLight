import 'package:flutter/material.dart';
import 'dart:math';
import 'buildConfigurator.dart';
import 'package:flutter/services.dart';
import 'widgets/perk.dart';



class PerkPage extends StatefulWidget {


  @override
  _PerkPageState createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  int farLeft = 1;
  int left = 2;
  int right = 3;
  int farRight = 4;
  int filterAmount=65;
  String selectedType = 'survivor/';
  bool isSwitched = false;
  bool perkArraySelector = true;
  List fullList = ['Ace in the Hole', 'Adrenaline', 'Aftercare', 'Alert', 'Autodidact', 'Balanced Landing', 'Boil Over', 'Bond', 'Borrowed Time', 'Botany Knowledge', 'Breakdown', 'Buckle Up', 'Calm Spirit', 'Dance With Me', 'Dark Sense', 'Dead Hard', 'Decisive Strike', 'Déja Vu', 'Deliverance', "Detective's Hunch", 'Distortion', 'Diversion', 'Empathy', 'Flip-Flop', 'Head On', 'Hope', 'Iron Will', 'Kindred', 'Leader', 'Left Behind', 'Lightweight', 'Lithe', 'Mettle of Man', 'No Mither', 'No One Left Behind', 'Object of Obsession', 'Open-Handed', 'Pharmacy', "Plunderer's Instinct", 'Poised', 'Premonition', 'Prove Thyself', 'Quick & Quiet', 'Resilience', 'Saboteur', 'Self-Care', 'Slippery Meat', 'Small Game', 'Sole Survivor', 'Solidarity', 'Spine Chill', 'Sprint Burst', 'Stake Out', 'Streetwise', 'This Is Not Happening', 'Technician', 'Tenacity', 'Up the Ante', 'Unbreakable', 'Urban Evasion', 'Vigil', 'Wake Up!', "We'll Make It", "We're Gonna Live Forever", 'Windows of Opportunity',
    "A Nurse's Calling", 'Agitation', 'Bamboozle', 'Barbecue & Chilli', 'Beast of Prey', 'Bitter Murmur', 'Bloodhound', 'Blood Warden', 'Brutal Strength', 'Corrupt Intervention', 'Coulrophobia', 'Dark Devotion', 'Deerstalker', 'Discordance', 'Distressing', 'Dying Light', 'Enduring', 'Fire Up', "Franklin's Demise", 'Furtive Chase', "Hangman's Trick", 'Hex: Devour Hope', 'Hex: Haunted Grounds', 'Hex: Huntress Lullaby', 'Hex: No One Escapes Death', 'Hex: Ruin', 'Hex: The Third Seal', 'Hex: Thrill of the Hunt', "I'm All Ears", 'Infectious Fright', 'Insidious', 'Iron Grasp', 'Iron Maiden', 'Knock Out', 'Lightborn', 'Mad Grit', 'Make Your Choice', 'Monitor & Abuse', 'Monstrous Shrine', 'Overcharge', 'Overwhelming Presence', 'Play With Your Food', 'Pop Goes the Weasel', 'Predator', 'Rancor', 'Remember Me', 'Save the Best for Last', 'Shadowborn', 'Sloppy Butcher', 'Spies from the Shadows', 'Spirit Fury', 'Stridor', 'Surveillance', 'Territorial Imperative', 'Tinkerer', 'Thanataphobia', 'Thrilling Tremors', 'Unnerving Presence', 'Unrelenting', 'Whispers'
  ];


  void checkNumbers() {
      farLeft = Random().nextInt(filterAmount) + 1;
      left = Random().nextInt(filterAmount) + 1;
      right = Random().nextInt(filterAmount) + 1;
      farRight = Random().nextInt(filterAmount) + 1;
    if (farLeft == farRight ||
        left == right ||
        farLeft == left ||
        farRight == right) {
          print("matched Survivor");
          farLeft = Random().nextInt(filterAmount) + 1;
          left = Random().nextInt(filterAmount) + 1;
          right = Random().nextInt(filterAmount) + 1;
          farRight = Random().nextInt(filterAmount) + 1;
        }
  }

  List<Perk> perkDesc = returnSurvivor();


  @override
  Widget build(BuildContext context) {


    for(var i=0;i<perkDesc.length;i++){
      print(perkDesc[i].perkName);
    }


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff21213b),
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0,color: Colors.white)
                  )
                ),
                child: DrawerHeader(
                  child: Center(child: Text('PerkLight',style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.white),)),
                  decoration: BoxDecoration(
                    color: Color(0xff21213b)
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                color: Color(0xff21213b),
                child: ListTile(
                  title: Center(child: Text('Perk List',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0,color: Colors.white, decoration: TextDecoration.underline),)),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => BuildConfiguration(perks: fullList,)));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    backgroundColor: Color(0xff21213b),
    appBar: AppBar(
    title: Text('PerkLight'),
    backgroundColor: Color(0xff21213b),
    ),
    body:
      SafeArea(
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
                      (perkDesc[farLeft - 1].perkName),
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
                      (perkDesc[left - 1].perkName),
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
                    (perkDesc[farRight - 1].perkName),
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
                    (perkDesc[right - 1].perkName),
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
                      if(value == true) {
                        setState(() {
                          selectedType = 'killer/';
                          filterAmount = 60;
                          perkDesc = returnKiller();
                          checkNumbers();
                        });
                      }
                      else {
                        setState(() {
                          checkNumbers();
                          selectedType = 'survivor/';
                          perkDesc = returnSurvivor();
                        });
                      }
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
                        selectedType = 'survivor/';
                        perkDesc = returnSurvivor();
                        checkNumbers();
                      });
                    }
                    else {
                      setState(() {
                        selectedType = 'killer/';
                        filterAmount = 60;
                        perkDesc = returnKiller();
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
    )
    );
  }
}

void main() {
  return runApp(MaterialApp(
    home: PerkPage()
  ));
}
