import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SavedBuildsPage extends StatelessWidget {
  SavedBuildsPage(Map<String, dynamic> args) :
    savedBuilds = args['savedBuilds'];

  final List<String> savedBuilds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Builds')
      ),
      body: ListView(
        children: <Widget>[
          for (String buildId in savedBuilds)
            ListTile(
              title: Text(buildId),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  savedBuilds.remove(buildId);
                },
              )
            )
        ],
      )
    );
  }
}