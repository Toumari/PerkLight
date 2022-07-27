// Third-party
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// First-party
import 'package:perklight/utilities.dart' as Utils;

import 'package:perklight/classes/perk.dart';
import 'package:perklight/widgets/perkTile.dart';
import 'package:perklight/classes/perkSerialiser.dart';

class PerkPage extends StatefulWidget {
  PerkPage(arguments)
      : killerPerks = arguments['killerPerks'],
        survivorPerks = arguments['survivorPerks'];

  final List<KillerPerk> killerPerks;
  final List<SurvivorPerk> survivorPerks;

  @override
  _PerkPageState createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  static const numPerksToSelect = 4;
  static const ALL_TILES = [0, 1, 2, 3];

  bool perkModeSwitch = false;

  List<int> randomlySelectedPerks;
  PerkType perkMode = PerkType.survivor;

  String buildId;

  List<Perk> rollablePerks;
  List<Perk> selectedPerks;

  @override
  void initState() {
    super.initState();

    _filteredRoll();
  }

  void _filteredRoll([List<int> indexes = ALL_TILES]) {
    _filterRollable();
    _rollPerks(indexes);
  }

  void _generateShareCode() {
    List<int> selectedPerksIds = selectedPerks.map((item) => item.id).toList();
    buildId = PerksSerialiser.encode(perksIds: selectedPerksIds, perkType: perkMode);

    print('Build ID: $buildId');
  }

  void _filterRollable() {
    List<Perk> listToFilter;

    switch (perkMode) {
      case PerkType.killer:
        listToFilter = widget.killerPerks;
        break;
      case PerkType.survivor:
        listToFilter = widget.survivorPerks;
        break;
    }

    rollablePerks = listToFilter.where((perk) {
      return perk.preference.enabled;
    }).toList();

    randomlySelectedPerks = Utils.generateSetOfRandomNumbers(numPerksToSelect, max: rollablePerks.length);
  }

  void _rollPerks([List<int> indexes = ALL_TILES]) {
    randomlySelectedPerks = Utils.replaceIndexValue(randomlySelectedPerks, indexes, max: rollablePerks.length);
    selectedPerks = randomlySelectedPerks.map((item) => rollablePerks[item]).toList();

    _generateShareCode();
  }

  void _rollTileCallback(List<int> indexes, BuildContext context) {
    // Check if randomlySelectedPerks is less than or equal to rollablePerks
    if (rollablePerks.length <= numPerksToSelect) {
      String mode = describeEnum(perkMode);
      String message = 'You cannot reroll with only 4 $mode perks selected';

      ScaffoldState scaffold = Scaffold.of(context);
      scaffold.removeCurrentSnackBar();
      scaffold.showSnackBar(SnackBar(content: Text(message)));

      return;
    }

    setState(() {
      _rollPerks(indexes);
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
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.white))),
                child: DrawerHeader(
                  child: Center(
                    child: Text(
                      'PerkLight',
                      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
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
                    await Navigator.pushNamed(context, '/builder',
                        arguments: {'killerPerks': widget.killerPerks, 'survivorPerks': widget.survivorPerks});
                    setState(() {
                      _filteredRoll();
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
          child: Builder(builder: (BuildContext context) {
            return Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Container(height: 24.0),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 20.0,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: <Widget>[
                    for (int i = 0; i < randomlySelectedPerks.length; ++i)
                      Container(child: PerkTile(perk: selectedPerks[i], index: i, onChanged: _rollTileCallback))
                  ],
                ),
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
                        value: perkModeSwitch,
                        onChanged: (value) async {
                          setState(() {
                            perkModeSwitch = value;

                            perkMode = !perkModeSwitch ? PerkType.survivor : PerkType.killer;
                            _filteredRoll();
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
              Container(
                alignment: Alignment(0, 1),
                child: SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: FlatButton(
                    onPressed: () async {
                      setState(() {
                        _rollTileCallback(ALL_TILES, context);
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
            ]);
          })),
    );
  }
}
