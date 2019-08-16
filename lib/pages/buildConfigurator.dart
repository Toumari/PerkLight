import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/perk.dart';
import '../utilities.dart' as Utils;


class BuildConfiguration extends StatefulWidget {
  @override
  _BuildConfigurationState createState() => _BuildConfigurationState();
}

class _BuildConfigurationState extends State<BuildConfiguration> {

  List<Perk> killerPerks = returnKiller();
  List<Perk> survivorPerks = returnSurvivor();

  @override
  void initState() {
    super.initState();

    void loadList() async {
      var survivorListLoad = await Utils.getList('survivor') ?? returnSurvivor();
      var killerListLoad = await Utils.getList('killer') ?? returnKiller();
      setState(() {
        killerPerks = killerListLoad;
        survivorPerks = survivorListLoad;
      });
    }
    loadList();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff21213b),
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(text: 'Survivor'),
            Tab(text: 'Killer'),
          ]),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff21213b),
          title: Text('Perk Configuration',style: TextStyle(color: Colors.white),),
        ),
        body: TabBarView(
          children: [
            Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 200 ,
                child: ListView(
                  children: <Widget>[
                    for(var item in survivorPerks)
                      CheckboxListTile(
                        title: Text(item.perkName, style: TextStyle(color: Colors.white),),
                        value: item.isEnabled,
                        onChanged: (bool value) {
                            setState(() {
                              survivorPerks[item.id].isEnabled = value;
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
                        Navigator.pop(context, [killerPerks,survivorPerks]);
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
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 200 ,
                  child: ListView(
                    children: <Widget>[
                      for(var item in killerPerks)
                        CheckboxListTile(
                          title: Text(item.perkName, style: TextStyle(color: Colors.white),),
                          value: item.isEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              killerPerks[item.id].isEnabled = value;
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
                          Navigator.pop(context, [killerPerks,survivorPerks]);
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
          ],

        ),
      ),
    );
  }
}

