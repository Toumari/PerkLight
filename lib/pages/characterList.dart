import 'package:flutter/material.dart';
import '../widgets/characterTile.dart';
import '../classes/character.dart';

class CharacterList extends StatefulWidget {
  CharacterList(arguments)
      : survivorDetails = arguments['survivorCharacterDetails'],
        killerDetails = arguments['killerCharacterDetails'];

  final List<Character> survivorDetails;
  final List<Character> killerDetails;

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
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
                    for (var item in widget.survivorDetails)
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
                    for (var item in widget.killerDetails)
                      CharacterTile(
                        name: item.name,
                        characterImage: item.imagePath,
                        description: item.description,
                      ),
                    CharacterTile(
                      name: 'Danny "Jed Olsen" Johnson',
                      characterImage: 'assets/images/characters/Ghost.png',
                      description: 'Danny Johnson, known as Jed Olsen by some, grabbed the newspaper from the kitchen counter: it was a week old, but his face was on the front page, grainy and sunken. It was one of those muggy afternoons in Florida when heat and humidity permeated everything in the kitchen, making him sweat while standing still. He slouched in a damp chair to read. This article had better be good—his work in Roseville had been outstanding.',
                    )
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
