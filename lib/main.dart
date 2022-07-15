import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:perklight/router.dart' as router;
import 'package:perklight/themes/dark.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  PerkLight app = PerkLight();
  runApp(app);
}

class PerkLight extends StatefulWidget {
  @override
  _PerkLightState createState() => _PerkLightState();
}

class _PerkLightState extends State<PerkLight> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PerkLight',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      theme: darkTheme,
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}
