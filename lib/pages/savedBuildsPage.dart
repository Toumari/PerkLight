import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SavedBuildsPage extends StatefulWidget {
  SavedBuildsPage(Map<String, dynamic> args) :
    savedBuilds = args['savedBuilds'];

  final List<String> savedBuilds;

  @override
  _SavedBuildsPageState createState() => _SavedBuildsPageState();
}

class _SavedBuildsPageState extends State<SavedBuildsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Builds')
      ),
      body: ListView(
        children: <Widget>[
          for (String buildId in widget.savedBuilds)
            ListTile(
              title: Text(buildId),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.savedBuilds.remove(buildId);
                  });
                },
              )
            )
        ],
      )
    );
  }
}