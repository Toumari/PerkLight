// Third-party
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// First-party
import '../buildConfigurator.dart';
import '../utilities.dart' as Utils;
import '../widgets/perk.dart';
import '../widgets/perkTile.dart';


class PerkPage extends StatefulWidget {
  @override
  _PerkPageState createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  Set<int> randomlySelectedPerks;
  int numPerksToSelect = 4;
  String selectedType = 'survivor/';
  bool isSwitched = false;
  bool perkArraySelector = true;

  void generateRandomlySelectedPerks() {
    randomlySelectedPerks = Utils.generateSetOfRandomNumbers(numPerksToSelect, min: 1, max: perkList.length + 1);
  }

  List<Perk> perkList = returnSurvivor();

  @override
  void initState() {
    super.initState();
    generateRandomlySelectedPerks();
  }

  Future loadPerksFromPreferencesOrDefaults(bool value) async {
    selectedType = value ? 'killer/' : 'survivor/';
    var filteredList = await Utils.getList(selectedType.substring(0, selectedType.length - 1));
    setState(() {
      if (filteredList == null) {
        perkList = value ? returnKiller() : returnSurvivor();
      } else {
        perkList = filteredList;
      }
      generateRandomlySelectedPerks();
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
                    final returnedList = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuildConfiguration(killerPerks: perkList,survivorPerks: returnSurvivor()))
                    );
                    if (selectedType == 'survivor/') {
                      Utils.encodeList(returnedList, 'survivor');
                    } else {
                      Utils.encodeList(returnedList, 'killer');
                    }
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
                    child: PerkTile(
                        name: perkList[randomlySelectedPerks.elementAt(0) - 1].perkName,
                        iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(0)}.png'
                    ),
                  ),
                  Expanded(
                    child: PerkTile(
                        name: perkList[randomlySelectedPerks.elementAt(1) - 1].perkName,
                        iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(1)}.png'
                    ),
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
                      name: perkList[randomlySelectedPerks.elementAt(2) - 1].perkName,
                      iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(2)}.png'
                  ),
                ),
                Expanded(
                  child: PerkTile(
                      name: perkList[randomlySelectedPerks.elementAt(3) - 1].perkName,
                      iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(3)}.png'
                  ),
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
                      setState(() {
                        Utils.encodeList(
                            perkList, isSwitched ? 'killer' : 'survivor');
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
          ],
        ),
      ),
    );
  }
}