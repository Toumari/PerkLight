import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/perk.dart';


class BuildConfiguration extends StatefulWidget {
  BuildConfiguration(arguments) :
    killerPerks = arguments['killerPerks'],
    survivorPerks = arguments['survivorPerks'];

  final List<Perk> killerPerks;
  final List<Perk> survivorPerks;

  @override
  _BuildConfigurationState createState() => _BuildConfigurationState();
}

class _BuildConfigurationState extends State<BuildConfiguration> {

  @override
  void initState() {
    super.initState();
  }

  void onSaveButtonPressed(BuildContext context) {
    int selectedKillerPerks = widget.killerPerks.where((perk) => perk.preference.enabled).toList().length;
    int selectedSurvivorPerks = widget.survivorPerks.where((perk) => perk.preference.enabled).toList().length;

    ScaffoldState scaffold = Scaffold.of(context);

    scaffold.removeCurrentSnackBar();

    if (selectedKillerPerks >= 4 && selectedSurvivorPerks >=4) {
      for (Perk perk in widget.killerPerks) {
        perk.savePreference();
      }
      for (Perk perk in widget.survivorPerks) {
        perk.savePreference();
      }
      Navigator.pop(context);
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
                          for(var item in widget.survivorPerks)
                            CheckboxListTile(
                              title: Text(item.name, style: TextStyle(color: Colors.white)),
                              value: item.preference.enabled,
                              onChanged: (bool value) {
                                setState(() {
                                  item.preference.enabled = value;
                                  item.savePreference();
                                });
                              },
                              secondary: IconButton(
                                icon: Image.asset('assets/images/survivor/${item.iconFilename}',color: Colors.white),
                                onPressed: () {}
                              )
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
                          for (var item in widget.killerPerks)
                            CheckboxListTile(
                              title: Text(item.name, style: TextStyle(color: Colors.white)),
                              value: item.preference.enabled,
                              onChanged: (bool value) {
                                setState(() {
                                  item.preference.enabled = value;
                                  item.savePreference();
                                });
                              },
                              secondary: IconButton(
                                icon: Image.asset('assets/images/killer/${item.iconFilename}', color: Colors.white),
                                onPressed: () {}
                              )
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
