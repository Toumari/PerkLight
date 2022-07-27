import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:perklight/classes/character.dart';
import 'package:perklight/classes/item.dart';
import 'package:perklight/classes/perk.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer(arguments)
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
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      const DrawerHeader(child: Text('PerkLight')),
      Expanded(
          child: ListView(padding: EdgeInsets.zero, children: [
        ListTile(
            title: Text('Perk Configuration'),
            onTap: () async {
              await Navigator.pushNamed(context, '/builder',
                  arguments: {'killerPerks': this.killerPerks, 'survivorPerks': this.survivorPerks});
            }),
        ListTile(
            title: Text('Character Profiles'),
            onTap: () async {
              await Navigator.pushNamed(context, '/characters', arguments: {
                'survivorCharacterDetails': this.survivorCharacterDetails,
                'killerCharacterDetails': this.killerCharacterDetails
              });
            }),
        ListTile(
            title: Text('Item Library'),
            onTap: () async {
              await Navigator.pushNamed(context, '/items', arguments: {
                'firecracker': this.firecrackerItemDetails,
                'flashlight': this.flashlightItemDetails,
                'key': this.keyItemDetails,
                'map': this.mapItemDetails,
                'medkit': this.medkitItemDetails,
                'toolbox': this.toolboxItemDetails
              });
            }),
      ]))
    ]));
  }
}
