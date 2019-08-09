import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/perk.dart';


class BuildConfiguration extends StatefulWidget {

  final List<Perk> perks;

  BuildConfiguration({Key key, @required this.perks}) : super(key: key);

  @override
  _BuildConfigurationState createState() => _BuildConfigurationState();
}

class _BuildConfigurationState extends State<BuildConfiguration> {

  @override
  Widget build(BuildContext context) {


    var list = returnAll();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        backgroundColor: Color(0xff21213b),
        title: Text('Perk List',style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            for(var item in list)
              ListTile(
          title: Text(item.perkName, style: TextStyle(color: Colors.white),) ,
      )

          ],
        ),
        ),
    );
  }
}


//ListTile(
//leading: Icon(Icons.map, color: Colors.white,),
//title: Text(item, style: TextStyle(color: Colors.white),),
//onTap: () {print('tapped');},
//),
