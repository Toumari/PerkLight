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
  String selectedType = 'survivor/';
  bool isSwitched = false;

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
    List<Perk> listToFilter = selectedType == 'killer/' ? widget.killerPerks : widget.survivorPerks;
    perkList = listToFilter.where((perk) {
      return perk.preference.enabled;
    }).toList();
    generateRandomlySelectedPerks();
  }

  void loadPerksFromPreferencesOrDefaults(bool value) {
    selectedType = value ? 'killer/' : 'survivor/';
    setState(() {
      setPerkListAndRandomise();
    });
  }

  void _rollTileCallback(int index, BuildContext context) {
    // Check if randomlySelectedPerks is less than or equal to perkList
    if (randomlySelectedPerks.length <= perkList.length) {
      String perkType = isSwitched ? 'killer' : 'survivor';
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

                    loadPerksFromPreferencesOrDefaults(isSwitched);
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
                Container(
                  height: 50,
                ),
                Container(
                  alignment: Alignment(0, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: PerkTile(
                          perk: perkList[randomlySelectedPerks.elementAt(0)],
                          index: 0,
                          onChanged: _rollTileCallback,
                          context: context
                        )
                      ),
                      Expanded(
                        child: PerkTile(
                          perk: perkList[randomlySelectedPerks.elementAt(1)],
                          index: 1,
                          onChanged: _rollTileCallback,
                          context: context
                        )
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: PerkTile(
                          perk: perkList[randomlySelectedPerks.elementAt(2)],
                          index: 2,
                          onChanged: _rollTileCallback,
                          context: context
                        )
                    ),
                    Expanded(
                        child: PerkTile(
                          perk: perkList[randomlySelectedPerks.elementAt(3)],
                          index: 3,
                          onChanged: _rollTileCallback,
                          context: context
                        )
                    ),
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
                        onChanged: (value) async {
                          setState(() {
                            isSwitched = value;
                          });
                          loadPerksFromPreferencesOrDefaults(value);
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
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 1),
                    child: SizedBox(
                      width: double.infinity,
                      height: 75,
                      child: FlatButton(
                        onPressed: () async {
                          loadPerksFromPreferencesOrDefaults(isSwitched);
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
              ],
            );
          }
        )
      ),
    );
  }
}