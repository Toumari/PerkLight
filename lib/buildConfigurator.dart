import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BuildConfiguration extends StatefulWidget {

  final List perks;

  BuildConfiguration({Key key, @required this.perks}) : super(key: key);

  @override
  _BuildConfigurationState createState() => _BuildConfigurationState();
}

class _BuildConfigurationState extends State<BuildConfiguration> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        backgroundColor: Color(0xff21213b),
        title: Text('Build Configuration'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            for(var item in widget.perks)
            ListTile(
              leading: Icon(Icons.map, color: Colors.white,),
              title: Text(item, style: TextStyle(color: Colors.white),),
              onTap: () {print('tapped');},
            ),
          ],
        ),
        ),
    );
  }
}
