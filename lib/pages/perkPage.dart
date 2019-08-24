// Third-party
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// First-party
import '../utilities.dart' as Utils;
import '../widgets/perk.dart';
import '../widgets/perkTile.dart';


class PerkPage extends StatefulWidget {
  PerkPage(arguments) :
    killerPerks = arguments['killerPerks'],
    survivorPerks = arguments['survivorPerks'];

  final List<Perk> killerPerks;
  final List<Perk> survivorPerks;

  @override
  _PerkPageState createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  List<int> randomlySelectedPerks;
  int numPerksToSelect = 4;
  bool killerMode = false;

  void generateRandomlySelectedPerks() {
    randomlySelectedPerks = Utils.generateSetOfRandomNumbers(numPerksToSelect, max: perkList.length);
  }

  List<Perk> perkList;

  @override
  void initState() {
    super.initState();
    setPerkListAndRandomise();
  }

  void setPerkListAndRandomise() {
    List<Perk> listToFilter = killerMode ? widget.killerPerks : widget.survivorPerks;
    perkList = listToFilter.where((perk) {
      return perk.preference.enabled;
    }).toList();
    generateRandomlySelectedPerks();
  }

  void _rollTileCallback(int index, BuildContext context) {
    // Check if randomlySelectedPerks is less than or equal to perkList
    if (perkList.length <= randomlySelectedPerks.length) {
      String perkType = killerMode ? 'killer' : 'survivor';
      String message = 'You cannot reroll with only 4 $perkType perks selected';

      ScaffoldState scaffold = Scaffold.of(context);
      scaffold.removeCurrentSnackBar();
      scaffold.showSnackBar(SnackBar(content: Text(message)));

      return;
    }

    setState(() {
      randomlySelectedPerks = Utils.replaceIndexValue(randomlySelectedPerks, [index], max: perkList.length);
    });
  }

  @override
  Widget build(BuildContext context) {

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
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.white))
                ),
                child: DrawerHeader(
                  child: Center(
                    child: Text(
                      'PerkLight',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xff21213b)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                color: Color(0xff21213b),
                child: ListTile(
                  title: Text(
                    'Perk Configuration',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      '/builder',
                      arguments: {
                        'killerPerks': widget.killerPerks,
                        'survivorPerks': widget.survivorPerks
                      }
                    );
                    setState(() {
                      setPerkListAndRandomise();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        title: Text('PerkLight'),
        backgroundColor: Color(0xff21213b),
      ),
      body: SafeArea(
        bottom: false,
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(height: 24.0),
                GridView.count(
                  mainAxisSpacing: 20.0,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: <Widget>[
                    for (int i = 0; i < randomlySelectedPerks.length; ++i)
                      PerkTile(
                        perk: perkList[randomlySelectedPerks[i]],
                        index: i,
                        onChanged: _rollTileCallback
                      )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Survivor',
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Switch(
                          value: killerMode,
                          onChanged: (value) async {
                            setState(() {
                              killerMode = value;
                              setPerkListAndRandomise();
                            });
                          },
                          activeTrackColor: Colors.redAccent,
                          activeColor: Colors.black,
                        ),
                      ),
                      Text(
                        'Killer',
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 1),
                    child: SizedBox(
                      width: double.infinity,
                      height: 75,
                      child: FlatButton(
                        onPressed: () async {
                          setState(() {
                            generateRandomlySelectedPerks();
                          });
                        },
                        child: Text(
                          'Randomise',
                          style: TextStyle(fontSize: 22.0),
                        ),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]
            );
          }
        )
      ),
    );
  }
}
