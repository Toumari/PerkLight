import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:perklight/classes/perk.dart';


class BuildConfiguration extends StatefulWidget {
  BuildConfiguration(arguments) :
    killerPerks = arguments['killerPerks'],
    survivorPerks = arguments['survivorPerks'];

  final List<Perk> killerPerks;
  final List<Perk> survivorPerks;

  @override
  _BuildConfigurationState createState() => _BuildConfigurationState();
}

class _BuildConfigurationState extends State<BuildConfiguration> {

  @override
  Widget build(BuildContext context) {

    AppLocalizations l10n = AppLocalizations.of(context);
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check_box),
                  onPressed: () {
                    final index = DefaultTabController.of(context).index;
                    if (index == 0) {
                      for (var item in widget.survivorPerks) {
                        setState(() {
                          item.preference.enabled = true;
                          item.savePreference();
                        });
                      }
                    }
                    else {
                      for(var item in widget.killerPerks) {
                        setState(() {
                          item.preference.enabled = true;
                          item.savePreference();
                        });
                      }
                    }
                  },
                )
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: l10n.survivor),
                  Tab(text: l10n.killer),
                ]
              ),
              title: Text(l10n.pageTitlePerks.toUpperCase()),
            ),
            body: Builder(
              builder: (BuildContext context) {
                return TabBarView(
                  children: [
                    ListView(
                      children: [
                        for(var item in widget.survivorPerks)
                          CheckboxListTile(
                            title: Text(item.name),
                            value: item.preference.enabled,
                            onChanged: (bool value) {
                              int selectedSurvivorPerks = widget.survivorPerks.where((perk) => perk.preference.enabled).toList().length;
                              if (!value && selectedSurvivorPerks - 1 < 4) {
                                scaffoldMessenger.removeCurrentSnackBar();
                                scaffoldMessenger.showSnackBar(SnackBar(content: Text('You cannot select less than 4 survivor perks')));
                                return;
                              }
                              setState(() {
                                item.preference.enabled = value;
                                item.savePreference();
                              });
                            },
                            secondary: IconButton(
                              icon: Image.asset(item.iconPath),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/details',
                                  arguments: item
                                );
                              }
                            )
                          ),
                      ],
                    ),
                    ListView(
                      children: [
                        for (var item in widget.killerPerks)
                          CheckboxListTile(
                            title: Text(item.name),
                            value: item.preference.enabled,
                            onChanged: (bool value) {
                              int selectedKillerPerks = widget.killerPerks.where((perk) => perk.preference.enabled).toList().length;
                              if (!value && selectedKillerPerks - 1 < 4) {
                                scaffoldMessenger.removeCurrentSnackBar();
                                scaffoldMessenger.showSnackBar(SnackBar(content: Text('You cannot select less than 4 killer perks')));
                                return;
                              }
                              setState(() {
                                item.preference.enabled = value;
                                item.savePreference();
                              });
                            },
                            secondary: IconButton(
                              icon: Image.asset(item.iconPath),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/details',
                                  arguments: item
                                );
                              }
                            )
                          ),
                      ],
                    ),
                  ],
                );
              }
            ),
          );
        }
      ),
    );
  }
}
