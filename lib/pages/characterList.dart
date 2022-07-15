import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:perklight/widgets/characterTile.dart';
import 'package:perklight/classes/character.dart';


class CharacterList extends StatelessWidget {
  CharacterList(arguments) :
    survivorDetails = arguments['survivorCharacterDetails'],
    killerDetails = arguments['killerCharacterDetails'];

  final List<Character> survivorDetails;
  final List<Character> killerDetails;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.pageTitleCharacters.toUpperCase()),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.survivor),
              Tab(text: l10n.killer),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              for (List<Character> characterList in [survivorDetails, killerDetails])
                  Scrollbar(
                    child: ListView(
                      children: <Widget>[
                        for (Character character in characterList)
                          CharacterTile(
                            name: character.name,
                            characterImage: character.imagePath,
                            description: character.description,
                          ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
