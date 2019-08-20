import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities.dart' as Utils;
import '../widgets/perk.dart';


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

  void onSaveButtonPressed(BuildContext context) {
    int selectedKillerPerks = killerPerks.where((perk) => perk.isEnabled).toList().length;
    int selectedSurvivorPerks = survivorPerks.where((perk) => perk.isEnabled).toList().length;

    ScaffoldState scaffold = Scaffold.of(context);

    scaffold.removeCurrentSnackBar();

    if (selectedKillerPerks >= 4 && selectedSurvivorPerks >=4) {
      Navigator.pop(context, [killerPerks,survivorPerks]);
    }
    else if (selectedKillerPerks < 4 && selectedSurvivorPerks < 4) {
      scaffold.showSnackBar(SnackBar(content: Text('You must select at least 4 killer and at least 4 survivor perks')));
    }
    else if (selectedKillerPerks < 4) {
      scaffold.showSnackBar(SnackBar(content: Text('You must select at least 4 killer perks')));
    }
    else {
      scaffold.showSnackBar(SnackBar(content: Text('You must select at least 4 survivor perks')));
    }
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
          title: Text('Perk Configuration', style: TextStyle(color: Colors.white)),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return TabBarView(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView(
                        children: <Widget>[
                          for(var item in survivorPerks)
                            CheckboxListTile(
                              title: Text(item.perkName, style: TextStyle(color: Colors.white)),
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
                            onPressed: () => onSaveButtonPressed(context),
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
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView(
                        children: <Widget>[
                          for (var item in killerPerks)
                            CheckboxListTile(
                              title: Text(item.perkName, style: TextStyle(color: Colors.white)),
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
                            onPressed: () => onSaveButtonPressed(context),
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
            );
          }
        ),
      ),
    );
  }
}