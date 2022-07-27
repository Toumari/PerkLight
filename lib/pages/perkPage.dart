import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:perklight/classes/perk.dart';
import 'package:perklight/classes/character.dart';
import 'package:perklight/classes/item.dart';
import 'package:perklight/classes/perkSerialiser.dart';
import 'package:perklight/utilities.dart' as Utils;
import 'package:perklight/widgets/perkTile.dart';

class PerkPage extends StatefulWidget {
  PerkPage(arguments)
      : killerPerks = arguments['killerPerks'],
        survivorPerks = arguments['survivorPerks'],
        survivorCharacterDetails = arguments['survivorCharacterDetails'],
        killerCharacterDetails = arguments['killerCharacterDetails'],
        firecrackerItemDetails = arguments['firecrackerItemDetails'],
        flashlightItemDetails = arguments['flashlightItemDetails'],
        keyItemDetails = arguments['keyItemDetails'],
        mapItemDetails = arguments['mapItemDetails'],
        medkitItemDetails = arguments['medkitItemDetails'],
        toolboxItemDetails = arguments['toolboxItemDetails'];

  final List<KillerPerk> killerPerks;
  final List<SurvivorPerk> survivorPerks;
  final List<Character> survivorCharacterDetails;
  final List<Character> killerCharacterDetails;
  final List<Item> firecrackerItemDetails;
  final List<Item> flashlightItemDetails;
  final List<Item> keyItemDetails;
  final List<Item> mapItemDetails;
  final List<Item> medkitItemDetails;
  final List<Item> toolboxItemDetails;

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
          child: ListView(
            children: <Widget>[
              Container(
                child: DrawerHeader(
                  child: Center(
                    child: Text(
                      'PerkLight',
                      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                child: ListTile(
                  title: Text(
                    'Perk Configuration',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
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
              Container(
                padding: EdgeInsets.all(24.0),
                child: ListTile(
                  title: Text(
                    'Character Profiles',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                    ),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/characters', arguments: {
                      'killerPerks': widget.killerPerks,
                      'survivorPerks': widget.survivorPerks,
                      'survivorCharacterDetails': widget.survivorCharacterDetails,
                      'killerCharacterDetails': widget.killerCharacterDetails
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                child: ListTile(
                  title: Text(
                    'Item Library',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                    ),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/items', arguments: {
                      'firecracker': widget.firecrackerItemDetails,
                      'flashlight': widget.flashlightItemDetails,
                      'key': widget.keyItemDetails,
                      'map': widget.mapItemDetails,
                      'medkit': widget.medkitItemDetails,
                      'toolbox': widget.toolboxItemDetails
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('PerkLight'),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
        child: Transform.scale(
          scale: 1.2,
          child: FloatingActionButton.extended(
            onPressed: () async {
              setState(() {
                _rollTileCallback(ALL_TILES, context);
              });
            },
            label: Text('Randomise'),
            icon: Icon(Icons.casino),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    Expanded(
                      child: Text(
                        'Survivor',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
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
                          }),
                    ),
                    Expanded(
                      child: Text(
                        'Killer',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: MediaQuery.of(context).size.height * 0.13)
            ]);
          })),
    );
  }
}
