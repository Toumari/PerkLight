import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:perklight/classes/perk.dart';
import 'package:perklight/classes/character.dart';
import 'package:perklight/classes/item.dart';
import 'package:perklight/classes/perkSerialiser.dart';
import 'package:perklight/utilities.dart' as Utils;
import 'package:perklight/widgets/buildDisplay.dart';
import 'package:perklight/widgets/navigationDrawer.dart';


class PerkPage extends StatefulWidget {

  final List<KillerPerk> killerPerks;
  final List<SurvivorPerk> survivorPerks;
  final List<Character> killerCharacterDetails;
  final List<Character> survivorCharacterDetails;
  final List<Item> keyItemDetails;
  final List<Item> mapItemDetails;
  final List<Item> medkitItemDetails;
  final List<Item> toolboxItemDetails;
  final List<Item> craftableItemDetails;
  final List<Item> flashlightItemDetails;
  final List<Item> firecrackerItemDetails;

  PerkPage(arguments) :
    killerPerks = arguments['killerPerks'],
    survivorPerks = arguments['survivorPerks'],
    killerCharacterDetails = arguments['killerCharacterDetails'],
    survivorCharacterDetails = arguments['survivorCharacterDetails'],
    keyItemDetails = arguments['keyItemDetails'],
    mapItemDetails = arguments['mapItemDetails'],
    medkitItemDetails = arguments['medkitItemDetails'],
    toolboxItemDetails = arguments['toolboxItemDetails'],
    craftableItemDetails = arguments['craftableItemDetails'],
    flashlightItemDetails = arguments['flashlightItemDetails'],
    firecrackerItemDetails = arguments['firecrackerItemDetails'];

  @override
  _PerkPageState createState() => _PerkPageState();
}


class _PerkPageState extends State<PerkPage> {
  static const numPerksToSelect = 4;
  static const ALL_TILES = [0, 1, 2, 3];

  Image backgroundImage;

  bool perkModeSwitch = false;

  List<int> randomlySelectedPerks1;
  List<int> randomlySelectedPerks2;
  PerkType perkMode = PerkType.survivor;

  String buildId;

  List<Perk> rollablePerks;

  // Perks currently selected and displayed in the UI
  List<Perk> selectedPerksSurvivor;
  List<Perk> selectedPerksKiller;

  @override
  void initState() {
    super.initState();
    filteredRoll();
    backgroundImage = Image.asset('assets/images/background.jpg');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(backgroundImage.image, context);
  }

  void filteredRoll([List<int> indexes = ALL_TILES]) {
    filterRollable();
    rollPerks(indexes);
  }

  void generateShareCode() {
    List<String> selectedPerksIds = selectedPerksSurvivor.map((item) => item.id).toList();
    buildId = PerksSerialiser.encode(perksIds: selectedPerksIds, perkType: perkMode);
  }

  void filterRollable() {
    List<Perk> listToFilter = perkMode == PerkType.killer
      ? widget.killerPerks
      : widget.survivorPerks;

    rollablePerks = listToFilter.where((perk) => perk.preference.enabled).toList();
    randomlySelectedPerks1 = Utils.generateSetOfRandomNumbers(numPerksToSelect, max: rollablePerks.length);
    randomlySelectedPerks2 = Utils.generateSetOfRandomNumbers(numPerksToSelect, max: rollablePerks.length);
  }

  void rollPerks([List<int> indexes = ALL_TILES]) {
    randomlySelectedPerks1 = Utils.replaceIndexValue(randomlySelectedPerks1, indexes, max: rollablePerks.length);
    randomlySelectedPerks2 = Utils.replaceIndexValue(randomlySelectedPerks2, indexes, max: rollablePerks.length);
    selectedPerksSurvivor = randomlySelectedPerks1.map((item) => rollablePerks[item]).toList();
    selectedPerksKiller = randomlySelectedPerks2.map((item) => rollablePerks[item]).toList();
    generateShareCode();
  }

  void rollTileCallback(List<int> indexes, BuildContext context) {
    if (rollablePerks.length <= numPerksToSelect) {
      String mode = describeEnum(perkMode);
      String message = 'You cannot reroll with only 4 $mode perks selected';

      ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.removeCurrentSnackBar();
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));

      return;
    }

    setState(() {
      rollPerks(indexes);
    });
  }

  @override
  Widget build(BuildContext context) {

    AppLocalizations l10n = AppLocalizations.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text(l10n.pageTitleBuild.toUpperCase()),
          actions: [
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.survivor),
              Tab(text: l10n.killer),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            setState(() {
              rollTileCallback(ALL_TILES, context);
            });
          },
          label: Text(l10n.randomise),
          icon: Icon(Icons.casino),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Color.fromARGB(Color.getAlphaFromOpacity(0.7), 0, 0, 0),
                BlendMode.color
              ),
              fit: BoxFit.cover,
              image: backgroundImage.image,
            ),
          ),
          child: TabBarView(
            children: [
              BuildDisplay(rollTileCallback: rollTileCallback, selectedPerks: selectedPerksSurvivor),
              BuildDisplay(rollTileCallback: rollTileCallback, selectedPerks: selectedPerksKiller),
            ],
          ),
        ),
      ),
    );
  }
}
