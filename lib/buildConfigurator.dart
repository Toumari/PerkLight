import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/perk.dart';


class BuildConfiguration extends StatefulWidget {

  final List<Perk> killerPerks;
  final List<Perk> survivorPerks;

  BuildConfiguration({Key key, @required this.killerPerks, @required this.survivorPerks}) : super(key: key);

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
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff21213b),
        title: Text('Perk Configuration',style: TextStyle(color: Colors.white),),
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
                title: Text(item.perkName, style: TextStyle(color: Colors.white),),
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
            Expanded(
              child: Container(
                alignment: Alignment(0, 1),
                child: SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context, widget.killerPerks);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
    );
  }
}

