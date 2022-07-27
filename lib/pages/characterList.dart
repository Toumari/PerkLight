import 'package:flutter/material.dart';

import 'package:perklight/widgets/characterTile.dart';
import 'package:perklight/classes/character.dart';

class CharacterList extends StatelessWidget {
  CharacterList(arguments)
      : survivorDetails = arguments['survivorCharacterDetails'],
        killerDetails = arguments['killerCharacterDetails'];

  final List<Character> survivorDetails;
  final List<Character> killerDetails;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Character Profiles'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Survivor'),
              Tab(text: 'Killer'),
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
