import 'dart:convert';
import 'package:flutter/material.dart';
import 'buildConfigurator.dart';
import 'package:flutter/services.dart';
import 'widgets/perk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utilities.dart' as Utils;




class PerkPage extends StatefulWidget {
  @override
  _PerkPageState createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  Set<int> randomlySelectedPerks;
  int numPerksToSelect = 4;
  
  int filterAmount=65;

  String selectedType = 'survivor/';
  bool isSwitched = false;
  bool perkArraySelector = true;
  List<Perk> appendedList;

  void generateRandomlySelectedPerks() {
    randomlySelectedPerks = Utils.generateSetOfRandomNumbers(numPerksToSelect, min: 1, max: perkDesc.length + 1);
  }

  List<Perk> perkDesc = returnSurvivor();

  @override
  void initState() {
    super.initState();
    generateRandomlySelectedPerks();
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
                  title: Center(child: Text('Perk Configuration',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0,color: Colors.white, decoration: TextDecoration.underline),)),
                  onTap: () async {
                    final returnedList = await Navigator.push(context,MaterialPageRoute(builder: (context) => BuildConfiguration(killerPerks: perkDesc,survivorPerks: returnSurvivor(),)));
                    if(selectedType == 'survivor/') {
                      setState(() {
                        perkDesc = returnedList;
                        filterAmount = perkDesc.length;
                      });
                      encodeList(perkDesc,'survivor');
                      print('saving survivor');
                    }
                    else {
                      setState(() {
                        perkDesc = returnedList;
                        filterAmount = perkDesc.length;
                      });
                      encodeList(perkDesc,'killer');
                      print('saving Killer');
                    }
                    print('${perkDesc[0].isEnabled}');
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
                      (perkDesc[randomlySelectedPerks.elementAt(0) - 1].perkName),
                      style: TextStyle(color: Colors.white),
                    ),
                    Image.asset(
                      'images/$selectedType${randomlySelectedPerks.elementAt(0)}.png',
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
                      (perkDesc[randomlySelectedPerks.elementAt(1) - 1].perkName),
                      style: TextStyle(color: Colors.white),
                    ),
                    Image.asset(
                      'images/$selectedType${randomlySelectedPerks.elementAt(1)}.png',
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
                    (perkDesc[randomlySelectedPerks.elementAt(2) - 1].perkName),
                    style: TextStyle(color: Colors.white),
                  ),
                  Image.asset(
                    'images/$selectedType${randomlySelectedPerks.elementAt(2)}.png',
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
                    (perkDesc[randomlySelectedPerks.elementAt(3) - 1].perkName),
                    style: TextStyle(color: Colors.white),
                  ),
                  Image.asset(
                    'images/$selectedType${randomlySelectedPerks.elementAt(3)}.png',
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
                  onChanged: (value) async {
                      setState(() {
                        isSwitched = value;
                        print(value);
                      });
                      if(value == true) {
                        selectedType = 'killer/';
                        if(appendedList == null ) {
                          appendedList = returnKiller();
                        }
                        else {
                          appendedList = perkDesc = await getList('killer');
                        }
                        filterAmount = appendedList.length;
                        setState(() {
                          generateRandomlySelectedPerks();
                          perkDesc = appendedList;
                        });
                      }
                      else {
                        selectedType = 'survivor/';
                        if(appendedList == null) {
                          appendedList = returnSurvivor();
                        } else {
                          appendedList = perkDesc = await getList('survivor');
                        }
                        filterAmount = appendedList.length;
                        setState(() {
                          generateRandomlySelectedPerks();
                          perkDesc = appendedList;
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
                  onPressed: ()  async {
                    if(!isSwitched) {
                      if(appendedList == null) {
                        appendedList = returnSurvivor();
                      } else {
                        appendedList = perkDesc = await getList('survivor');
                      }
                      setState(() {
                        generateRandomlySelectedPerks();
                        selectedType = 'survivor/';
                        filterAmount=perkDesc.length;
                        perkDesc = appendedList;
                        encodeList(perkDesc,'survivor');
                        getList('survivor');
                      });
                    }
                    else {
                      if(appendedList == null) {
                        appendedList = returnKiller();
                      }
                      else {
                        appendedList = perkDesc = await getList('killer');
                      }
                      setState(() {
                        generateRandomlySelectedPerks();
                        selectedType = 'killer/';
                        filterAmount = perkDesc.length;
                        perkDesc = appendedList;
                        encodeList(perkDesc,'killer');
                        getList('killer');
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

void encodeList(chosen,key) async {
  List<Perk> perks = chosen;
  final String perkKey = key;
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(perkKey, json.encode(perks));
  print('Ecoded and saved');
}

Future<List<Perk>> getList(key)async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  List<Perk> perks = [];
  json
      .decode(sp.getString(key))
      .forEach((map) => perks.add(new Perk.fromJson(map)));
  print(perks[0].perkName);
  print('got list');
  return perks;
//      .forEach(map) => perks.add(new Perk.fromJson(map));
}


//List<Perk> loadList()async {
//  final prefs = await SharedPreferences.getInstance();
//  var loadedList = prefs.getString('perk_list');
//  return loadedList;
//}

void main() {
  return runApp(MaterialApp(
    home: PerkPage(
  )));
}
