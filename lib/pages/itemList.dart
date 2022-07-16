import 'package:flutter/material.dart';
import '../classes/item.dart';
import 'package:perklight/widgets/characterTile.dart';

class ItemList extends StatelessWidget {
  ItemList(arguments) :
      firecrackerItems = arguments['firecracker'],
      flashlightItems = arguments['flashlight'],
      keyItems = arguments['key'],
      mapItems = arguments['map'],
      medkitItems = arguments['medkit'],
      toolboxItems = arguments['toolbox'];

  final List<Item> firecrackerItems;
  final List<Item> flashlightItems;
  final List<Item> keyItems;
  final List<Item> mapItems;
  final List<Item> medkitItems;
  final List<Item> toolboxItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Library'),
        ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            for( List<Item> itemList in [flashlightItems,keyItems,mapItems,medkitItems,toolboxItems])
            for (Item item in itemList)
              CharacterTile(
                name: item.name,
                characterImage: item.imagePath,
                description: item.description,
              ),
          ],
        ),
      ),
    );
  }
}
