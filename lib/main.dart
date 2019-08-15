// Built-ins
import 'dart:convert';

// Third-party
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// First-party
import 'buildConfigurator.dart';
import 'utilities.dart' as Utils;
import 'widgets/perk.dart';
import 'widgets/perkTile.dart';

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
  bool lightModeDisabled = false;

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
    var filteredList = await getList(selectedType.substring(0, selectedType.length - 1));
    setState(() {
      if (filteredList == null) {
        perkList = value ? returnKiller() : returnSurvivor();
      } else {
        perkList = filteredList;
      }
      generateRandomlySelectedPerks();
    });
  }

  Color themeSelection() {
    var colorSelected;
    lightModeDisabled ? colorSelected = Color(0xff21213b) : colorSelected = Colors.blueGrey.shade100;
    return colorSelected;
  }

  @override
  Widget build(BuildContext context) {




    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'PerkLight',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: lightModeDisabled ? Colors.white : Colors.black,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: themeSelection()),
            ),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                ListTile(
                  title: Text(
                      'Perk Configuration',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0,
                        color: Colors.black,
                      ),
                  ),
                  onTap: () async {
                    final returnedList = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuildConfiguration(killerPerks: perkList,survivorPerks: returnSurvivor(),lightModeDisabled: lightModeDisabled))
                    );
                    if (selectedType == 'survivor/') {
                      encodeList(returnedList, 'survivor');
                      print('saving survivor');
                    } else {
                      encodeList(returnedList, 'killer');
                      print('saving Killer');
                    }
                    print('${returnedList[0].isEnabled}');
                  },
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Dark Theme'),
                    Transform.scale(
                      scale: 1.2,
                      child: Switch(
                          value: lightModeDisabled, onChanged: (newValue) {
                            setState(()
                            {lightModeDisabled = newValue;});
                      }),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
      backgroundColor: themeSelection(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: lightModeDisabled ? Colors.white : Colors.black ),
        title: Text('PerkLight' ,style: TextStyle(color: lightModeDisabled ? Colors.white : Colors.black,),),
        backgroundColor: themeSelection(),
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
                      iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(0)}.png',
                      textColor: lightModeDisabled ? Colors.white : Colors.black,
                    ),
                  ),
                  Expanded(
                    child: PerkTile(
                      name: perkList[randomlySelectedPerks.elementAt(1) - 1].perkName,
                      iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(1)}.png',
                      textColor: lightModeDisabled ? Colors.white : Colors.black,
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
                    iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(2)}.png',
                    textColor: lightModeDisabled ? Colors.white : Colors.black,
                  ),
                ),
                Expanded(
                  child: PerkTile(
                    name: perkList[randomlySelectedPerks.elementAt(3) - 1].perkName,
                    iconPath: 'images/$selectedType${randomlySelectedPerks.elementAt(3)}.png',
                    textColor: lightModeDisabled ? Colors.white : Colors.black,
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
                  style: TextStyle(fontSize: 22.0, color: lightModeDisabled ? Colors.white : Colors.black,),
                ),
                Transform.scale(
                  scale: 1.5,
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) async {
                      setState(() {
                        isSwitched = value;
                        print(value);
                      });
                      loadPerksFromPreferencesOrDefaults(value);
                    },
                    activeTrackColor: Colors.redAccent,
                    activeColor: Colors.black,
                  ),
                ),
                Text(
                  'Killer',
                  style: TextStyle(fontSize: 22.0, color: lightModeDisabled ? Colors.white : Colors.black,),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment(0, 1),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: FlatButton(
                    onPressed: () async {
                      loadPerksFromPreferencesOrDefaults(isSwitched);
                      setState(() {
                        encodeList(
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

void encodeList(chosen, key) async {
  List<Perk> perks = chosen;
  final String perkKey = key;
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(perkKey, json.encode(perks));
  print('Ecoded and saved');
}

Future<List<Perk>> getList(key) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  var stringPreference = sp.get(key);
  if (stringPreference == null) {
    return null;
  }
  List<Perk> perks = [];
  json
      .decode(stringPreference)
      .forEach((map) => perks.add(new Perk.fromJson(map)));
  print(perks[0].perkName);
  print('got list');
  return perks;
}

void main() {
  return runApp(MaterialApp(home: PerkPage()));
}
