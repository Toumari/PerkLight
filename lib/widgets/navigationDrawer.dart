import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:perklight/classes/character.dart';
import 'package:perklight/classes/item.dart';
import 'package:perklight/classes/perk.dart';

class NavigationDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          children: [
            ListTile(
              title: Text(
                'PerkLight',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Divider(thickness: 1.0),
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text(l10n.pageTitleSavedBuilds),
              onTap: () async {
              }
            ),
            ListTile(
              leading: Icon(Icons.check_box_outlined),
              title: Text(l10n.pageTitlePerks),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/builder',
                  arguments: {
                    'killerPerks': <Perk>[],
                    'survivorPerks': <Perk>[],
                  },
                );
                // setState(() {
                // _filteredRoll();
                // });
              }
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text(l10n.pageTitleCharacters),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/characters',
                  arguments: {
                    'killerPerks': [],
                    'survivorPerks': [],
                    'survivorCharacterDetails': <Character>[],
                    'killerCharacterDetails': <Character>[],
                  }
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.medical_services_outlined),
              title: Text(l10n.pageTitleItems),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/items',
                  arguments: {
                    'craftables': <Item>[],
                    'firecrackers': <Item>[],
                    'flashlights': <Item>[],
                    'keys' : <Item>[],
                    'maps' : <Item>[],
                    'medkits' : <Item>[],
                    'toolboxes' : <Item>[]
                  }
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text(l10n.pageTitleAbout),
              onTap: () async {
              }
            ),

            //   title: const Text('Perk Configuration'),
            //   onTap: () async {
            //     // await Navigator.pushNamed(
            //     //   context,
            //     //   '/builder',
            //     //   arguments: {
            //     //     'killerPerks': widget.killerPerks,
            //     //     'survivorPerks': widget.survivorPerks
            //     //   }
            //     // );
            //     // setState(() {
            //     // _filteredRoll();
            //     // });
            //   },

            //   title: const Text('Character Profiles'),
            //   onTap: () async {
            //     // await Navigator.pushNamed(
            //     //   context,
            //     //   '/characters',
            //     //   arguments: {
            //     //     'killerPerks': widget.killerPerks,
            //     //     'survivorPerks': widget.survivorPerks,
            //     //     'survivorCharacterDetails' : widget.survivorCharacterDetails,
            //     //     'killerCharacterDetails' : widget.killerCharacterDetails
            //     //   }
            //     // );
            //   },

            //   title: const Text('Item Library'),
            //   onTap: () async {
            //     // await Navigator.pushNamed(
            //     //   context,
            //     //   '/items',
            //     //   arguments: {
            //     //     'craftables': widget.craftableItemDetails,
            //     //     'firecrackers': widget.firecrackerItemDetails,
            //     //     'flashlights': widget.flashlightItemDetails,
            //     //     'keys' : widget.keyItemDetails,
            //     //     'maps' : widget.mapItemDetails,
            //     //     'medkits' : widget.medkitItemDetails,
            //     //     'toolboxes' : widget.toolboxItemDetails
            //     //   }
            //     // );
            //   },

            //   title: const Text('Saved Builds'),
            //   onTap: () async {
            //     // await Navigator.pushNamed(
            //     //   context,
            //     //   '/items',
            //     //   arguments: {
            //     //     'craftables': widget.craftableItemDetails,
            //     //     'firecrackers': widget.firecrackerItemDetails,
            //     //     'flashlights': widget.flashlightItemDetails,
            //     //     'keys' : widget.keyItemDetails,
            //     //     'maps' : widget.mapItemDetails,
            //     //     'medkits' : widget.medkitItemDetails,
            //     //     'toolboxes' : widget.toolboxItemDetails
            //     //   }
            //     // );
            //   },
          ],
        ),
      ),
    );
  }
}
