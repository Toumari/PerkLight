import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/perk.dart';


class BuildConfiguration extends StatefulWidget {

  final List<Perk> killerPerks;
  final List<Perk> survivorPerks;
  final bool lightModeDisabled;

  BuildConfiguration({Key key, @required this.killerPerks, @required this.survivorPerks, @required this.lightModeDisabled}) : super(key: key);

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
      backgroundColor: widget.lightModeDisabled ? Color(0xff21213b) : Colors.blueGrey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: widget.lightModeDisabled ? Color(0xff21213b) : Colors.blueGrey.shade100,
        title: Text('Perk List',style: TextStyle(color: widget.lightModeDisabled ? Colors.white : Colors.black),),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 200 ,
              child: ListView(
                children: <Widget>[
                  for(var item in widget.killerPerks)
                    CheckboxListTile(
                title: Text(item.perkName, style: TextStyle(color: widget.lightModeDisabled ? Colors.white : Colors.black),),
                      value: item.isEnabled,
                      onChanged: (bool value) {
                          setState(() {
                            widget.killerPerks[item.id].isEnabled = value;
                          });
                      },
      ),
                ],
              ),
            ),
            Container (
              width: double.infinity,
              child: FlatButton(onPressed: () {
                Navigator.pop(context, widget.killerPerks);
              }, child: Text('press me')),
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
