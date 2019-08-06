import 'package:flutter/material.dart';

class BuildConfiguration extends StatefulWidget {
  @override
  _BuildConfigurationState createState() => _BuildConfigurationState();
}

class _BuildConfigurationState extends State<BuildConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21213b),
      appBar: AppBar(
        backgroundColor: Color(0xff21213b),
        title: Text('Build Configuration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('COMING SOON',style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
