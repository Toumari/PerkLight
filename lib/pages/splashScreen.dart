import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  _navigateToHomePage() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  Timer initializeApp() {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, _navigateToHomePage);
  }

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/icon/icon.png', fit: BoxFit.fitWidth),
          CircularProgressIndicator()
        ]
      )
    );
  }
}