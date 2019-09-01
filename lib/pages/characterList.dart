import 'package:flutter/material.dart';
import '../widgets/characterTile.dart';
import '../classes/character.dart';

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
        backgroundColor: Color(0xff21213b),
        appBar: AppBar(
          title: Text('Character Profiles'),
          backgroundColor: Color(0xff21213b),
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
              Scrollbar(
                child: ListView(
                  children: <Widget>[
                    for (var item in survivorDetails)
                      CharacterTile(
                        name: item.name,
                        characterImage: item.imagePath,
                        description: item.description,
                      ),
                  ],
                ),
              ),
              Scrollbar(
                child: ListView(
                  children: <Widget>[
                    for (var item in killerDetails)
                      CharacterTile(
                        name: item.name,
                        characterImage: item.imagePath,
                        description: item.description,
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