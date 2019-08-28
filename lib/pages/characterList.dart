import 'package:flutter/material.dart';
import '../widgets/characterTile.dart';

class CharacterList extends StatefulWidget {
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
          bottom: TabBar(tabs: [
            Tab(text: 'Survivor'),
            Tab(text: 'Killer'),
          ]),
        ),
        body: SafeArea(
          child: TabBarView(children: <Widget>[
            Scrollbar(
              child: ListView(
                children: <Widget>[
                  CharacterTile(
                      name: 'Dwight Fairfield',
                      description: "Nervous Leader",
                      characterImage: 'assets/images/characters/Dwight.png'),
                  CharacterTile(
                      name: 'Meg Thomas',
                      description: "Energetic Athlete",
                      characterImage: 'assets/images/characters/Meg.png'),
                  CharacterTile(
                      name: 'Claudette Morel',
                      description: "Studious Botanist",
                      characterImage: 'assets/images/characters/Claudette.png'),
                  CharacterTile(
                      name: 'Jake Park',
                      description: "Solitary Survivalist",
                      characterImage: 'assets/images/characters/Jake.png'),
                  CharacterTile(
                      name: 'Nea Karlsson',
                      description: "Urban Artist",
                      characterImage: 'assets/images/characters/Nea.png'),
                  CharacterTile(
                      name: 'Laurie Strode',
                      description: "Determined Survivor",
                      characterImage: 'assets/images/characters/Laurie.png'),
                  CharacterTile(
                      name: 'Ace Visconti',
                      description: "Lucky Gambler",
                      characterImage: 'assets/images/characters/Ace.png'),
                  CharacterTile(
                      name: 'William "Bill" Overbeck',
                      description: "Old Soldier",
                      characterImage: 'assets/images/characters/Bill.png'),
                  CharacterTile(
                      name: 'Feng Min',
                      description: "Focused Competitor",
                      characterImage: 'assets/images/characters/Feng.png'),
                  CharacterTile(
                      name: 'David King',
                      description: "Rugged Scrapper",
                      characterImage: 'assets/images/characters/David.png'),
                  CharacterTile(
                      name: 'Quentin Smith',
                      description: "Resolute Dreamwalker",
                      characterImage: 'assets/images/characters/Quentin.png'),
                  CharacterTile(
                      name: 'Detective Tapp',
                      description: "Obsessed Detective",
                      characterImage: 'assets/images/characters/DavidT.png'),
                  CharacterTile(
                      name: 'Kate Denson',
                      description: "Hopeful Songbird",
                      characterImage: 'assets/images/characters/Kate.png'),
                  CharacterTile(
                      name: 'Adam Francis',
                      description: "Resourceful Teacher",
                      characterImage: 'assets/images/characters/Adam.png'),
                  CharacterTile(
                      name: 'Jeffrey "Jeff" Johansen',
                      description: "Quiet Artist",
                      characterImage: 'assets/images/characters/Jeff.png'),
                  CharacterTile(
                      name: 'Jane Romero',
                      description: "Influential Celebrity",
                      characterImage: 'assets/images/characters/Jane.png'),
                  CharacterTile(
                      name: 'Ashley "Ash" Joanna Williams',
                      description: "Influential Celebrity",
                      characterImage: 'assets/images/characters/Ashley.png'),
                ],
              ),
            ),
            Scrollbar(
              child: ListView(
                children: <Widget>[
                  CharacterTile(
                      name: 'The Trapper',
                      description: "Evan MacMillan",
                      characterImage: 'assets/images/characters/Trapper.png'),
                  CharacterTile(
                      name: 'The Wraith',
                      description: "Philip Ojomo",
                      characterImage: 'assets/images/characters/Wraith.png'),
                  CharacterTile(
                      name: 'The Hillbilly',
                      description: "Max Thompson Jr.",
                      characterImage: 'assets/images/characters/Hillbilly.png'),
                  CharacterTile(
                      name: 'The Nurse',
                      description: "Sally Smithson",
                      characterImage: 'assets/images/characters/Nurse.png'),
                  CharacterTile(
                      name: 'The Shape',
                      description: "Michael Myers",
                      characterImage: 'assets/images/characters/Shape.png'),
                  CharacterTile(
                      name: 'The Hag',
                      description: "Lisa Sherwood",
                      characterImage: 'assets/images/characters/Hag.png'),
                  CharacterTile(
                      name: 'The Doctor',
                      description: "Herman Carter",
                      characterImage: 'assets/images/characters/Doctor.png'),
                  CharacterTile(
                      name: 'The Huntress',
                      description: "Anna",
                      characterImage: 'assets/images/characters/Huntress.png'),
                  CharacterTile(
                      name: 'The Cannibal',
                      description: "Bubba Sawyer",
                      characterImage: 'assets/images/characters/Cannibal.png'),
                  CharacterTile(
                      name: 'The Nightmare',
                      description: "Frederick 'Freddy' Charles Krueger",
                      characterImage: 'assets/images/characters/Freddy.png'),
                  CharacterTile(
                      name: 'The Pig',
                      description: "Amanda Young",
                      characterImage: 'assets/images/characters/Pig.png'),
                  CharacterTile(
                      name: 'The Clown',
                      description: "Kenneth 'Jeffrey Hawk' Chase",
                      characterImage: 'assets/images/characters/Clown.png'),
                  CharacterTile(
                      name: 'The Spirit',
                      description: "Rin Yamaoka",
                      characterImage: 'assets/images/characters/Spirit.png'),
                  CharacterTile(
                      name: 'The Legion',
                      description: "F. J. S. J.",
                      characterImage: 'assets/images/characters/Legion.png'),
                  CharacterTile(
                      name: 'The Plague',
                      description: "Adiris",
                      characterImage: 'assets/images/characters/Plague.png'),
                  CharacterTile(
                      name: 'The Ghost Face',
                      description: "Danny 'Jed Olsen' Johnson",
                      characterImage: 'assets/images/characters/Ghost.png'),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
