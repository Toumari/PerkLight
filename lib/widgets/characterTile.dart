import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  CharacterTile(
      {@required this.name, this.description, @required this.characterImage});

  final String name;
  final String description;
  final String characterImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          '/characterInfo',
          arguments: {
            'name': name,
            'characterImage': characterImage,
            'characterDescription': description
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.white12,
              child: Image.asset(
                characterImage,
                height: 100,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                child: Text(
                  name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
