import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  ItemTile({@required this.name, this.description, @required this.imagePath});

  final String name;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 150,
      onTap: () async {
        await Navigator.pushNamed(
          context,
          '/itemInfo',
          arguments: {'name': name, 'ItemImage': imagePath, 'ItemDescription': description},
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.white12,
              child: Image.asset(
                imagePath,
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
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Icon(
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
